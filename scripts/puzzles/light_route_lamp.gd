extends Node3D
class_name LightRouteLamp

signal interaction_requested(lamp: LightRouteLamp, player: Node)

const WORLD_PROMPT_SCENE := preload("res://scenes/ui/WorldInteractionPrompt.tscn")

enum LampRole { SOURCE, RELAY, DESTINATION }
enum LampState { INACTIVE, AVAILABLE_ENDPOINT, SELECTED, LOCKED, COMPLETED, INCORRECT }

@export var lamp_id: StringName
@export var channel_id: int = -1
@export var role: LampRole = LampRole.RELAY
@export var interaction_radius: float = 2.8
@export var visual_target_path: NodePath
@export var beam_anchor_path: NodePath
@export var beam_anchor_offset := Vector3(0.0, 0.72, 0.0)
@export var idle_prompt_text: String = "Направить свет"
@export var connect_prompt_text: String = "Соединить свет сюда"
@export var cancel_prompt_text: String = "Отменить выбор"
@export var reset_prompt_text: String = "Сбросить путь"
@export var inactive_color: Color = Color(0.48, 0.36, 0.22, 1.0)
@export var source_color: Color = Color(1.0, 0.72, 0.30, 1.0)
@export var destination_color: Color = Color(0.98, 0.84, 0.54, 1.0)

var state: LampState = LampState.INACTIVE
var _player_in_range := false
var _current_player: Node
var _controller: Node
var configured_path_channel := -1
var runtime_channel := -1
var _runtime_channel_color := inactive_color
var _visual_target: Node3D
var _visual_meshes: Array[MeshInstance3D] = []
var _visual_lights: Array[Light3D] = []
var _visual_materials: Dictionary = {}
var _pulse_tween: Tween

@onready var mesh: MeshInstance3D = get_node_or_null("LampMesh")
@onready var glow: OmniLight3D = $GlowLight
@onready var column: MeshInstance3D = $SelectionColumn
@onready var area: Area3D = $InteractionArea
@onready var shape: CollisionShape3D = $InteractionArea/CollisionShape3D
@onready var prompt: CanvasLayer = _ensure_prompt()
@onready var beam_anchor: Node3D = _resolve_beam_anchor()

func _ready() -> void:
	_visual_target = _resolve_visual_target()
	if _visual_target != null:
		_sync_to_visual_target()
		_collect_visual_nodes(_visual_target)
	add_to_group("player_interactable")
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)
	if prompt.has_method("set_target"):
		prompt.call("set_target", self)
	if shape.shape is SphereShape3D:
		(shape.shape as SphereShape3D).radius = interaction_radius
	_apply_visual_state()
	refresh_prompt()

func _ensure_prompt() -> CanvasLayer:
	var existing := get_node_or_null("WorldInteractionPrompt")
	if existing is CanvasLayer:
		return existing
	var created := WORLD_PROMPT_SCENE.instantiate() as CanvasLayer
	created.name = "WorldInteractionPrompt"
	add_child(created)
	return created

func configure(controller: Node, color: Color, path_channel := -1) -> void:
	_controller = controller
	configured_path_channel = path_channel
	if runtime_channel < 0:
		_runtime_channel_color = color
	_apply_visual_state()
	refresh_prompt()

func assign_runtime_channel(channel: int, color: Color) -> void:
	runtime_channel = channel
	_runtime_channel_color = color
	_apply_visual_state()
	refresh_prompt()

func clear_runtime_channel() -> void:
	runtime_channel = -1
	_runtime_channel_color = inactive_color
	_apply_visual_state()
	refresh_prompt()

func set_lamp_state(next_state: LampState) -> void:
	state = next_state
	_apply_visual_state()
	refresh_prompt()

func get_beam_anchor_position() -> Vector3:
	if _visual_target != null:
		return _visual_target.global_position + beam_anchor_offset
	if is_instance_valid(beam_anchor):
		return beam_anchor.global_position
	return global_position + beam_anchor_offset

func can_player_interact(player: Node) -> bool:
	return _player_in_range and player == _current_player and _controller != null and bool(_controller.call("can_lamp_be_interacted", self))

func interact(player: Node) -> void:
	if not can_player_interact(player):
		return
	interaction_requested.emit(self, player)

func refresh_prompt() -> void:
	if prompt == null:
		return
	var text := idle_prompt_text
	if _controller != null and _controller.has_method("get_prompt_text_for_lamp"):
		text = String(_controller.call("get_prompt_text_for_lamp", self))
	if prompt.has_method("set_action_text"):
		prompt.call("set_action_text", text)
	if can_player_interact(_current_player):
		prompt.call("show_prompt")
	elif prompt.has_method("hide_prompt"):
		prompt.call("hide_prompt")

func play_success_feedback() -> void:
	_flash(Color(1.0, 0.92, 0.55, 1.0))
	if prompt.has_method("play_confirm_and_hide"):
		prompt.call("play_confirm_and_hide")

func play_invalid_feedback() -> void:
	_flash(Color(0.95, 0.42, 0.30, 1.0))

func _resolve_visual_target() -> Node3D:
	if visual_target_path.is_empty():
		return null
	var target := get_node_or_null(visual_target_path)
	if target is Node3D:
		return target
	push_error("LightRouteLamp %s cannot resolve visual_target_path: %s" % [lamp_id, visual_target_path])
	return null

func _sync_to_visual_target() -> void:
	global_position = _visual_target.global_position
	if is_instance_valid(beam_anchor):
		beam_anchor.global_position = _visual_target.global_position + beam_anchor_offset

func _collect_visual_nodes(root: Node) -> void:
	_visual_meshes.clear()
	_visual_lights.clear()
	_visual_materials.clear()
	_collect_visual_nodes_recursive(root)

func _collect_visual_nodes_recursive(node: Node) -> void:
	if node is MeshInstance3D:
		var visual_mesh := node as MeshInstance3D
		_visual_meshes.append(visual_mesh)
		_visual_materials[visual_mesh] = StandardMaterial3D.new()
		visual_mesh.material_override = _visual_materials[visual_mesh]
	elif node is Light3D:
		_visual_lights.append(node as Light3D)
	for child in node.get_children():
		_collect_visual_nodes_recursive(child)

func _resolve_beam_anchor() -> Node3D:
	if not beam_anchor_path.is_empty():
		var anchor := get_node_or_null(beam_anchor_path)
		if anchor is Node3D:
			return anchor
	var local_anchor := get_node_or_null("BeamAnchor")
	if local_anchor is Node3D:
		return local_anchor
	return self

func _flash(color: Color) -> void:
	if _pulse_tween != null and _pulse_tween.is_valid():
		_pulse_tween.kill()
	var base_energy := glow.light_energy
	for visual_light in _visual_lights:
		visual_light.light_color = color
		visual_light.light_energy = maxf(visual_light.light_energy, 0.6)
	glow.light_color = color
	_pulse_tween = create_tween()
	_pulse_tween.tween_property(glow, "light_energy", maxf(base_energy, 1.7), 0.08)
	_pulse_tween.tween_property(glow, "light_energy", base_energy, 0.28)
	_pulse_tween.finished.connect(_apply_visual_state)

func _apply_visual_state() -> void:
	var channel_color := _runtime_channel_color if runtime_channel >= 0 else inactive_color
	var color := inactive_color
	var emission := Color.BLACK
	var energy := 0.0
	column.visible = false
	match state:
		LampState.INACTIVE:
			color = destination_color.darkened(0.28) if role == LampRole.DESTINATION else inactive_color
			energy = 0.0 if role == LampRole.SOURCE else 0.08
		LampState.AVAILABLE_ENDPOINT:
			color = channel_color
			emission = channel_color
			energy = 0.85
		LampState.SELECTED:
			color = channel_color.lightened(0.15)
			emission = channel_color
			energy = 1.55
			column.visible = true
		LampState.LOCKED:
			color = channel_color.darkened(0.05)
			emission = channel_color * 0.55
			energy = 0.62
		LampState.COMPLETED:
			color = channel_color.lightened(0.24)
			emission = channel_color
			energy = 1.2
		LampState.INCORRECT:
			color = Color(1.0, 0.42, 0.28, 1.0)
			emission = color
			energy = 0.9
	if mesh != null:
		mesh.visible = false
	_apply_visual_material(color, emission)
	for visual_light in _visual_lights:
		visual_light.light_color = channel_color
		visual_light.light_energy = energy
	glow.light_color = channel_color
	glow.light_energy = energy
	if column.visible:
		var column_mat := column.material_override as StandardMaterial3D
		if column_mat != null:
			column_mat.albedo_color = Color(channel_color.r, channel_color.g, channel_color.b, 0.22)
			column_mat.emission = channel_color

func _apply_visual_material(color: Color, emission: Color) -> void:
	for visual_mesh in _visual_meshes:
		if not is_instance_valid(visual_mesh):
			continue
		var material := _visual_materials.get(visual_mesh) as StandardMaterial3D
		if material == null:
			material = StandardMaterial3D.new()
			_visual_materials[visual_mesh] = material
			visual_mesh.material_override = material
		material.roughness = 0.82
		material.albedo_color = color
		material.emission_enabled = emission != Color.BLACK
		material.emission = emission
		material.emission_energy_multiplier = 0.65

func _on_body_entered(body: Node3D) -> void:
	if not body.is_in_group("player") and not body.name.to_lower().contains("player"):
		return
	_player_in_range = true
	_current_player = body
	refresh_prompt()

func _on_body_exited(body: Node3D) -> void:
	if body != _current_player:
		return
	_player_in_range = false
	_current_player = null
	refresh_prompt()

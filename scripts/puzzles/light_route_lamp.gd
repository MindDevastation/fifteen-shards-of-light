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
var _channel_color := Color(1.0, 0.73, 0.36, 1.0)
var _pulse_tween: Tween

@onready var mesh: MeshInstance3D = get_node_or_null("LampMesh")
@onready var glow: OmniLight3D = $GlowLight
@onready var column: MeshInstance3D = $SelectionColumn
@onready var area: Area3D = $InteractionArea
@onready var shape: CollisionShape3D = $InteractionArea/CollisionShape3D
@onready var prompt: CanvasLayer = _ensure_prompt()
@onready var beam_anchor: Node3D = _resolve_beam_anchor()

func _ready() -> void:
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

func configure(controller: Node, color: Color) -> void:
	_controller = controller
	_channel_color = color
	_apply_visual_state()
	refresh_prompt()

func set_lamp_state(next_state: LampState) -> void:
	state = next_state
	_apply_visual_state()
	refresh_prompt()

func get_beam_anchor_position() -> Vector3:
	if is_instance_valid(beam_anchor):
		return beam_anchor.global_position
	return global_position + Vector3.UP * 0.55

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
	glow.light_color = color
	_pulse_tween = create_tween()
	_pulse_tween.tween_property(glow, "light_energy", maxf(base_energy, 1.7), 0.08)
	_pulse_tween.tween_property(glow, "light_energy", base_energy, 0.28)
	_pulse_tween.finished.connect(_apply_visual_state)

func _apply_visual_state() -> void:
	var color := inactive_color
	var emission := Color.BLACK
	var energy := 0.0
	column.visible = false
	match state:
		LampState.INACTIVE:
			color = destination_color.darkened(0.28) if role == LampRole.DESTINATION else inactive_color
			energy = 0.0 if role == LampRole.SOURCE else 0.08
		LampState.AVAILABLE_ENDPOINT:
			color = _channel_color
			emission = _channel_color
			energy = 0.85
		LampState.SELECTED:
			color = _channel_color.lightened(0.15)
			emission = _channel_color
			energy = 1.55
			column.visible = true
		LampState.LOCKED:
			color = _channel_color.darkened(0.05)
			emission = _channel_color * 0.55
			energy = 0.62
		LampState.COMPLETED:
			color = _channel_color.lightened(0.24)
			emission = _channel_color
			energy = 1.2
		LampState.INCORRECT:
			color = Color(1.0, 0.42, 0.28, 1.0)
			emission = color
			energy = 0.9
	if mesh != null:
		var material := StandardMaterial3D.new()
		material.roughness = 0.82
		material.albedo_color = color
		material.emission_enabled = emission != Color.BLACK
		material.emission = emission
		material.emission_energy_multiplier = 0.65
		mesh.material_override = material
	glow.light_color = _channel_color
	glow.light_energy = energy
	if column.visible:
		var column_mat := column.material_override as StandardMaterial3D
		if column_mat != null:
			column_mat.albedo_color = Color(_channel_color.r, _channel_color.g, _channel_color.b, 0.22)
			column_mat.emission = _channel_color

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

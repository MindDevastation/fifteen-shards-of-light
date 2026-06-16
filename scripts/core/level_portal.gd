extends Node3D

signal activation_started
signal activation_completed
signal transition_started

enum PortalState { INACTIVE, ACTIVATING, ACTIVE, ENTERING }
enum EntryMode { AUTO_ENTER, INTERACT }

@export var target_scene_path: String = ""
@export var entry_mode: EntryMode = EntryMode.AUTO_ENTER
@export var interaction_prompt_text: String = "Шагнуть к свету"
@export_range(0.2, 5.0, 0.1) var activation_duration: float = 1.65
@export_range(0.1, 2.0, 0.05) var transition_duration: float = 0.65

var _state := PortalState.INACTIVE
var _is_loading_scene := false
var _player_in_range := false
var _current_player: Node
var _surface_material: ShaderMaterial
var _ring_materials: Array[ShaderMaterial] = []
var _ground_material: ShaderMaterial
@onready var visual_root: Node3D = $VisualRoot
@onready var interaction_area: Area3D = $InteractionArea
@onready var interaction_shape: CollisionShape3D = $InteractionArea/CollisionShape3D
@onready var orbit_motes: GPUParticles3D = $VisualRoot/OrbitMotes
@onready var portal_light: OmniLight3D = $VisualRoot/PortalLight
@onready var prompt: CanvasLayer = $WorldInteractionPrompt
@onready var veil: ColorRect = $TransitionVeil/ColorRect

func _ready() -> void:
	add_to_group("player_interactable")
	_duplicate_runtime_materials()
	interaction_area.body_entered.connect(_on_body_entered)
	interaction_area.body_exited.connect(_on_body_exited)
	if prompt.has_method("set_target"):
		prompt.call("set_target", self)
	var prompt_label := prompt.get_node_or_null("Root/TrackingRoot/AnimationRoot/PromptRoot/PromptBox/ActionLabel")
	if prompt_label is Label:
		prompt_label.text = interaction_prompt_text
	_set_activation(0.0)
	_deactivate()

func activate() -> void:
	if _state == PortalState.ACTIVE or _state == PortalState.ACTIVATING or _state == PortalState.ENTERING:
		return
	_state = PortalState.ACTIVATING
	show(); visual_root.show(); set_process(true); activation_started.emit()
	var tween := create_tween()
	tween.tween_method(_set_activation, 0.0, 1.0, activation_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(portal_light, "light_energy", 0.75, activation_duration * 0.7)
	get_tree().create_timer(minf(0.55, activation_duration * 0.5)).timeout.connect(func():
		if _state == PortalState.ACTIVATING:
			orbit_motes.emitting = true
	)
	tween.finished.connect(_finish_activation)

func can_player_interact(player: Node) -> bool:
	return entry_mode == EntryMode.INTERACT and _state == PortalState.ACTIVE and _player_in_range and not _is_loading_scene and player == _current_player

func interact(player: Node) -> void:
	if can_player_interact(player):
		_begin_entry(player)

func _process(delta: float) -> void:
	if _state == PortalState.INACTIVE:
		return
	$VisualRoot/OuterRing.rotate_z(-0.28 * delta)
	$VisualRoot/InnerRing.rotate_z(-0.18 * delta)
	$VisualRoot/GroundRing.rotate_y(0.10 * delta)

func _duplicate_runtime_materials() -> void:
	var surface := $VisualRoot/PortalSurface
	if surface.material_override is ShaderMaterial:
		surface.material_override = surface.material_override.duplicate(); _surface_material = surface.material_override
	for ring_path in ["VisualRoot/OuterRing", "VisualRoot/InnerRing"]:
		var ring := get_node(ring_path) as MeshInstance3D
		if ring.material_override is ShaderMaterial:
			ring.material_override = ring.material_override.duplicate(); _ring_materials.append(ring.material_override)
	var ground := $VisualRoot/GroundRing
	if ground.material_override is ShaderMaterial:
		ground.material_override = ground.material_override.duplicate(); _ground_material = ground.material_override

func _set_activation(value: float) -> void:
	if _surface_material != null: _surface_material.set_shader_parameter("activation", value)
	for mat in _ring_materials: mat.set_shader_parameter("activation", value)
	if _ground_material != null: _ground_material.set_shader_parameter("activation", value)
	visual_root.scale = Vector3.ONE * lerpf(0.72, 1.0, value)

func _finish_activation() -> void:
	if _state != PortalState.ACTIVATING: return
	_state = PortalState.ACTIVE
	_set_interaction_enabled(true)
	_update_prompt()
	activation_completed.emit()

func _deactivate() -> void:
	_state = PortalState.INACTIVE; hide(); visual_root.hide(); set_process(false); _set_interaction_enabled(false); orbit_motes.emitting = false; portal_light.light_energy = 0.0
	veil.color.a = 0.0
	if prompt.has_method("hide_prompt"): prompt.call("hide_prompt")

func _set_interaction_enabled(enabled: bool) -> void:
	interaction_area.set_deferred("monitoring", enabled); interaction_area.set_deferred("monitorable", enabled); interaction_shape.set_deferred("disabled", not enabled)

func _on_body_entered(body: Node3D) -> void:
	if not _is_player_body(body): return
	_player_in_range = true; _current_player = body; _update_prompt()
	if entry_mode == EntryMode.AUTO_ENTER and _state == PortalState.ACTIVE and not _is_loading_scene:
		_begin_entry(body)

func _on_body_exited(body: Node3D) -> void:
	if body != _current_player: return
	_player_in_range = false; _current_player = null; _update_prompt()

func _update_prompt() -> void:
	if prompt == null: return
	if can_player_interact(_current_player): prompt.call("show_prompt")
	elif prompt.has_method("hide_prompt"): prompt.call("hide_prompt")

func _begin_entry(player: Node) -> void:
	if _state != PortalState.ACTIVE or _is_loading_scene: return
	if target_scene_path.is_empty(): push_warning("LevelPortal has no target_scene_path set."); return
	_state = PortalState.ENTERING; _is_loading_scene = true; _set_interaction_enabled(false)
	if prompt.has_method("play_confirm_and_hide"): prompt.call("play_confirm_and_hide")
	_set_player_controls(player, false); transition_started.emit()
	var tween := create_tween(); tween.tween_property(veil, "color:a", 1.0, transition_duration); tween.finished.connect(_change_scene_to_target.bind(player))

func _change_scene_to_target(player: Node) -> void:
	var error := get_tree().change_scene_to_file(target_scene_path)
	if error != OK:
		push_error("Could not load portal target %s. Error code: %d" % [target_scene_path, error])
		_is_loading_scene = false; _state = PortalState.ACTIVE; _set_player_controls(player, true); _set_interaction_enabled(true)
		create_tween().tween_property(veil, "color:a", 0.0, 0.25)
		_update_prompt()

func _set_player_controls(player: Node, enabled: bool) -> void:
	if player != null and player.has_method("set_controls_enabled"):
		player.call("set_controls_enabled", enabled)

func _is_player_body(body: Node3D) -> bool:
	return body is CharacterBody3D and body.name == "Player"

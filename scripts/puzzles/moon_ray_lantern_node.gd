extends Node3D
class_name MoonRayLanternNode

signal interaction_requested(node: MoonRayLanternNode, player: Node)

enum LanternState { INACTIVE, ACTIVE_ENDPOINT, SELECTED, COMPLETED, RESETTING }

const WORLD_PROMPT_SCENE := preload("res://scenes/ui/WorldInteractionPrompt.tscn")
const SILVER := Color(0.78, 0.84, 0.90, 1.0)

@export var lantern_id: StringName
@export var visual_target_path: NodePath
@export var interaction_radius: float = 3.0
@export var beam_anchor_offset := Vector3(0.0, 1.25, 0.0)

var state := LanternState.INACTIVE
var _controller: Node
var _visual_target: Node3D
var _player_in_range := false
var _current_player: Node
var _halo: MeshInstance3D
var _selected_stream: GPUParticles3D
var _area: Area3D
var _shape: CollisionShape3D
var _prompt: CanvasLayer

func _ready() -> void:
	_visual_target = get_node_or_null(visual_target_path) as Node3D
	if _visual_target != null:
		global_position = _visual_target.global_position
	_build_runtime_nodes()
	add_to_group("player_interactable")
	_area.body_entered.connect(_on_body_entered)
	_area.body_exited.connect(_on_body_exited)
	_prompt.call("set_target", self)
	_apply_state()

func configure(controller: Node, id: StringName) -> void:
	_controller = controller
	lantern_id = id
	_apply_state()
	refresh_prompt()

func set_lantern_state(next_state: LanternState) -> void:
	state = next_state
	_apply_state()
	refresh_prompt()

func get_beam_anchor_position() -> Vector3:
	return global_position + beam_anchor_offset

func can_player_interact(player: Node) -> bool:
	return _player_in_range and player == _current_player and _controller != null and bool(_controller.call("can_lantern_be_interacted", self))

func interact(player: Node) -> void:
	if can_player_interact(player):
		interaction_requested.emit(self, player)

func refresh_prompt() -> void:
	if _prompt == null:
		return
	var text := "Направить лунный луч"
	if _controller != null:
		text = String(_controller.call("get_prompt_text_for_lantern", self))
	_prompt.call("set_action_text", text)
	if can_player_interact(_current_player):
		_prompt.call("show_prompt")
	else:
		_prompt.call("hide_prompt")

func play_success_feedback() -> void:
	if _prompt.has_method("play_confirm_and_hide"):
		_prompt.call("play_confirm_and_hide")

func play_invalid_feedback() -> void:
	var tween := create_tween()
	tween.tween_property(_halo, "transparency", 0.15, 0.08)
	tween.tween_callback(_apply_state)

func _build_runtime_nodes() -> void:
	_area = Area3D.new()
	_area.name = "MoonRayInteractionArea"
	add_child(_area)
	_shape = CollisionShape3D.new()
	var sphere := SphereShape3D.new()
	sphere.radius = interaction_radius
	_shape.shape = sphere
	_area.add_child(_shape)
	_prompt = WORLD_PROMPT_SCENE.instantiate() as CanvasLayer
	_prompt.name = "MoonRayWorldInteractionPrompt"
	add_child(_prompt)
	_halo = MeshInstance3D.new()
	_halo.name = "MoonRaySilverHalo"
	_halo.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	var mesh := SphereMesh.new()
	mesh.radius = 0.34
	mesh.height = 0.68
	mesh.radial_segments = 24
	mesh.rings = 8
	_halo.mesh = mesh
	var mat := StandardMaterial3D.new()
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.albedo_color = Color(0.82, 0.88, 0.94, 0.0)
	mat.emission_enabled = true
	mat.emission = SILVER
	mat.emission_energy_multiplier = 0.7
	_halo.material_override = mat
	_halo.position = beam_anchor_offset * 0.72
	add_child(_halo)
	_selected_stream = GPUParticles3D.new()
	_selected_stream.name = "MoonRaySelectedVerticalParticles"
	_selected_stream.amount = 24
	_selected_stream.lifetime = 0.8
	_selected_stream.emitting = false
	_selected_stream.draw_pass_1 = SphereMesh.new()
	_selected_stream.position = beam_anchor_offset
	add_child(_selected_stream)

func _apply_state() -> void:
	if _halo == null:
		return
	var alpha := 0.0
	var scale_value := 1.0
	_selected_stream.emitting = false
	match state:
		LanternState.INACTIVE:
			alpha = 0.0
		LanternState.ACTIVE_ENDPOINT:
			alpha = 0.42
			scale_value = 1.08
		LanternState.SELECTED:
			alpha = 0.72
			scale_value = 1.22
			_selected_stream.emitting = true
		LanternState.COMPLETED:
			alpha = 0.30
		LanternState.RESETTING:
			alpha = 0.14
	_halo.visible = alpha > 0.0
	_halo.transparency = 1.0 - alpha
	_halo.scale = Vector3.ONE * scale_value

func _on_body_entered(body: Node) -> void:
	if body.has_method("_try_start_interaction") or body.name == "Player":
		_player_in_range = true
		_current_player = body
		refresh_prompt()

func _on_body_exited(body: Node) -> void:
	if body == _current_player:
		_player_in_range = false
		_current_player = null
		refresh_prompt()

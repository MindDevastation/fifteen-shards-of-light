extends Node3D
class_name LightRouteLamp

signal interaction_requested(lamp: LightRouteLamp, player: Node)

enum LampRole { SOURCE, RELAY, DESTINATION }
enum LampState { INACTIVE, AVAILABLE_ENDPOINT, SELECTED, LOCKED, COMPLETED }

@export var lamp_id: StringName
@export var channel_id: int = -1
@export var role: LampRole = LampRole.RELAY
@export var interaction_radius: float = 2.8
@export var idle_prompt_text: String = "Направить свет"
@export var connect_prompt_text: String = "Соединить свет сюда"
@export var inactive_color: Color = Color(0.48, 0.36, 0.22, 1.0)
@export var source_color: Color = Color(1.0, 0.72, 0.30, 1.0)
@export var destination_color: Color = Color(0.98, 0.84, 0.54, 1.0)

var state: LampState = LampState.INACTIVE
var _player_in_range := false
var _current_player: Node
var _controller: Node
var _channel_color := Color(1.0, 0.73, 0.36, 1.0)
var _pulse_tween: Tween

@onready var mesh: MeshInstance3D = $LampMesh
@onready var glow: OmniLight3D = $GlowLight
@onready var column: MeshInstance3D = $SelectionColumn
@onready var area: Area3D = $InteractionArea
@onready var shape: CollisionShape3D = $InteractionArea/CollisionShape3D
@onready var prompt: CanvasLayer = $WorldInteractionPrompt

func _ready() -> void:
	add_to_group("player_interactable")
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)
	if prompt.has_method("set_target"):
		prompt.call("set_target", self)
	shape.shape.radius = interaction_radius
	_apply_visual_state()

func configure(controller: Node, color: Color) -> void:
	_controller = controller
	_channel_color = color
	_apply_visual_state()

func set_lamp_state(next_state: LampState) -> void:
	state = next_state
	_apply_visual_state()
	_update_prompt()

func can_player_interact(player: Node) -> bool:
	return _player_in_range and player == _current_player and _controller != null and bool(_controller.call("can_lamp_be_interacted", self))

func interact(player: Node) -> void:
	if not can_player_interact(player):
		return
	interaction_requested.emit(self, player)

func play_success_feedback() -> void:
	_flash(Color(1.0, 0.92, 0.55, 1.0))
	if prompt.has_method("play_confirm_and_hide"):
		prompt.call("play_confirm_and_hide")

func play_invalid_feedback() -> void:
	_flash(Color(0.95, 0.42, 0.30, 1.0))

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
	if mesh == null:
		return
	var material := StandardMaterial3D.new()
	material.roughness = 0.82
	material.metallic = 0.0
	var color := inactive_color
	var emission := Color.BLACK
	var energy := 0.0
	column.visible = false
	match state:
		LampState.INACTIVE:
			color = destination_color.darkened(0.28) if role == LampRole.DESTINATION else inactive_color
			energy = 0.08
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
	_update_prompt()

func _on_body_exited(body: Node3D) -> void:
	if body != _current_player:
		return
	_player_in_range = false
	_current_player = null
	_update_prompt()

func _update_prompt() -> void:
	if prompt == null:
		return
	var label := prompt.get_node_or_null("Root/TrackingRoot/AnimationRoot/PromptRoot/PromptBox/ActionLabel")
	if label is Label:
		label.text = connect_prompt_text if _controller != null and bool(_controller.call("has_selected_endpoint")) else idle_prompt_text
	if can_player_interact(_current_player):
		prompt.call("show_prompt")
	elif prompt.has_method("hide_prompt"):
		prompt.call("hide_prompt")

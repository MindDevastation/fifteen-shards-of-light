extends Node3D

const SPHERE_FLOAT_AMPLITUDE := 0.18
const SPHERE_FLOAT_SPEED := 2.0

var _is_player_near_pedestal := false
var _is_pedestal_activated := false
var _sphere_base_position := Vector3.ZERO
var _sphere_float_time := 0.0

@onready var interaction_zone: Area3D = $PedestalInteractionZone
@onready var interaction_prompt: Label = $UILayer/InteractionPrompt
@onready var final_video_placeholder: Label = $UILayer/FinalVideoPlaceholder
@onready var soul_sphere: MeshInstance3D = $SoulSpherePlaceholder


func _ready() -> void:
	interaction_prompt.hide()
	final_video_placeholder.hide()
	soul_sphere.hide()
	_sphere_base_position = soul_sphere.position

	interaction_zone.body_entered.connect(_on_interaction_zone_body_entered)
	interaction_zone.body_exited.connect(_on_interaction_zone_body_exited)


func _process(delta: float) -> void:
	if _is_player_near_pedestal and not _is_pedestal_activated and Input.is_action_just_pressed("ui_accept"):
		_activate_pedestal()

	if _is_pedestal_activated:
		_sphere_float_time += delta
		soul_sphere.position = _sphere_base_position + Vector3(0.0, sin(_sphere_float_time * SPHERE_FLOAT_SPEED) * SPHERE_FLOAT_AMPLITUDE, 0.0)


func _activate_pedestal() -> void:
	_is_pedestal_activated = true
	interaction_prompt.hide()
	soul_sphere.show()
	final_video_placeholder.show()


func _on_interaction_zone_body_entered(body: Node3D) -> void:
	if not _is_player_body(body):
		return

	_is_player_near_pedestal = true
	if not _is_pedestal_activated:
		interaction_prompt.show()


func _on_interaction_zone_body_exited(body: Node3D) -> void:
	if not _is_player_body(body):
		return

	_is_player_near_pedestal = false
	interaction_prompt.hide()


func _is_player_body(body: Node3D) -> bool:
	return body is CharacterBody3D and body.name == "Player"

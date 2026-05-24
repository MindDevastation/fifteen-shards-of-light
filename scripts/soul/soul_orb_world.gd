extends Node3D

const SOUL_ORB_FOLLOW_SCENE := preload("res://scenes/core/SoulOrb_Follow.tscn")

@export var hover_base_height: float = 1.25
@export var hover_amplitude: float = 0.12
@export var hover_speed: float = 1.1

@onready var hover_root: Node3D = $HoverRoot
@onready var pickup_area: Area3D = $PickupArea

var _time: float = 0.0
var _player_in_range: bool = false
var _is_collected: bool = false
var _player_ref: Node3D = null


func _ready() -> void:
	hover_root.position.y = hover_base_height
	pickup_area.body_entered.connect(_on_pickup_area_body_entered)
	pickup_area.body_exited.connect(_on_pickup_area_body_exited)


func _process(delta: float) -> void:
	if _is_collected:
		return

	_time += delta
	hover_root.position.y = hover_base_height + sin(_time * hover_speed) * hover_amplitude

	if not _player_in_range:
		return

	if not Input.is_action_just_pressed("interact"):
		return

	_collect_to_follow()


func _on_pickup_area_body_entered(body: Node3D) -> void:
	if _is_collected:
		return

	if not _is_player_body(body):
		return

	_player_in_range = true
	_player_ref = body


func _on_pickup_area_body_exited(body: Node3D) -> void:
	if _is_collected:
		return

	if body != _player_ref:
		return

	_player_in_range = false
	_player_ref = null


func _collect_to_follow() -> void:
	if _is_collected:
		return

	if _player_ref == null:
		return

	_is_collected = true
	_player_in_range = false

	set_process(false)
	pickup_area.set_deferred("monitoring", false)
	pickup_area.set_deferred("monitorable", false)

	var follow_orb := SOUL_ORB_FOLLOW_SCENE.instantiate() as Node3D
	if follow_orb != null:
		get_parent().add_child(follow_orb)
		follow_orb.global_position = global_position
		if follow_orb.has_method("set_follow_target"):
			follow_orb.call("set_follow_target", _player_ref)
		elif follow_orb.has_method("set"):
			follow_orb.set("target_path", follow_orb.get_path_to(_player_ref))

	hide()


func _is_player_body(body: Node3D) -> bool:
	return body is CharacterBody3D and body.name == "Player"

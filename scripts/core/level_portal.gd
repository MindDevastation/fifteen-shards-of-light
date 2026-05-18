extends Node3D

@export var target_scene_path: String = ""

var _is_active := false
var _is_loading_scene := false
var _frame_collision_shapes: Array[CollisionShape3D] = []

@onready var portal_trigger: Area3D = $PortalTrigger
@onready var trigger_collision_shape: CollisionShape3D = $PortalTrigger/CollisionShape3D


func _ready() -> void:
	_frame_collision_shapes = [
		$LeftPost/CollisionShape3D,
		$RightPost/CollisionShape3D,
		$TopBeam/CollisionShape3D,
	]
	portal_trigger.body_entered.connect(_on_portal_trigger_body_entered)
	_deactivate()


func activate() -> void:
	_is_active = true
	show()
	_set_frame_collision_enabled(true)
	_set_trigger_enabled(true)


func _deactivate() -> void:
	_is_active = false
	hide()
	_set_trigger_enabled(false)
	_set_frame_collision_enabled(false)


func _set_trigger_enabled(is_enabled: bool) -> void:
	portal_trigger.set_deferred("monitoring", is_enabled)
	portal_trigger.set_deferred("monitorable", is_enabled)
	trigger_collision_shape.set_deferred("disabled", not is_enabled)


func _set_frame_collision_enabled(is_enabled: bool) -> void:
	for frame_collision_shape in _frame_collision_shapes:
		frame_collision_shape.set_deferred("disabled", not is_enabled)


func _on_portal_trigger_body_entered(body: Node3D) -> void:
	if not _is_active or _is_loading_scene:
		return

	if not _is_player_body(body):
		return

	if target_scene_path.is_empty():
		push_warning("LevelPortal has no target_scene_path set.")
		return

	_is_loading_scene = true
	var error := get_tree().change_scene_to_file(target_scene_path)
	if error != OK:
		_is_loading_scene = false
		push_error("Could not load portal target %s. Error code: %d" % [target_scene_path, error])


func _is_player_body(body: Node3D) -> bool:
	return body is CharacterBody3D and body.name == "Player"

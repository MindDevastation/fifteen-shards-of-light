extends Area3D

@export var target_scene_path: String = ""

var _is_active := false
var _is_loading_scene := false

@onready var collision_shape: CollisionShape3D = $CollisionShape3D


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	_deactivate()


func activate() -> void:
	_is_active = true
	show()
	set_deferred("monitoring", true)
	set_deferred("monitorable", true)
	collision_shape.set_deferred("disabled", false)


func _deactivate() -> void:
	_is_active = false
	hide()
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	collision_shape.set_deferred("disabled", true)


func _on_body_entered(body: Node3D) -> void:
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

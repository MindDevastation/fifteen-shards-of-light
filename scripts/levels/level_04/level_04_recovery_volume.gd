extends Area3D
class_name Level04RecoveryVolume

@export var volume_id: StringName
@export var collision_shape_path: NodePath = NodePath("CollisionShape3D")

@onready var _collision_shape: CollisionShape3D = get_node_or_null(collision_shape_path) as CollisionShape3D


func get_volume_id() -> StringName:
	return volume_id


func set_sensor_enabled(enabled: bool) -> void:
	monitoring = enabled
	monitorable = enabled
	if _collision_shape != null:
		_collision_shape.disabled = not enabled

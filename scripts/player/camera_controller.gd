extends Camera3D

@export var target_path: NodePath
@export var follow_offset: Vector3 = Vector3(0.0, 4.0, 7.0)
@export var follow_speed: float = 8.0

@onready var target: Node3D = get_node_or_null(target_path) as Node3D


func _process(delta: float) -> void:
	if target == null:
		return

	var desired_position := target.global_position + follow_offset
	global_position = global_position.lerp(desired_position, follow_speed * delta)
	look_at(target.global_position, Vector3.UP)

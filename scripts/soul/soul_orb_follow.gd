extends Node3D

@export var target_path: NodePath = NodePath("")
@export var orientation_source_path: NodePath = NodePath("")
@export var follow_offset: Vector3 = Vector3(0.8, 1.4, 1.0)
@export_range(0.1, 20.0, 0.1) var follow_lerp_speed: float = 5.0
@export var vertical_bob_amplitude: float = 0.1
@export var vertical_bob_speed: float = 1.4

var _time: float = 0.0
var _runtime_target: Node3D = null
var _runtime_orientation_source: Node3D = null


func set_follow_target(target: Node3D, orientation_source: Node3D = null) -> void:
	_runtime_target = target
	_runtime_orientation_source = orientation_source


func _process(delta: float) -> void:
	_time += delta

	var target_3d := _resolve_target()
	if target_3d == null:
		return

	var bob := sin(_time * vertical_bob_speed) * vertical_bob_amplitude
	var orientation_source := _resolve_orientation_source(target_3d)
	if orientation_source == null:
		return

	var oriented_offset := orientation_source.global_transform.basis * follow_offset
	var desired_position := target_3d.global_position + oriented_offset
	desired_position.y += bob

	var t := clampf(follow_lerp_speed * delta, 0.0, 1.0)
	global_position = global_position.lerp(desired_position, t)


func _resolve_target() -> Node3D:
	if is_instance_valid(_runtime_target):
		return _runtime_target

	if target_path.is_empty():
		return null

	var target_node := get_node_or_null(target_path)
	if target_node == null:
		return null

	if not target_node is Node3D:
		return null

	return target_node as Node3D


func _resolve_orientation_source(target_3d: Node3D) -> Node3D:
	if is_instance_valid(_runtime_orientation_source):
		return _runtime_orientation_source

	if not orientation_source_path.is_empty():
		var orientation_node := get_node_or_null(orientation_source_path)
		if orientation_node is Node3D:
			return orientation_node as Node3D

	return target_3d

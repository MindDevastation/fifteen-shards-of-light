extends Node
class_name Level01LightPuzzleCoordinator

signal dual_light_completed
signal barrier_unlock_requested

@export var moon_ray_controller_path: NodePath
@export var sun_ray_controller_path: NodePath
@export var celestial_barrier_path: NodePath

var _moon_ray_completed := false
var _sun_ray_completed := false
var _barrier_unlock_requested := false
var _configuration_valid := false

var _moon_ray_controller: Node
var _sun_ray_controller: Node
var _celestial_barrier: Node

func _ready() -> void:
	_configuration_valid = false
	_moon_ray_controller = get_node_or_null(moon_ray_controller_path)
	if _moon_ray_controller == null:
		push_error("BLOCKER: Level01LightPuzzleCoordinator missing Moon Ray controller at %s" % [moon_ray_controller_path])
		return

	_sun_ray_controller = get_node_or_null(sun_ray_controller_path)
	if _sun_ray_controller == null:
		push_error("BLOCKER: Level01LightPuzzleCoordinator missing Sun Ray controller at %s" % [sun_ray_controller_path])
		return

	_celestial_barrier = get_node_or_null(celestial_barrier_path)
	if _celestial_barrier == null:
		push_error("BLOCKER: Level01LightPuzzleCoordinator missing celestial barrier at %s" % [celestial_barrier_path])
		return

	if not _moon_ray_controller.has_signal("puzzle_completed"):
		push_error("BLOCKER: Moon Ray controller is missing puzzle_completed signal")
		return
	if not _sun_ray_controller.has_signal("sun_ray_completed"):
		push_error("BLOCKER: Sun Ray controller is missing sun_ray_completed signal")
		return
	if not _moon_ray_controller.has_method("debug_is_completed"):
		push_error("BLOCKER: Moon Ray controller is missing debug_is_completed()")
		return
	if not _sun_ray_controller.has_method("debug_is_completed"):
		push_error("BLOCKER: Sun Ray controller is missing debug_is_completed()")
		return
	if not _celestial_barrier.has_method("open_gate"):
		push_error("BLOCKER: celestial barrier is missing open_gate()")
		return

	var moon_completed_signal := Signal(_moon_ray_controller, "puzzle_completed")
	var moon_completed_callable := Callable(self, "_on_moon_ray_completed")
	if not moon_completed_signal.is_connected(moon_completed_callable):
		moon_completed_signal.connect(moon_completed_callable)

	var sun_completed_signal := Signal(_sun_ray_controller, "sun_ray_completed")
	var sun_completed_callable := Callable(self, "_on_sun_ray_completed")
	if not sun_completed_signal.is_connected(sun_completed_callable):
		sun_completed_signal.connect(sun_completed_callable)

	_configuration_valid = true
	call_deferred("_synchronize_completion_state")

func _synchronize_completion_state() -> void:
	if not _configuration_valid:
		return
	if _moon_ray_controller == null or not _moon_ray_controller.has_method("debug_is_completed"):
		_configuration_valid = false
		push_error("BLOCKER: Moon Ray controller cannot synchronize completion state")
		return
	if _sun_ray_controller == null or not _sun_ray_controller.has_method("debug_is_completed"):
		_configuration_valid = false
		push_error("BLOCKER: Sun Ray controller cannot synchronize completion state")
		return
	_moon_ray_completed = bool(_moon_ray_controller.call("debug_is_completed"))
	_sun_ray_completed = bool(_sun_ray_controller.call("debug_is_completed"))
	_check_light_barrier_unlock()

func _on_moon_ray_completed() -> void:
	if _moon_ray_completed:
		return
	_moon_ray_completed = true
	_check_light_barrier_unlock()

func _on_sun_ray_completed() -> void:
	if _sun_ray_completed:
		return
	_sun_ray_completed = true
	_check_light_barrier_unlock()

func _check_light_barrier_unlock() -> void:
	if not _configuration_valid:
		return
	if _barrier_unlock_requested:
		return
	if not _moon_ray_completed or not _sun_ray_completed:
		return

	_barrier_unlock_requested = true
	barrier_unlock_requested.emit()
	_celestial_barrier.call("open_gate")
	dual_light_completed.emit()

func debug_moon_ray_completed() -> bool:
	return _moon_ray_completed

func debug_sun_ray_completed() -> bool:
	return _sun_ray_completed

func debug_barrier_unlock_requested() -> bool:
	return _barrier_unlock_requested

func debug_configuration_valid() -> bool:
	return _configuration_valid

func debug_celestial_barrier() -> Node:
	return _celestial_barrier

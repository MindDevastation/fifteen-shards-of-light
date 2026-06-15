extends Camera3D

@export var target_path: NodePath
@export var mouse_sensitivity: float = 0.003
@export_range(-89.0, 89.0, 0.1) var min_pitch_degrees: float = -35.0
@export_range(-89.0, 89.0, 0.1) var max_pitch_degrees: float = 60.0
@export var min_zoom_distance: float = 1.625
@export var max_zoom_distance: float = 10.0
@export var zoom_step: float = 0.75
@export var camera_height: float = 1.8
@export_flags_3d_physics var camera_collision_mask: int = 1
@export_range(0.05, 0.5, 0.01) var camera_collision_margin: float = 0.2
@export_range(1.0, 40.0, 0.5) var camera_follow_smoothness: float = 18.0
@export_range(1.0, 40.0, 0.5) var camera_focus_smoothness: float = 14.0
@export_range(1.0, 60.0, 0.5) var camera_collision_distance_smoothness: float = 24.0
@export_range(1.0, 40.0, 0.5) var camera_collision_release_smoothness: float = 8.0
@export_range(0.0, 0.5, 0.01) var camera_collision_deadzone: float = 0.08
@export_range(0.0, 1.0, 0.01) var camera_min_obstruction_delta: float = 0.12

@onready var target: Node3D = get_node_or_null(target_path) as Node3D

var _yaw: float = PI
var _pitch: float = deg_to_rad(15.0)
var _zoom_distance: float = 2.6
var _smoothed_target_focus: Vector3 = Vector3.ZERO
var _current_camera_distance: float = 2.6
var _has_smoothed_target_focus: bool = false


func _ready() -> void:
	_zoom_distance = clamp(_zoom_distance, min_zoom_distance, max_zoom_distance)
	_snap_to_orbit_position()
	_update_mouse_mode()


func _unhandled_input(event: InputEvent) -> void:
	if _is_blocking_ui_open():
		return

	if event is InputEventMouseMotion:
		_yaw -= event.relative.x * mouse_sensitivity
		_pitch -= event.relative.y * mouse_sensitivity
		_pitch = clamp(_pitch, deg_to_rad(min_pitch_degrees), deg_to_rad(max_pitch_degrees))
		get_viewport().set_input_as_handled()
		return

	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_zoom_distance = clamp(_zoom_distance - zoom_step, min_zoom_distance, max_zoom_distance)
			get_viewport().set_input_as_handled()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_zoom_distance = clamp(_zoom_distance + zoom_step, min_zoom_distance, max_zoom_distance)
			get_viewport().set_input_as_handled()


func _process(_delta: float) -> void:
	if target == null:
		return

	_update_mouse_mode()

	var target_focus := _get_smoothed_target_focus(_delta)
	var camera_direction := _get_orbit_direction()
	var desired_distance := _get_collision_corrected_distance(target_focus, camera_direction, _zoom_distance)
	_current_camera_distance = _get_smoothed_camera_distance(desired_distance, _delta)

	var corrected_position := target_focus + camera_direction * _current_camera_distance
	global_position = global_position.lerp(corrected_position, clampf(camera_follow_smoothness * _delta, 0.0, 1.0))
	look_at(target_focus, Vector3.UP)


func _snap_to_orbit_position() -> void:
	if target == null:
		return

	var target_focus := target.global_position + Vector3.UP * camera_height
	_smoothed_target_focus = target_focus
	_has_smoothed_target_focus = true
	var camera_direction := _get_orbit_direction()
	_current_camera_distance = _get_collision_corrected_distance(target_focus, camera_direction, _zoom_distance)
	global_position = target_focus + camera_direction * _current_camera_distance
	look_at(target_focus, Vector3.UP)


func _get_smoothed_target_focus(delta: float) -> Vector3:
	var target_focus := target.global_position + Vector3.UP * camera_height
	if not _has_smoothed_target_focus:
		_smoothed_target_focus = target_focus
		_has_smoothed_target_focus = true
		return _smoothed_target_focus

	_smoothed_target_focus = _smoothed_target_focus.lerp(target_focus, clampf(camera_focus_smoothness * delta, 0.0, 1.0))
	return _smoothed_target_focus


func _get_orbit_direction() -> Vector3:
	var orbit_offset := Vector3(0.0, 0.0, 1.0)
	orbit_offset = orbit_offset.rotated(Vector3.RIGHT, _pitch)
	orbit_offset = orbit_offset.rotated(Vector3.UP, _yaw)
	return orbit_offset.normalized()


func _get_collision_corrected_distance(target_focus: Vector3, camera_direction: Vector3, desired_distance: float) -> float:
	var desired_position := target_focus + camera_direction * desired_distance
	var query := PhysicsRayQueryParameters3D.create(target_focus, desired_position)
	query.collision_mask = camera_collision_mask
	query.collide_with_areas = false
	if target is CollisionObject3D:
		query.exclude = [(target as CollisionObject3D).get_rid()]
	var hit := get_world_3d().direct_space_state.intersect_ray(query)
	if hit.is_empty():
		return desired_distance

	var hit_position := hit["position"] as Vector3
	var hit_distance := target_focus.distance_to(hit_position)
	if desired_distance - hit_distance < camera_min_obstruction_delta:
		return desired_distance

	return maxf(hit_distance - camera_collision_margin, camera_collision_margin)


func _get_smoothed_camera_distance(desired_distance: float, delta: float) -> float:
	if absf(desired_distance - _current_camera_distance) < camera_collision_deadzone:
		return _current_camera_distance

	var smoothness := camera_collision_release_smoothness
	if desired_distance < _current_camera_distance:
		smoothness = camera_collision_distance_smoothness
	return lerpf(_current_camera_distance, desired_distance, clampf(smoothness * delta, 0.0, 1.0))

func _update_mouse_mode() -> void:
	if not current:
		return

	if _is_blocking_ui_open():
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _is_blocking_ui_open() -> bool:
	if _is_dev_menu_visible():
		return true
	if _is_poem_reward_visible():
		return true
	if _is_ending_overlay_visible():
		return true
	if _is_shard_reward_overlay_visible():
		return true
	return false


func _is_dev_menu_visible() -> bool:
	var menu := get_tree().root.get_node_or_null("/root/DevLevelMenu") as CanvasLayer
	if menu == null:
		return false
	var panel := menu.get_node_or_null("OverlayRoot/MenuPanel") as Control
	return panel != null and panel.visible


func _is_poem_reward_visible() -> bool:
	return _has_visible_control_named(get_tree().current_scene, "PoemRewardUI")


func _is_ending_overlay_visible() -> bool:
	if get_tree().current_scene == null:
		return false
	var overlay := get_tree().current_scene.get_node_or_null("UILayer/EndingOverlay") as Control
	return overlay != null and overlay.visible



func _is_shard_reward_overlay_visible() -> bool:
	return _has_visible_control_named(get_tree().current_scene, "ShardRewardOverlay")

func _has_visible_control_named(node: Node, target_name: String) -> bool:
	if node == null:
		return false
	if node is Control and node.name == target_name and node.visible:
		return true
	for child in node.get_children():
		if _has_visible_control_named(child, target_name):
			return true
	return false

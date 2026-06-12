extends CharacterBody3D

const JUMP_COOLDOWN_SECONDS := 0.1
const INTERACT_COOLDOWN_SECONDS := 0.1

@export var walk_speed: float = 4.25
@export var run_speed: float = 6.25
@export var jump_velocity: float = 4.025
@export var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@export_range(1.0, 20.0, 0.1) var visual_turn_speed: float = 5.0
@export_range(0.1, 0.7, 0.01) var max_step_height: float = 0.55
@export_range(0.1, 0.8, 0.01) var step_check_distance: float = 0.5
@export_range(0.05, 0.5, 0.01) var step_forward_distance: float = 0.38
@export_range(0.0, 0.1, 0.005) var step_body_clearance_margin: float = 0.03
@export_range(0.2, 1.2, 0.01) var step_down_probe_distance: float = 0.75
@export_range(0.0, 0.2, 0.01) var step_climb_duration: float = 0.1
@export var step_debug_enabled: bool = false

@onready var visual_root: Node3D = $CharacterVisualRoot
@onready var animation_controller: FoxHeroineAnimationController = $FoxHeroineAnimationController

var _jump_cooldown_remaining: float = 0.0
var _interact_cooldown_remaining: float = 0.0
var _last_step_debug_reason := ""
var _last_step_debug_time_msec := 0
var _step_climb_active := false
var _step_climb_start_position := Vector3.ZERO
var _step_climb_target_position := Vector3.ZERO
var _step_climb_elapsed := 0.0
var _step_climb_target_transform := Transform3D.IDENTITY



func _physics_process(delta: float) -> void:
	_jump_cooldown_remaining = max(_jump_cooldown_remaining - delta, 0.0)
	_interact_cooldown_remaining = max(_interact_cooldown_remaining - delta, 0.0)

	if _step_climb_active:
		_update_step_climb(delta)
		return

	var input_direction := _get_input_direction()
	var movement_direction := _get_camera_relative_direction(input_direction)
	var is_shift_held := Input.is_key_pressed(KEY_SHIFT)
	var is_moving := movement_direction.length_squared() > 0.000001

	if is_moving:
		animation_controller.stop_dance_loop()

	var current_speed := walk_speed
	if is_shift_held:
		current_speed = run_speed

	velocity.x = movement_direction.x * current_speed
	velocity.z = movement_direction.z * current_speed
	_update_visual_facing(movement_direction, delta)

	if not is_on_floor():
		velocity.y -= gravity * delta
	elif Input.is_key_pressed(KEY_SPACE) and _jump_cooldown_remaining <= 0.0:
		velocity.y = jump_velocity
		_jump_cooldown_remaining = JUMP_COOLDOWN_SECONDS
	else:
		velocity.y = 0.0

	if Input.is_action_just_pressed("dance_test"):
		animation_controller.start_dance_loop()
	elif Input.is_action_just_pressed("interact"):
		_try_start_interaction()
	elif is_moving:
		animation_controller.update_locomotion("run")
	elif not animation_controller.is_dancing():
		animation_controller.update_idle(delta)

	var was_on_floor := is_on_floor()
	var position_before_move := global_position
	move_and_slide()
	_try_step_up(delta, movement_direction, was_on_floor, position_before_move, current_speed)


func _try_start_interaction() -> void:
	if _interact_cooldown_remaining > 0.0:
		return

	var interactable := _find_best_interactable()
	if interactable == null:
		return

	_interact_cooldown_remaining = INTERACT_COOLDOWN_SECONDS
	if interactable.has_method("interact"):
		interactable.call("interact", self)


func _find_best_interactable() -> Node:
	var candidates := get_tree().get_nodes_in_group("player_interactable")
	var best: Node = null
	var best_distance_sq := INF
	for candidate in candidates:
		if not (candidate is Node3D):
			continue
		if not is_instance_valid(candidate):
			continue
		if not candidate.has_method("can_player_interact"):
			continue
		if not bool(candidate.call("can_player_interact", self)):
			continue
		var dist_sq := global_position.distance_squared_to((candidate as Node3D).global_position)
		if dist_sq < best_distance_sq:
			best_distance_sq = dist_sq
			best = candidate
	return best




func _try_step_up(
	delta: float, movement_direction: Vector3, was_on_floor: bool, position_before_move: Vector3, current_speed: float
) -> void:
	if not was_on_floor or not is_on_floor():
		return
	if movement_direction.length_squared() <= 0.000001:
		return
	if max_step_height <= 0.0 or step_check_distance <= 0.0 or step_forward_distance <= 0.0:
		return

	var direction := movement_direction.normalized()
	var pre_move_floor_y := position_before_move.y
	var space_state := get_world_3d().direct_space_state
	var exclude: Array[RID] = []
	exclude.append(get_rid())

	var has_slide_step_collision := _has_blocking_step_collision(direction)
	var has_fallback_low_obstacle := false
	if not has_slide_step_collision:
		has_fallback_low_obstacle = _has_fallback_low_obstacle(space_state, direction, position_before_move, pre_move_floor_y, exclude)

	if not has_slide_step_collision and not has_fallback_low_obstacle:
		if _was_horizontal_motion_blocked(delta, direction, position_before_move, current_speed):
			_step_debug("no low obstacle detected")
		return

	if has_fallback_low_obstacle:
		_step_debug("fallback low obstacle accepted")

	var candidate_heights := _get_step_candidate_heights()
	var last_failure_reason := "no top floor found"
	for candidate_height: float in candidate_heights:
		var raised_motion := Vector3.UP * (candidate_height + step_body_clearance_margin)
		if test_move(global_transform, raised_motion, null, safe_margin, false, 1):
			last_failure_reason = "body motion upward blocked"
			continue

		var raised_transform := global_transform
		raised_transform.origin += raised_motion
		var forward_motion := direction * step_forward_distance
		if test_move(raised_transform, forward_motion, null, safe_margin, false, 1):
			last_failure_reason = "body motion forward blocked"
			continue

		var floor_result := _find_best_step_floor(space_state, direction, pre_move_floor_y, exclude)
		if floor_result.is_empty():
			last_failure_reason = "no top floor found"
			continue
		if not bool(floor_result["is_valid"]):
			last_failure_reason = floor_result["reason"] as String
			continue

		var target_transform := floor_result["target_transform"] as Transform3D
		var placement_result := floor_result["placement_result"] as String
		if placement_result == "accepted_without_recovery":
			_step_debug("final placement accepted with offset")

		_start_step_climb(target_transform)
		_step_debug("candidate accepted")
		return

	_step_debug(last_failure_reason)

func _start_step_climb(target_transform: Transform3D) -> void:
	if step_climb_duration <= 0.0:
		global_transform = target_transform
		velocity.y = 0.0
		return

	_step_climb_active = true
	_step_climb_start_position = global_position
	_step_climb_target_position = target_transform.origin
	_step_climb_elapsed = 0.0
	_step_climb_target_transform = target_transform
	velocity.y = 0.0


func _update_step_climb(delta: float) -> void:
	_step_climb_elapsed += delta
	var progress := clampf(_step_climb_elapsed / step_climb_duration, 0.0, 1.0)
	var eased_progress := smoothstep(0.0, 1.0, progress)
	var next_transform := _step_climb_target_transform
	next_transform.origin = _step_climb_start_position.lerp(_step_climb_target_position, eased_progress)

	if _is_step_climb_placement_usable(next_transform):
		global_transform = next_transform
	elif _is_step_climb_placement_usable(_step_climb_target_transform):
		global_transform = _step_climb_target_transform
		_step_debug("step climb intermediate blocked; snapped to validated target")
		_finish_step_climb()
		return
	else:
		_step_debug("step climb target became blocked")
		_finish_step_climb()
		return

	velocity.y = 0.0
	if progress >= 1.0:
		global_transform = _step_climb_target_transform
		_finish_step_climb()


func _finish_step_climb() -> void:
	_step_climb_active = false
	_step_climb_elapsed = 0.0
	velocity.y = 0.0


func _is_step_climb_placement_usable(body_transform: Transform3D) -> bool:
	return _get_final_placement_result(body_transform) != "blocked"


func _was_horizontal_motion_blocked(
	delta: float, direction: Vector3, position_before_move: Vector3, current_speed: float
) -> bool:
	var horizontal_motion := global_position - position_before_move
	horizontal_motion.y = 0.0
	var expected_distance := current_speed * delta
	if expected_distance <= 0.000001:
		return false
	return horizontal_motion.dot(direction) < expected_distance * 0.35


func _has_blocking_step_collision(direction: Vector3) -> bool:
	for collision_index in get_slide_collision_count():
		var collision := get_slide_collision(collision_index)
		if collision == null:
			continue
		var normal := collision.get_normal()
		var block_dot := -normal.dot(direction)
		if block_dot >= 0.25 and normal.dot(Vector3.UP) < cos(floor_max_angle):
			return true
	return false


func _has_fallback_low_obstacle(
	space_state: PhysicsDirectSpaceState3D,
	direction: Vector3,
	base_position: Vector3,
	pre_move_floor_y: float,
	exclude: Array[RID]
) -> bool:
	var side_direction := Vector3.UP.cross(direction)
	if side_direction.length_squared() <= 0.000001:
		return false
	side_direction = side_direction.normalized()

	var side_offsets: Array[float] = [0.0, -0.22, 0.22]
	var low_probe_heights: Array[float] = [0.10, 0.26, 0.42]
	for side_offset: float in side_offsets:
		for probe_height: float in low_probe_heights:
			var ray_start := base_position + side_direction * side_offset + Vector3.UP * probe_height - direction * 0.05
			var ray_end := ray_start + direction * step_check_distance
			var low_query := PhysicsRayQueryParameters3D.create(ray_start, ray_end)
			low_query.exclude = exclude
			low_query.collide_with_areas = false
			var hit := space_state.intersect_ray(low_query)
			if hit.is_empty():
				continue

			var hit_position := hit["position"] as Vector3
			var hit_height := hit_position.y - pre_move_floor_y
			if hit_height < -0.03 or hit_height > max_step_height + step_body_clearance_margin:
				continue

			var normal := hit["normal"] as Vector3
			var block_dot := -normal.dot(direction)
			if block_dot >= 0.15 and normal.dot(Vector3.UP) < cos(floor_max_angle):
				return true
	return false


func _get_step_candidate_heights() -> Array[float]:
	var heights: Array[float] = []
	var candidate_count := 5
	for candidate_index in candidate_count:
		var height := max_step_height * float(candidate_index + 1) / float(candidate_count)
		heights.append(height)
	return heights


func _find_best_step_floor(
	space_state: PhysicsDirectSpaceState3D, direction: Vector3, pre_move_floor_y: float, exclude: Array[RID]
) -> Dictionary:
	var side_direction := Vector3.UP.cross(direction)
	if side_direction.length_squared() <= 0.000001:
		side_direction = Vector3.RIGHT
	else:
		side_direction = side_direction.normalized()

	var forward_distances: Array[float] = [
		step_forward_distance * 0.5,
		step_forward_distance * 0.75,
		step_forward_distance,
		min(step_check_distance, step_forward_distance * 1.25),
	]
	var side_offsets: Array[float] = [0.0, -0.16, 0.16]
	var top_probe_start_y := pre_move_floor_y + max_step_height + step_body_clearance_margin + 0.05
	var top_probe_end_y := pre_move_floor_y - 0.08
	var best_result: Dictionary = {}
	var best_distance := INF
	var saw_hit := false
	var saw_current_floor := false
	var saw_too_high := false
	var saw_non_walkable := false
	var saw_placement_blocked := false

	for forward_distance: float in forward_distances:
		for side_offset: float in side_offsets:
			var target_horizontal_position := global_position + direction * forward_distance + side_direction * side_offset
			var top_probe_origin := target_horizontal_position
			top_probe_origin.y = top_probe_start_y
			var top_probe_end := target_horizontal_position
			top_probe_end.y = top_probe_end_y

			var top_query := PhysicsRayQueryParameters3D.create(top_probe_origin, top_probe_end)
			top_query.exclude = exclude
			top_query.collide_with_areas = false
			var hit := space_state.intersect_ray(top_query)
			if hit.is_empty():
				continue

			saw_hit = true
			var hit_position := hit["position"] as Vector3
			var step_height := hit_position.y - pre_move_floor_y
			if step_height <= 0.02:
				saw_current_floor = true
				continue
			if step_height > max_step_height:
				saw_too_high = true
				continue

			var top_normal := hit["normal"] as Vector3
			if top_normal.dot(Vector3.UP) < cos(floor_max_angle):
				saw_non_walkable = true
				continue

			var target_transform := global_transform
			target_transform.origin = target_horizontal_position
			target_transform.origin.y = hit_position.y + step_body_clearance_margin
			var placement_result := _get_final_placement_result(target_transform)
			if placement_result == "blocked":
				saw_placement_blocked = true
				continue

			var horizontal_distance := target_horizontal_position.distance_to(global_position)
			if horizontal_distance < best_distance:
				best_distance = horizontal_distance
				best_result = {
					"is_valid": true,
					"reason": "top floor candidate found",
					"hit": hit,
					"target_position": target_horizontal_position,
					"target_transform": target_transform,
					"placement_result": placement_result,
				}

	if not best_result.is_empty():
		_step_debug("top floor candidate found")
		return best_result
	if saw_placement_blocked:
		return {"is_valid": false, "reason": "top floor candidate placement blocked"}
	if saw_non_walkable:
		return {"is_valid": false, "reason": "top probe hit non-walkable"}
	if saw_too_high:
		return {"is_valid": false, "reason": "top probe hit too high"}
	if saw_current_floor:
		return {"is_valid": false, "reason": "top probe hit current floor"}
	if saw_hit:
		return {"is_valid": false, "reason": "no valid top floor found"}
	return {"is_valid": false, "reason": "top probe sampled but no hit"}


func _get_final_placement_result(body_transform: Transform3D) -> String:
	var strict_parameters := PhysicsTestMotionParameters3D.new()
	strict_parameters.from = body_transform
	strict_parameters.motion = Vector3.ZERO
	strict_parameters.margin = safe_margin
	strict_parameters.recovery_as_collision = true
	if not PhysicsServer3D.body_test_motion(get_rid(), strict_parameters):
		return "clear"

	var relaxed_parameters := PhysicsTestMotionParameters3D.new()
	relaxed_parameters.from = body_transform
	relaxed_parameters.motion = Vector3.ZERO
	relaxed_parameters.margin = safe_margin
	relaxed_parameters.recovery_as_collision = false
	if not PhysicsServer3D.body_test_motion(get_rid(), relaxed_parameters):
		_step_debug("final placement blocked by recovery")
		return "accepted_without_recovery"

	return "blocked"


func _step_debug(reason: String) -> void:
	if not step_debug_enabled:
		return

	var now := Time.get_ticks_msec()
	if reason == _last_step_debug_reason and now - _last_step_debug_time_msec < 750:
		return

	_last_step_debug_reason = reason
	_last_step_debug_time_msec = now
	push_warning("Step-up: %s" % reason)


func _get_camera_relative_direction(input_direction: Vector2) -> Vector3:
	if input_direction == Vector2.ZERO:
		return Vector3.ZERO

	var camera := get_viewport().get_camera_3d()
	if camera == null:
		return Vector3(input_direction.x, 0.0, input_direction.y).normalized()

	var camera_basis := camera.global_transform.basis
	var camera_forward := -camera_basis.z
	var camera_right := camera_basis.x

	camera_forward.y = 0.0
	camera_right.y = 0.0

	if camera_forward.length_squared() <= 0.000001 or camera_right.length_squared() <= 0.000001:
		return Vector3(input_direction.x, 0.0, input_direction.y).normalized()

	camera_forward = camera_forward.normalized()
	camera_right = camera_right.normalized()

	return (camera_right * input_direction.x + camera_forward * -input_direction.y).normalized()


func _get_input_direction() -> Vector2:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if Input.is_key_pressed(KEY_A):
		direction.x -= 1.0
	if Input.is_key_pressed(KEY_D):
		direction.x += 1.0
	if Input.is_key_pressed(KEY_W):
		direction.y -= 1.0
	if Input.is_key_pressed(KEY_S):
		direction.y += 1.0

	return direction.limit_length(1.0)


func _update_visual_facing(movement_direction: Vector3, delta: float) -> void:
	if visual_root == null:
		return

	if movement_direction.length_squared() <= 0.000001:
		return

	var desired_yaw := atan2(movement_direction.x, movement_direction.z)
	visual_root.rotation.y = lerp_angle(visual_root.rotation.y, desired_yaw, clampf(visual_turn_speed * delta, 0.0, 1.0))

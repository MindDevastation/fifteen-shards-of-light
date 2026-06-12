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
@export var step_debug_enabled: bool = false

@onready var visual_root: Node3D = $CharacterVisualRoot
@onready var animation_controller: FoxHeroineAnimationController = $FoxHeroineAnimationController

var _jump_cooldown_remaining: float = 0.0
var _interact_cooldown_remaining: float = 0.0
var _last_step_debug_reason := ""
var _last_step_debug_time_msec := 0



func _physics_process(delta: float) -> void:
	_jump_cooldown_remaining = max(_jump_cooldown_remaining - delta, 0.0)
	_interact_cooldown_remaining = max(_interact_cooldown_remaining - delta, 0.0)

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
	if not _has_blocking_step_collision(direction):
		if _was_horizontal_motion_blocked(delta, direction, position_before_move, current_speed):
			_step_debug("no low obstacle detected")
		return

	var space_state := get_world_3d().direct_space_state
	var exclude: Array[RID] = []
	exclude.append(get_rid())
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

		var forward_raised_position := raised_transform.origin + forward_motion
		var top_floor_hit := _find_step_floor(space_state, forward_raised_position, exclude)
		if top_floor_hit.is_empty():
			last_failure_reason = "no top floor found"
			continue

		var top_position := top_floor_hit["position"] as Vector3
		var step_height := top_position.y - global_position.y
		if step_height <= 0.02 or step_height > max_step_height:
			last_failure_reason = "step height too low/high"
			continue

		var top_normal := top_floor_hit["normal"] as Vector3
		if top_normal.dot(Vector3.UP) < cos(floor_max_angle):
			last_failure_reason = "top surface not walkable"
			continue

		var target_transform := global_transform
		target_transform.origin = global_position + direction * step_forward_distance
		target_transform.origin.y = top_position.y
		if not _is_body_transform_clear(target_transform):
			last_failure_reason = "final body placement blocked"
			continue

		global_transform = target_transform
		velocity.y = 0.0
		_step_debug("candidate accepted")
		return

	_step_debug(last_failure_reason)


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


func _get_step_candidate_heights() -> Array[float]:
	var heights: Array[float] = []
	var candidate_count := 5
	for candidate_index in candidate_count:
		var height := max_step_height * float(candidate_index + 1) / float(candidate_count)
		heights.append(height)
	return heights


func _find_step_floor(space_state: PhysicsDirectSpaceState3D, forward_raised_position: Vector3, exclude: Array[RID]) -> Dictionary:
	var top_probe_origin := forward_raised_position + Vector3.UP * step_body_clearance_margin
	var top_probe_end := forward_raised_position - Vector3.UP * step_down_probe_distance
	var top_query := PhysicsRayQueryParameters3D.create(top_probe_origin, top_probe_end)
	top_query.exclude = exclude
	top_query.collide_with_areas = false
	return space_state.intersect_ray(top_query)


func _is_body_transform_clear(body_transform: Transform3D) -> bool:
	var motion_parameters := PhysicsTestMotionParameters3D.new()
	motion_parameters.from = body_transform
	motion_parameters.motion = Vector3.ZERO
	motion_parameters.margin = safe_margin
	motion_parameters.recovery_as_collision = true
	return not PhysicsServer3D.body_test_motion(get_rid(), motion_parameters)


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

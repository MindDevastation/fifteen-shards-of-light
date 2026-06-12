extends CharacterBody3D

const JUMP_COOLDOWN_SECONDS := 0.1
const INTERACT_COOLDOWN_SECONDS := 0.1

@export var walk_speed: float = 4.25
@export var run_speed: float = 6.25
@export var jump_velocity: float = 4.025
@export var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@export_range(1.0, 20.0, 0.1) var visual_turn_speed: float = 5.0
@export_range(0.1, 0.6, 0.01) var max_step_height: float = 0.35
@export_range(0.1, 0.8, 0.01) var step_check_distance: float = 0.35
@export_range(1.0, 40.0, 0.5) var step_smoothness: float = 18.0

@onready var visual_root: Node3D = $CharacterVisualRoot
@onready var animation_controller: FoxHeroineAnimationController = $FoxHeroineAnimationController

var _jump_cooldown_remaining: float = 0.0
var _interact_cooldown_remaining: float = 0.0



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
	move_and_slide()
	_try_step_up(delta, movement_direction, was_on_floor)


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




func _try_step_up(delta: float, movement_direction: Vector3, was_on_floor: bool) -> void:
	if not was_on_floor or not is_on_floor():
		return
	if movement_direction.length_squared() <= 0.000001:
		return
	if max_step_height <= 0.0 or step_check_distance <= 0.0:
		return

	var space_state := get_world_3d().direct_space_state
	var direction := movement_direction.normalized()
	var up := Vector3.UP
	var floor_y := global_position.y
	var exclude := [get_rid()]

	var low_start := global_position + up * 0.08
	var low_end := low_start + direction * step_check_distance
	var low_query := PhysicsRayQueryParameters3D.create(low_start, low_end)
	low_query.exclude = exclude
	low_query.collide_with_areas = false
	var low_hit := space_state.intersect_ray(low_query)
	if low_hit.is_empty():
		return

	var high_start := global_position + up * (max_step_height + 0.12)
	var high_end := high_start + direction * step_check_distance
	var high_query := PhysicsRayQueryParameters3D.create(high_start, high_end)
	high_query.exclude = exclude
	high_query.collide_with_areas = false
	if not space_state.intersect_ray(high_query).is_empty():
		return

	var top_probe_origin := global_position + direction * step_check_distance + up * (max_step_height + 0.25)
	var top_probe_end := global_position + direction * step_check_distance + up * 0.02
	var top_query := PhysicsRayQueryParameters3D.create(top_probe_origin, top_probe_end)
	top_query.exclude = exclude
	top_query.collide_with_areas = false
	var top_hit := space_state.intersect_ray(top_query)
	if top_hit.is_empty():
		return

	var top_position := top_hit["position"] as Vector3
	var step_height := top_position.y - floor_y
	if step_height <= 0.01 or step_height > max_step_height:
		return

	var top_normal := top_hit["normal"] as Vector3
	if top_normal.dot(up) < cos(floor_max_angle):
		return

	var clearance_start := global_position + up * (max_step_height + 0.9)
	var clearance_end := clearance_start + direction * step_check_distance
	var clearance_query := PhysicsRayQueryParameters3D.create(clearance_start, clearance_end)
	clearance_query.exclude = exclude
	clearance_query.collide_with_areas = false
	if not space_state.intersect_ray(clearance_query).is_empty():
		return

	var step_lerp := clampf(step_smoothness * delta, 0.0, 1.0)
	global_position.y += lerpf(0.0, step_height, step_lerp)


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

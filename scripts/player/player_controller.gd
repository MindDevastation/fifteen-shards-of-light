extends CharacterBody3D

@export var walk_speed: float = 5.0
@export var run_speed: float = 8.5
@export var jump_velocity: float = 4.5
@export var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@export_range(1.0, 20.0, 0.1) var visual_turn_speed: float = 10.0

@onready var visual_root: Node3D = $PlaceholderMesh


func _physics_process(delta: float) -> void:
	var input_direction := _get_input_direction()
	var movement_direction := _get_camera_relative_direction(input_direction)

	var current_speed := walk_speed
	if Input.is_key_pressed(KEY_SHIFT):
		current_speed = run_speed

	velocity.x = movement_direction.x * current_speed
	velocity.z = movement_direction.z * current_speed
	_update_visual_facing(movement_direction, delta)

	if not is_on_floor():
		velocity.y -= gravity * delta
	elif Input.is_key_pressed(KEY_SPACE):
		velocity.y = jump_velocity
	else:
		velocity.y = 0.0

	move_and_slide()


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

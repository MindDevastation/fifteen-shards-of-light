extends CharacterBody3D

@export var movement_speed: float = 5.0
@export var jump_velocity: float = 4.5
@export var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta: float) -> void:
	var input_direction := _get_input_direction()
	var movement_direction := Vector3(input_direction.x, 0.0, input_direction.y).normalized()

	velocity.x = movement_direction.x * movement_speed
	velocity.z = movement_direction.z * movement_speed

	if not is_on_floor():
		velocity.y -= gravity * delta
	elif Input.is_key_pressed(KEY_SPACE):
		velocity.y = jump_velocity
	else:
		velocity.y = 0.0

	move_and_slide()


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

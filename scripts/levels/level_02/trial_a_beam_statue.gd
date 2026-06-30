extends Area3D
class_name TrialABeamStatue
signal locked(statue_id: StringName)
@export var statue_id: StringName
@export var state_index := 0
@export var correct_index := 1
var armed := false
var is_locked := false
func arm() -> void: armed = true; monitoring = true
func interact(_player: Node3D=null) -> void:
	if not armed or is_locked: return
	state_index = (state_index + 1) % 3
	rotation_degrees.y = float(state_index) * 120.0
	if state_index == correct_index:
		is_locked = true
		locked.emit(statue_id)

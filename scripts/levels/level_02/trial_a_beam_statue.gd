extends Area3D
class_name TrialABeamStatue

signal locked(statue_id: StringName)
signal state_changed(statue_id: StringName, state_index: int)

@export var statue_id: StringName
@export var state_index := 0
@export var correct_index := 1
@export var rotation_duration := 0.35
@export var interaction_cooldown := 0.25
var armed := false
var is_locked := false
var _rotating := false
var _cooldown_left := 0.0

func _process(delta: float) -> void:
	_cooldown_left = maxf(0.0, _cooldown_left - delta)

func arm() -> void:
	armed = true
	monitoring = true

func disarm() -> void:
	armed = false
	monitoring = false

func can_player_interact(_player: Node = null) -> bool:
	return armed and not is_locked and not _rotating and _cooldown_left <= 0.0

func interact(player: Node = null) -> void:
	if not can_player_interact(player):
		return
	_rotate_to((state_index + 1) % 3)

func _rotate_to(next_index: int) -> void:
	_rotating = true
	_cooldown_left = interaction_cooldown
	state_index = next_index
	var tween := create_tween()
	tween.tween_property(self, "rotation_degrees:y", float(state_index) * 120.0, rotation_duration)
	tween.finished.connect(_finish_rotation)
	state_changed.emit(statue_id, state_index)

func _finish_rotation() -> void:
	_rotating = false
	if state_index == correct_index and not is_locked:
		is_locked = true
		locked.emit(statue_id)

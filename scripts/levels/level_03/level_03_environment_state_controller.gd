class_name Level03EnvironmentStateController
extends Node3D

signal phase_changed(phase: StringName)
signal guidance_changed(active: bool)

@export var debug_enabled: bool = false
const PHASES := [&"E0", &"E1", &"E2", &"E3", &"E4", &"E5", &"E6"]
var current_phase: StringName = &"E0"
var _phase_index := 0
var _generation := 0
var guidance_active := false

func request_phase(phase: StringName) -> bool:
	var next_index := PHASES.find(phase)
	if next_index < 0 or next_index < _phase_index:
		return false
	_generation += 1
	_phase_index = next_index
	current_phase = phase
	_apply_phase_visuals(phase, _generation)
	phase_changed.emit(phase)
	return true

func request_meadow_partial(completed_count: int) -> void:
	if completed_count == 1:
		request_phase(&"E3")
	elif completed_count == 2:
		request_phase(&"E4")

func request_guidance_active(active: bool) -> bool:
	guidance_active = active
	set_meta("guidance_active", active)
	guidance_changed.emit(active)
	return true

func get_phase() -> StringName:
	return current_phase

func get_generation() -> int:
	return _generation

func _apply_phase_visuals(phase: StringName, generation: int) -> void:
	if generation != _generation:
		return
	set_meta("level_03_environment_phase", phase)

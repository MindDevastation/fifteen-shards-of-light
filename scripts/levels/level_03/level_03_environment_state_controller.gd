class_name Level03EnvironmentStateController
extends Node3D

signal phase_changed(phase: StringName)

@export var debug_enabled: bool = false
var current_phase: StringName = &"E0"
var _generation := 0

func request_phase(phase: StringName) -> bool:
	if not [&"E0", &"E1", &"E2", &"E3", &"E4", &"E5", &"E6"].has(phase):
		return false
	_generation += 1
	current_phase = phase
	phase_changed.emit(phase)
	return true

func get_generation() -> int:
	return _generation


func request_guidance_active(active: bool) -> bool:
	set_meta("guidance_active", active)
	return true

func get_phase() -> StringName:
	return current_phase

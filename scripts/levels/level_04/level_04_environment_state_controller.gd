extends Node
class_name Level04EnvironmentStateController

signal environment_phase_changed(previous, current)
signal weather_weave_terminal(source)
signal configuration_error(component, message)

enum EnvironmentPhase {
	E0,
	E1,
	E2,
	E3,
}

@export var world_environment_path := NodePath("../WorldEnvironment")
@export var lighting_root_path := NodePath("../LightingRoot")
@export var canopy_guidance_path := NodePath("../../VFXRoot/RemainingBranchGuidanceRoot/CanopyGuidance")
@export var ripple_guidance_path := NodePath("../../VFXRoot/RemainingBranchGuidanceRoot/RippleGuidance")
@export var weather_weave_vfx_path := NodePath("../../VFXRoot/WeatherWeaveVFX")

var _phase: EnvironmentPhase = EnvironmentPhase.E0
var _active_tween_domains: Array[StringName] = []
var _weather_weave_generation := 0

func _ready() -> void:
	validate_local_resources()
	_apply_e0_placeholder()

func request_phase(phase: EnvironmentPhase) -> bool:
	if phase == _phase:
		if phase == EnvironmentPhase.E0:
			_apply_e0_placeholder()
		return true
	var previous := _phase
	_phase = phase
	if _phase == EnvironmentPhase.E0:
		_apply_e0_placeholder()
	environment_phase_changed.emit(previous, _phase)
	return true

func start_weather_weave() -> int:
	_weather_weave_generation += 1
	return _weather_weave_generation

func get_phase() -> EnvironmentPhase:
	return _phase

func request_remaining_branch_guidance(branch_id: StringName) -> bool:
	var canopy_guidance := get_node_or_null(canopy_guidance_path) as Node3D
	var ripple_guidance := get_node_or_null(ripple_guidance_path) as Node3D
	if canopy_guidance != null:
		canopy_guidance.visible = branch_id == &"CANOPY"
	if ripple_guidance != null:
		ripple_guidance.visible = branch_id == &"RIPPLE"
	return branch_id == &"CANOPY" or branch_id == &"RIPPLE"


func debug_get_active_tween_domains() -> Array[StringName]:
	return _active_tween_domains.duplicate()

func validate_local_resources() -> bool:
	var ok := true
	ok = _validate_path(&"world_environment", world_environment_path, "WorldEnvironment") and ok
	ok = _validate_path(&"lighting_root", lighting_root_path, "Node3D") and ok
	ok = _validate_path(&"canopy_guidance", canopy_guidance_path, "Node3D") and ok
	ok = _validate_path(&"ripple_guidance", ripple_guidance_path, "Node3D") and ok
	ok = _validate_path(&"weather_weave_vfx", weather_weave_vfx_path, "Node3D") and ok
	return ok

func _apply_e0_placeholder() -> void:
	var lighting_root := get_node_or_null(lighting_root_path)
	if lighting_root == null:
		return
	var warm_sun := lighting_root.get_node_or_null("WarmSun")
	if warm_sun is Light3D:
		warm_sun.light_energy = 1.05
	var cool_fill := lighting_root.get_node_or_null("CoolCloudFill")
	if cool_fill is Light3D:
		cool_fill.light_energy = 0.28
	var pavilion_guidance := lighting_root.get_node_or_null("PavilionGuidanceLight")
	if pavilion_guidance is Light3D:
		pavilion_guidance.light_energy = 0.18
	_active_tween_domains.clear()

func _validate_path(key: StringName, path: NodePath, expected_type: String) -> bool:
	var resolved := get_node_or_null(path)
	var ok := resolved != null
	if ok:
		ok = resolved.is_class(expected_type) or resolved.get_class() == expected_type
	if not ok:
		push_error("Level04EnvironmentStateController: %s dependency failed at %s" % [String(key), str(path)])
		configuration_error.emit(&"Level04EnvironmentStateController", "%s dependency failed at %s" % [String(key), str(path)])
	return ok

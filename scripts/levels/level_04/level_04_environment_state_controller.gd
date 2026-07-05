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

const BRANCH_CANOPY := &"CANOPY"
const BRANCH_RIPPLE := &"RIPPLE"
const WEATHER_SOURCE_CALLBACK := &"callback"
const WEATHER_SOURCE_FALLBACK := &"fallback"
const _WEATHER_WEAVE_FALLBACK_SECONDS := 2.5
const _DOMAIN_COLOR := &"color"
const _DOMAIN_FOG := &"fog"
const _DOMAIN_LIGHT := &"light"
const _DOMAIN_GUIDANCE := &"guidance"
const _DOMAIN_WEAVE := &"weave"

@export var world_environment_path := NodePath("../WorldEnvironment")
@export var lighting_root_path := NodePath("../LightingRoot")
@export var canopy_guidance_path := NodePath("../../VFXRoot/RemainingBranchGuidanceRoot/CanopyGuidance")
@export var ripple_guidance_path := NodePath("../../VFXRoot/RemainingBranchGuidanceRoot/RippleGuidance")
@export var weather_weave_vfx_path := NodePath("../../VFXRoot/WeatherWeaveVFX")

var _phase: EnvironmentPhase = EnvironmentPhase.E0
var _active_tween_domains: Array[StringName] = []
var _weather_weave_generation := 0
var _weather_weave_terminal_emitted := false
var _weather_weave_terminal_source := &""
var _last_remaining_branch_guidance := &""

func _ready() -> void:
	validate_local_resources()
	_apply_e0_placeholder()

func request_phase(phase: EnvironmentPhase) -> bool:
	if phase == _phase:
		return true
	if phase < _phase:
		return false
	# Slice 8 deliberately rejects forward skips so each semantic phase remains observable.
	if int(phase) - int(_phase) != 1:
		return false
	var previous := _phase
	_phase = phase
	if _phase == EnvironmentPhase.E0:
		_apply_e0_placeholder()
	elif _phase == EnvironmentPhase.E1:
		_apply_e1_placeholder()
	elif _phase == EnvironmentPhase.E2:
		_apply_e2_placeholder()
	elif _phase == EnvironmentPhase.E3:
		_apply_e3_placeholder()
	environment_phase_changed.emit(previous, _phase)
	return true

func start_weather_weave() -> int:
	_weather_weave_generation += 1
	_weather_weave_terminal_emitted = false
	_weather_weave_terminal_source = &""
	_apply_e2_placeholder()
	var generation := _weather_weave_generation
	var tree := get_tree()
	if tree != null:
		tree.create_timer(_WEATHER_WEAVE_FALLBACK_SECONDS).timeout.connect(_on_weather_weave_fallback_timeout.bind(generation), CONNECT_ONE_SHOT)
	return generation

func get_phase() -> EnvironmentPhase:
	return _phase

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

func request_remaining_branch_guidance(branch_id: StringName) -> bool:
	if branch_id != BRANCH_CANOPY and branch_id != BRANCH_RIPPLE:
		return false
	var canopy_guidance := get_node_or_null(canopy_guidance_path) as Node3D
	var ripple_guidance := get_node_or_null(ripple_guidance_path) as Node3D
	if canopy_guidance == null or ripple_guidance == null:
		configuration_error.emit(&"Level04EnvironmentStateController", "remaining guidance dependency missing")
		return false
	canopy_guidance.visible = branch_id == BRANCH_CANOPY
	ripple_guidance.visible = branch_id == BRANCH_RIPPLE
	_last_remaining_branch_guidance = branch_id
	_register_domain(_DOMAIN_GUIDANCE)
	_apply_remaining_guidance_summary(branch_id)
	return true

func debug_request_weather_weave_callback(generation: int, source: StringName = WEATHER_SOURCE_CALLBACK) -> bool:
	return _complete_weather_weave(generation, source)

func debug_get_weather_weave_generation() -> int:
	return _weather_weave_generation

func debug_is_weather_weave_terminal_emitted() -> bool:
	return _weather_weave_terminal_emitted

func request_debug_snapshot() -> Dictionary:
	return {
		"phase": EnvironmentPhase.keys()[_phase],
		"active_tween_domains": debug_get_active_tween_domains(),
		"last_remaining_branch_guidance": _last_remaining_branch_guidance,
		"weather_weave_generation": _weather_weave_generation,
		"weather_weave_terminal_emitted": _weather_weave_terminal_emitted,
		"weather_weave_terminal_source": _weather_weave_terminal_source,
		"weather_weave_vfx_active": _is_weather_weave_visible(),
	}

func _apply_e0_placeholder() -> void:
	_set_light_energy("WarmSun", 1.05)
	_set_light_energy("CoolCloudFill", 0.28)
	_set_light_energy("PavilionGuidanceLight", 0.18)
	_set_weather_weave_visible(false)
	_register_domain(_DOMAIN_COLOR)
	_register_domain(_DOMAIN_FOG)
	_register_domain(_DOMAIN_LIGHT)

func _apply_e1_placeholder() -> void:
	_set_light_energy("WarmSun", 1.05)
	_set_light_energy("CoolCloudFill", 0.28)
	_set_light_energy("PavilionGuidanceLight", 0.2)
	_register_domain(_DOMAIN_LIGHT)
	_register_domain(_DOMAIN_GUIDANCE)

func _apply_e2_placeholder() -> void:
	_set_light_energy("WarmSun", 0.92)
	_set_light_energy("CoolCloudFill", 0.34)
	_set_light_energy("PavilionGuidanceLight", 0.42)
	_set_weather_weave_visible(true)
	_register_domain(_DOMAIN_COLOR)
	_register_domain(_DOMAIN_FOG)
	_register_domain(_DOMAIN_LIGHT)
	_register_domain(_DOMAIN_WEAVE)

func _apply_e3_placeholder() -> void:
	_set_light_energy("WarmSun", 0.86)
	_set_light_energy("CoolCloudFill", 0.36)
	_set_light_energy("PavilionGuidanceLight", 0.36)
	_set_weather_weave_visible(true)
	_register_domain(_DOMAIN_COLOR)
	_register_domain(_DOMAIN_FOG)
	_register_domain(_DOMAIN_LIGHT)
	_register_domain(_DOMAIN_WEAVE)

func _apply_remaining_guidance_summary(branch_id: StringName) -> void:
	var root := get_node_or_null(NodePath("../../VFXRoot/RemainingBranchGuidanceRoot/L04_VFX_RemainingGuidance")) as Node3D
	if root == null:
		return
	root.visible = true
	var canopy_hint := root.get_node_or_null("CanopyRemainingHint") as Node3D
	var ripple_hint := root.get_node_or_null("RippleRemainingHint") as Node3D
	if canopy_hint != null:
		canopy_hint.visible = branch_id == BRANCH_CANOPY
	if ripple_hint != null:
		ripple_hint.visible = branch_id == BRANCH_RIPPLE

func _set_light_energy(light_name: String, energy: float) -> void:
	var lighting_root := get_node_or_null(lighting_root_path)
	if lighting_root == null:
		return
	var light := lighting_root.get_node_or_null(light_name)
	if light is Light3D:
		light.light_energy = energy

func _set_weather_weave_visible(active: bool) -> void:
	var weather_root := get_node_or_null(weather_weave_vfx_path) as Node3D
	if weather_root != null:
		weather_root.visible = active
		var weave := weather_root.get_node_or_null("L04_VFX_WeatherWeave") as Node3D
		if weave != null:
			weave.visible = active

func _is_weather_weave_visible() -> bool:
	var weather_root := get_node_or_null(weather_weave_vfx_path) as Node3D
	if weather_root == null:
		return false
	var weave := weather_root.get_node_or_null("L04_VFX_WeatherWeave") as Node3D
	return weather_root.visible and (weave == null or weave.visible)

func _on_weather_weave_fallback_timeout(generation: int) -> void:
	_complete_weather_weave(generation, WEATHER_SOURCE_FALLBACK)

func _complete_weather_weave(generation: int, source: StringName) -> bool:
	if generation != _weather_weave_generation:
		return false
	if _weather_weave_terminal_emitted:
		return false
	_weather_weave_terminal_emitted = true
	_weather_weave_terminal_source = source
	request_phase(EnvironmentPhase.E3)
	weather_weave_terminal.emit(source)
	return true

func _register_domain(domain: StringName) -> void:
	if not _active_tween_domains.has(domain):
		_active_tween_domains.append(domain)
	_active_tween_domains.sort()

func _validate_path(key: StringName, path: NodePath, expected_type: String) -> bool:
	var resolved := get_node_or_null(path)
	var ok := resolved != null
	if ok:
		ok = resolved.is_class(expected_type) or resolved.get_class() == expected_type
	if not ok:
		push_error("Level04EnvironmentStateController: %s dependency failed at %s" % [String(key), str(path)])
		configuration_error.emit(&"Level04EnvironmentStateController", "%s dependency failed at %s" % [String(key), str(path)])
	return ok

extends Node
class_name Level04ProgressController

signal configuration_error(component, message)
signal staged_dependencies_unresolved(dependencies)

enum ConfigurationMode {
	STAGED_SLICE_3,
	PRODUCTION,
}

enum MacroState {
	CANDIDATE_UNSET,
	FIRST_CANDIDATE_CANOPY,
	FIRST_CANDIDATE_RIPPLE,
	FIRST_SHARD_AVAILABLE,
	FIRST_REWARD_COMPLETE,
	REMAINING_DEFERRED,
	SECOND_SHARD_AVAILABLE,
	BOTH_REWARDS_COMPLETE,
	MAIN_TEXT,
	EXIT,
}

const BRANCH_CANOPY := &"CANOPY"
const BRANCH_RIPPLE := &"RIPPLE"
const _UNSET_BRANCH := &""
const _EXPECTED_FUTURE_DEPENDENCY_COUNT := 8

@export var configuration_mode: ConfigurationMode = ConfigurationMode.STAGED_SLICE_3
@export var canopy_controller_path := NodePath("../../GameplayRoot/PuzzleRoot/ChangingCanopyPuzzle/ChangingCanopyController")
@export var ripple_controller_path := NodePath("../../GameplayRoot/PuzzleRoot/RippleConversationPuzzle/RippleConversationController")
@export var shard_slot_08_path := NodePath("../../GameplayRoot/ShardRoot/ShardSlot_08")
@export var shard_slot_09_path := NodePath("../../GameplayRoot/ShardRoot/ShardSlot_09")
@export var canopy_remaining_zone_path := NodePath("../../GameplayRoot/RouteAuthorityRoot/CanopyRemainingShardZone")
@export var ripple_remaining_zone_path := NodePath("../../GameplayRoot/RouteAuthorityRoot/RippleRemainingShardZone")
@export var environment_controller_path := NodePath("../../EnvironmentStateRoot/Level04EnvironmentStateController")
@export var finale_controller_path := NodePath("../Level04FinaleController")
@export var portal_adapter_path := NodePath("../Level04PortalAdapter")
@export var recovery_controller_path := NodePath("../Level04RecoveryController")

var _state: MacroState = MacroState.CANDIDATE_UNSET
var _first_branch_candidate: StringName = _UNSET_BRANCH
var _remaining_branch: StringName = _UNSET_BRANCH
var _collected_shard_ids: Array[StringName] = []
var _present_dependency_validation: Dictionary = {}
var _deliberately_unresolved_dependencies: Array[StringName] = []
var _staged_diagnostic_emitted := false

func _ready() -> void:
	if configuration_mode == ConfigurationMode.STAGED_SLICE_3:
		validate_available_dependencies()
	else:
		validate_production_configuration()

func validate_available_dependencies() -> bool:
	_present_dependency_validation.clear()
	_deliberately_unresolved_dependencies = _collect_missing_future_dependencies()
	var ok := _validate_internal_invariants()
	ok = _validate_present_dependency(&"environment_controller", environment_controller_path, "Level04EnvironmentStateController") and ok
	ok = _validate_present_dependency(&"recovery_controller", recovery_controller_path, "Level04RecoveryController") and ok
	if _deliberately_unresolved_dependencies.size() != _EXPECTED_FUTURE_DEPENDENCY_COUNT:
		_emit_configuration_error(&"Level04ProgressController", "staged future dependency set does not match the Slice 3 contract")
		ok = false
	_emit_staged_diagnostic_once()
	return ok

func validate_production_configuration() -> bool:
	_present_dependency_validation.clear()
	_deliberately_unresolved_dependencies = _collect_missing_future_dependencies()
	var ok := _validate_internal_invariants()
	ok = _validate_present_dependency(&"canopy_controller", canopy_controller_path, "Node") and ok
	ok = _validate_present_dependency(&"ripple_controller", ripple_controller_path, "Node") and ok
	ok = _validate_present_dependency(&"shard_slot_08", shard_slot_08_path, "Node3D") and ok
	ok = _validate_present_dependency(&"shard_slot_09", shard_slot_09_path, "Node3D") and ok
	ok = _validate_present_dependency(&"canopy_remaining_zone", canopy_remaining_zone_path, "Node") and ok
	ok = _validate_present_dependency(&"ripple_remaining_zone", ripple_remaining_zone_path, "Node") and ok
	ok = _validate_present_dependency(&"environment_controller", environment_controller_path, "Level04EnvironmentStateController") and ok
	ok = _validate_present_dependency(&"finale_controller", finale_controller_path, "Node") and ok
	ok = _validate_present_dependency(&"portal_adapter", portal_adapter_path, "Node") and ok
	ok = _validate_present_dependency(&"recovery_controller", recovery_controller_path, "Level04RecoveryController") and ok
	return ok

func get_state() -> MacroState:
	return _state

func get_first_branch_candidate() -> StringName:
	return _first_branch_candidate

func get_remaining_branch() -> StringName:
	return _remaining_branch

func get_collected_shard_ids() -> Array[StringName]:
	return _collected_shard_ids.duplicate()

func report_puzzle_completed(branch_id: StringName) -> bool:
	if branch_id != BRANCH_CANOPY and branch_id != BRANCH_RIPPLE:
		return false
	if _state != MacroState.CANDIDATE_UNSET:
		return false
	_first_branch_candidate = branch_id
	if branch_id == BRANCH_CANOPY:
		_remaining_branch = BRANCH_RIPPLE
		_state = MacroState.FIRST_CANDIDATE_CANOPY
	else:
		_remaining_branch = BRANCH_CANOPY
		_state = MacroState.FIRST_CANDIDATE_RIPPLE
	return true

func report_remaining_zone_presence(branch_id, inside) -> void:
	pass

func request_debug_snapshot() -> Dictionary:
	return {
		"configuration_mode": ConfigurationMode.keys()[configuration_mode],
		"state": MacroState.keys()[_state],
		"first_branch_candidate": _first_branch_candidate,
		"remaining_branch": _remaining_branch,
		"collected_shard_ids": _collected_shard_ids.duplicate(),
		"deliberately_unresolved_dependencies": _deliberately_unresolved_dependencies.duplicate(),
		"present_dependency_validation": _present_dependency_validation.duplicate(true),
	}

func _validate_internal_invariants() -> bool:
	var ok := true
	_present_dependency_validation[&"canonical_ids"] = {"ok": true, "message": "canonical branch IDs are distinct"}
	if BRANCH_CANOPY == BRANCH_RIPPLE or BRANCH_CANOPY == _UNSET_BRANCH or BRANCH_RIPPLE == _UNSET_BRANCH:
		_present_dependency_validation[&"canonical_ids"] = {"ok": false, "message": "canonical branch IDs are invalid"}
		_emit_configuration_error(&"Level04ProgressController", "canonical branch IDs are invalid")
		ok = false
	if _collected_shard_ids.size() != 0:
		_emit_configuration_error(&"Level04ProgressController", "Slice 3 must not pre-populate collected shards")
		ok = false
	return ok

func _validate_present_dependency(key: StringName, path: NodePath, expected_type: String) -> bool:
	var resolved := get_node_or_null(path)
	var ok := resolved != null
	if ok and expected_type != "Node":
		ok = resolved.is_class(expected_type) or resolved.get_class() == expected_type or resolved.get_script() != null and resolved.get_script().get_global_name() == expected_type
	_present_dependency_validation[key] = {"ok": ok, "path": str(path), "expected_type": expected_type}
	if not ok:
		_emit_configuration_error(&"Level04ProgressController", "%s dependency failed at %s" % [String(key), str(path)])
	return ok

func _collect_missing_future_dependencies() -> Array[StringName]:
	var missing: Array[StringName] = []
	_add_missing(missing, &"canopy_controller_path", canopy_controller_path)
	_add_missing(missing, &"ripple_controller_path", ripple_controller_path)
	_add_missing(missing, &"shard_slot_08_path", shard_slot_08_path)
	_add_missing(missing, &"shard_slot_09_path", shard_slot_09_path)
	_add_missing(missing, &"canopy_remaining_zone_path", canopy_remaining_zone_path)
	_add_missing(missing, &"ripple_remaining_zone_path", ripple_remaining_zone_path)
	_add_missing(missing, &"finale_controller_path", finale_controller_path)
	_add_missing(missing, &"portal_adapter_path", portal_adapter_path)
	return missing

func _add_missing(missing: Array[StringName], label: StringName, path: NodePath) -> void:
	if get_node_or_null(path) == null:
		missing.append(label)

func _emit_staged_diagnostic_once() -> void:
	if _staged_diagnostic_emitted:
		return
	_staged_diagnostic_emitted = true
	print("Level04ProgressController Slice 3 staged unresolved future dependencies: %s" % [str(_deliberately_unresolved_dependencies)])
	staged_dependencies_unresolved.emit(_deliberately_unresolved_dependencies.duplicate())

func _emit_configuration_error(component: StringName, message: String) -> void:
	push_error("%s: %s" % [String(component), message])
	configuration_error.emit(component, message)

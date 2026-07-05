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
const SHARD_08 := &"Shard_08"
const SHARD_09 := &"Shard_09"
const SUSPENSION_SHARD_REWARD := &"shard_reward"
const CANOPY_REMAINING_ZONE := &"CanopyRemainingShardZone"
const RIPPLE_REMAINING_ZONE := &"RippleRemainingShardZone"
const _EXPECTED_FUTURE_DEPENDENCY_COUNT := 2

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
@export var shard_reward_controller_path := NodePath("../ShardRewardSequenceController")
@export var shard_reward_overlay_path := NodePath("../../UILayer/ShardRewardOverlay")
@export var player_path := NodePath("../../PlayerRoot/Player")

var _state: MacroState = MacroState.CANDIDATE_UNSET
var _first_branch_candidate: StringName = _UNSET_BRANCH
var _remaining_branch: StringName = _UNSET_BRANCH
var _collected_shard_ids: Array[StringName] = []
var _present_dependency_validation: Dictionary = {}
var _deliberately_unresolved_dependencies: Array[StringName] = []
var _staged_diagnostic_emitted := false
var _active_first_shard_slot: Node = null
var _active_second_shard_slot: Node = null
var _completed_branches: Array[StringName] = []
var _remaining_zone_occupancy := {
	BRANCH_CANOPY: false,
	BRANCH_RIPPLE: false,
}
var _first_reward_in_progress := false
var _first_reward_complete := false
var _e1_request_issued := false
var _second_reward_in_progress := false
var _second_reward_complete := false
var _both_rewards_complete := false

func _ready() -> void:
	if configuration_mode == ConfigurationMode.STAGED_SLICE_3:
		validate_available_dependencies()
	else:
		validate_production_configuration()

func validate_available_dependencies() -> bool:
	_present_dependency_validation.clear()
	_deliberately_unresolved_dependencies = _collect_missing_future_dependencies()
	var ok := _validate_internal_invariants()
	ok = _validate_present_dependency(&"canopy_controller", canopy_controller_path, "ChangingCanopyController") and ok
	ok = _validate_present_dependency(&"ripple_controller", ripple_controller_path, "RippleConversationController") and ok
	ok = _validate_present_dependency(&"shard_slot_08", shard_slot_08_path, "Level04ShardSlot") and ok
	ok = _validate_present_dependency(&"shard_slot_09", shard_slot_09_path, "Level04ShardSlot") and ok
	ok = _validate_present_dependency(&"shard_reward_controller", shard_reward_controller_path, "ShardRewardSequenceController") and ok
	ok = _validate_present_dependency(&"shard_reward_overlay", shard_reward_overlay_path, "Node") and ok
	ok = _validate_present_dependency(&"player", player_path, "Node") and ok
	ok = _validate_present_dependency(&"canopy_remaining_zone", canopy_remaining_zone_path, "Area3D") and ok
	ok = _validate_present_dependency(&"ripple_remaining_zone", ripple_remaining_zone_path, "Area3D") and ok
	ok = _validate_present_dependency(&"environment_controller", environment_controller_path, "Level04EnvironmentStateController") and ok
	ok = _validate_present_dependency(&"recovery_controller", recovery_controller_path, "Level04RecoveryController") and ok
	_wire_slice_6_dependencies()
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
	ok = _validate_present_dependency(&"shard_reward_controller", shard_reward_controller_path, "ShardRewardSequenceController") and ok
	ok = _validate_present_dependency(&"shard_reward_overlay", shard_reward_overlay_path, "Node") and ok
	ok = _validate_present_dependency(&"player", player_path, "Node") and ok
	_wire_slice_6_dependencies()
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
	if not _completed_branches.has(branch_id):
		_completed_branches.append(branch_id)
	if _state == MacroState.CANDIDATE_UNSET:
		_first_branch_candidate = branch_id
		if branch_id == BRANCH_CANOPY:
			_remaining_branch = BRANCH_RIPPLE
			_state = MacroState.FIRST_CANDIDATE_CANOPY
		else:
			_remaining_branch = BRANCH_CANOPY
			_state = MacroState.FIRST_CANDIDATE_RIPPLE
		_reveal_first_candidate_shard(branch_id)
		return true
	_evaluate_second_shard_eligibility()
	return false

func report_remaining_zone_presence(branch_id, inside) -> void:
	var normalized_branch := StringName(branch_id)
	if normalized_branch != BRANCH_CANOPY and normalized_branch != BRANCH_RIPPLE:
		return
	var normalized_inside := bool(inside)
	if _remaining_zone_occupancy[normalized_branch] == normalized_inside:
		return
	_remaining_zone_occupancy[normalized_branch] = normalized_inside
	_evaluate_second_shard_eligibility()

func _on_remaining_zone_body_entered(body: Node, branch_id: StringName) -> void:
	if _is_configured_player(body):
		report_remaining_zone_presence(branch_id, true)

func _on_remaining_zone_body_exited(body: Node, branch_id: StringName) -> void:
	if _is_configured_player(body):
		report_remaining_zone_presence(branch_id, false)

func request_debug_snapshot() -> Dictionary:
	return {
		"configuration_mode": ConfigurationMode.keys()[configuration_mode],
		"state": MacroState.keys()[_state],
		"first_branch_candidate": _first_branch_candidate,
		"remaining_branch": _remaining_branch,
		"collected_shard_ids": _collected_shard_ids.duplicate(),
		"active_first_shard_slot": _active_first_shard_slot.name if _active_first_shard_slot != null else &"",
		"completed_branches": _completed_branches.duplicate(),
		"remaining_zone_occupancy": _remaining_zone_occupancy.duplicate(),
		"second_shard_slot": _active_second_shard_slot.name if _active_second_shard_slot != null else &"",
		"first_reward_in_progress": _first_reward_in_progress,
		"first_reward_complete": _first_reward_complete,
		"e1_request_issued": _e1_request_issued,
		"second_reward_in_progress": _second_reward_in_progress,
		"second_reward_complete": _second_reward_complete,
		"both_rewards_complete": _both_rewards_complete,
		"unresolved_future_dependencies": _deliberately_unresolved_dependencies.duplicate(),
		"deliberately_unresolved_dependencies": _deliberately_unresolved_dependencies.duplicate(),
		"present_dependency_validation": _present_dependency_validation.duplicate(true),
	}

func _wire_slice_6_dependencies() -> void:
	var slot_08 := get_node_or_null(shard_slot_08_path)
	var slot_09 := get_node_or_null(shard_slot_09_path)
	for slot in [slot_08, slot_09]:
		if slot == null:
			continue
		if slot.has_signal(&"shard_available") and not slot.is_connected(&"shard_available", _on_shard_slot_available):
			slot.connect(&"shard_available", _on_shard_slot_available)
		if slot.has_signal(&"shard_collection_started") and not slot.is_connected(&"shard_collection_started", _on_shard_slot_collection_started):
			slot.connect(&"shard_collection_started", _on_shard_slot_collection_started)
		if slot.has_signal(&"shard_collected") and not slot.is_connected(&"shard_collected", _on_shard_slot_collected):
			slot.connect(&"shard_collected", _on_shard_slot_collected)
		_register_slot_soul_shard_with_reward_controller(slot)
	_wire_remaining_zone(canopy_remaining_zone_path, BRANCH_CANOPY)
	_wire_remaining_zone(ripple_remaining_zone_path, BRANCH_RIPPLE)


func _wire_remaining_zone(path: NodePath, branch_id: StringName) -> void:
	var zone := get_node_or_null(path)
	if zone == null:
		return
	if zone.has_signal(&"body_entered") and not zone.is_connected(&"body_entered", _on_remaining_zone_body_entered):
		zone.connect(&"body_entered", _on_remaining_zone_body_entered.bind(branch_id))
	if zone.has_signal(&"body_exited") and not zone.is_connected(&"body_exited", _on_remaining_zone_body_exited):
		zone.connect(&"body_exited", _on_remaining_zone_body_exited.bind(branch_id))


func _register_slot_soul_shard_with_reward_controller(slot: Node) -> void:
	var reward_controller := get_node_or_null(shard_reward_controller_path)
	if reward_controller == null or not reward_controller.has_method(&"register_shard"):
		return
	var shard: Node = null
	if slot.has_method(&"debug_get_soul_shard"):
		shard = slot.call(&"debug_get_soul_shard")
	elif "soul_shard_path" in slot:
		shard = slot.get_node_or_null(slot.soul_shard_path)
	if shard != null:
		reward_controller.call(&"register_shard", shard)


func _reveal_first_candidate_shard(branch_id: StringName) -> void:
	var slot := get_node_or_null(shard_slot_08_path) if branch_id == BRANCH_CANOPY else get_node_or_null(shard_slot_09_path)
	if slot == null or not slot.has_method(&"reveal_at"):
		_emit_configuration_error(&"Level04ProgressController", "candidate shard slot missing for %s" % [String(branch_id)])
		return
	_active_first_shard_slot = slot
	slot.call(&"reveal_at", 0)


func _on_shard_slot_available(shard_id: StringName, anchor_context) -> void:
	if _active_first_shard_slot != null and shard_id == _expected_first_shard_id() and anchor_context == 0:
		if _state == MacroState.FIRST_CANDIDATE_CANOPY or _state == MacroState.FIRST_CANDIDATE_RIPPLE:
			_state = MacroState.FIRST_SHARD_AVAILABLE
		return
	if _active_second_shard_slot != null and shard_id == _expected_second_shard_id() and anchor_context == 1:
		if _state == MacroState.REMAINING_DEFERRED:
			_state = MacroState.SECOND_SHARD_AVAILABLE


func _on_shard_slot_collection_started(shard_id: StringName) -> void:
	if shard_id == _expected_first_shard_id() and not _first_reward_complete:
		_first_reward_in_progress = true
	elif shard_id == _expected_second_shard_id() and _state == MacroState.SECOND_SHARD_AVAILABLE and not _second_reward_complete:
		_second_reward_in_progress = true
	else:
		return
	var recovery := get_node_or_null(recovery_controller_path)
	if recovery != null and recovery.has_method(&"add_suspension_source"):
		recovery.call(&"add_suspension_source", SUSPENSION_SHARD_REWARD)


func _on_shard_slot_collected(shard_id: StringName) -> void:
	if shard_id == _expected_first_shard_id() and not _first_reward_complete:
		_commit_first_reward(shard_id)
		return
	if shard_id == _expected_second_shard_id() and not _second_reward_complete:
		_commit_second_reward(shard_id)


func _commit_first_reward(shard_id: StringName) -> void:
	if not _collected_shard_ids.has(shard_id):
		_collected_shard_ids.append(shard_id)
	_first_reward_in_progress = false
	_first_reward_complete = true
	_state = MacroState.FIRST_REWARD_COMPLETE
	_remove_recovery_suspension()
	_request_e1_transition()
	_state = MacroState.REMAINING_DEFERRED
	_evaluate_second_shard_eligibility()


func _commit_second_reward(shard_id: StringName) -> void:
	if _state != MacroState.SECOND_SHARD_AVAILABLE:
		return
	if not _collected_shard_ids.has(shard_id):
		_collected_shard_ids.append(shard_id)
	_second_reward_in_progress = false
	_second_reward_complete = true
	_both_rewards_complete = true
	_remove_recovery_suspension()
	_state = MacroState.BOTH_REWARDS_COMPLETE


func _remove_recovery_suspension() -> void:
	var recovery := get_node_or_null(recovery_controller_path)
	if recovery != null and recovery.has_method(&"remove_suspension_source"):
		recovery.call(&"remove_suspension_source", SUSPENSION_SHARD_REWARD)


func _request_e1_transition() -> void:
	if _e1_request_issued:
		return
	_e1_request_issued = true
	var environment := get_node_or_null(environment_controller_path)
	if environment != null and environment.has_method(&"request_phase"):
		environment.call(&"request_phase", 1)


func _expected_first_shard_id() -> StringName:
	if _first_branch_candidate == BRANCH_CANOPY:
		return SHARD_08
	if _first_branch_candidate == BRANCH_RIPPLE:
		return SHARD_09
	return &""

func _expected_second_shard_id() -> StringName:
	if _remaining_branch == BRANCH_CANOPY:
		return SHARD_08
	if _remaining_branch == BRANCH_RIPPLE:
		return SHARD_09
	return &""

func _evaluate_second_shard_eligibility() -> void:
	if _state != MacroState.REMAINING_DEFERRED:
		return
	if _remaining_branch != BRANCH_CANOPY and _remaining_branch != BRANCH_RIPPLE:
		return
	if not _is_branch_puzzle_complete(_remaining_branch):
		return
	if not bool(_remaining_zone_occupancy[_remaining_branch]):
		return
	_reveal_second_remaining_shard(_remaining_branch)

func _reveal_second_remaining_shard(branch_id: StringName) -> void:
	if _active_second_shard_slot != null or _second_reward_complete or _both_rewards_complete:
		return
	var slot := get_node_or_null(shard_slot_08_path) if branch_id == BRANCH_CANOPY else get_node_or_null(shard_slot_09_path)
	if slot == null or not slot.has_method(&"reveal_at"):
		_emit_configuration_error(&"Level04ProgressController", "remaining shard slot missing for %s" % [String(branch_id)])
		return
	_active_second_shard_slot = slot
	var revealed := bool(slot.call(&"reveal_at", 1))
	if not revealed:
		_active_second_shard_slot = null

func _is_branch_puzzle_complete(branch_id: StringName) -> bool:
	if _completed_branches.has(branch_id):
		return true
	var controller := get_node_or_null(canopy_controller_path) if branch_id == BRANCH_CANOPY else get_node_or_null(ripple_controller_path)
	if controller != null and controller.has_method(&"is_complete"):
		return bool(controller.call(&"is_complete"))
	return false

func _is_configured_player(body: Node) -> bool:
	var player := get_node_or_null(player_path)
	return player != null and body == player

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

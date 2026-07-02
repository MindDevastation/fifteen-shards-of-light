extends Node
class_name Level02RuntimeContractValidator

signal validation_failed(reason: String)
signal validation_passed

@export var player_path: NodePath
@export var progress_path: NodePath
@export var arrival_path: NodePath
@export var soft_return_path: NodePath
@export var trial_a_path: NodePath
@export var trial_b_path: NodePath
@export var reward_gate_path: NodePath
@export var environment_state_path: NodePath
@export var central_presence_path: NodePath
@export var portal_adapter_path: NodePath
@export var shared_reward_controller_path: NodePath

const SHARD_03_ID := &"Shard_03"
const SHARD_04_ID := &"Shard_04"
const SHARD_03_TEXT := "В тебе есть свет, который не нужно делать громче"
const SHARD_04_TEXT := "Рядом с мыслью о тебе во мне больше жизни"

var _prepared := false
var _committed := false
var _failed := false
var _plans: Dictionary = {}
var _connection_plan: Array[Dictionary] = []
var _domain_commit_plan: Array[Callable] = []
var _shared_registration_plan: Array[Node] = []

func _ready() -> void:
	prepare()
	if _prepared:
		commit_startup()

func prepare() -> bool:
	if _committed:
		return true
	_prepared = false
	_failed = false
	_plans.clear()
	_connection_plan.clear()
	_domain_commit_plan.clear()
	_shared_registration_plan.clear()
	if not _resolve_required_nodes():
		return false
	if not _validate_required_methods_and_signals():
		return false
	if not _prepare_slots_and_plans():
		return false
	_prepared = true
	return true

func commit_startup() -> bool:
	if _committed:
		return true
	if not _prepared and not prepare():
		return false
	if not _final_eligibility_barrier():
		return _fail_once("startup eligibility barrier failed")

	# 1. inert reassertion
	for node: Node in [_plans["trial_a"], _plans["trial_b"], _plans["arrival"], _plans["central"], _plans["soft_return"], _plans["progress"], _plans["environment"]]:
		Callable(node, "disarm").call()
	# 2. exact local signal connections
	for entry: Dictionary in _connection_plan:
		var source: Object = entry["source"]
		var signal_name: StringName = entry["signal_name"]
		var target_callable: Callable = entry["callable"]
		source.connect(signal_name, target_callable)
	# 3. direct shared registration of both actual shard instances
	for shard: Node in _shared_registration_plan:
		_plans["shared_reward"].register_shard(shard)
	# 4. mandatory domain commits
	for domain_callable: Callable in _domain_commit_plan:
		domain_callable.call()
	# 5. Progress arm
	Callable(_plans["progress"], "arm").call()
	# 6. Player controls/process enable
	Callable(_plans["player"], "set_controls_enabled").call(true)
	# 7. Arrival arm
	Callable(_plans["arrival"], "arm").call()
	# 8. validation_passed
	_committed = true
	validation_passed.emit()
	return true

func _resolve_required_nodes() -> bool:
	var required := {
		"player": player_path,
		"progress": progress_path,
		"arrival": arrival_path,
		"soft_return": soft_return_path,
		"trial_a": trial_a_path,
		"trial_b": trial_b_path,
		"reward_gate": reward_gate_path,
		"environment": environment_state_path,
		"central": central_presence_path,
		"portal_adapter": portal_adapter_path,
		"shared_reward": shared_reward_controller_path,
	}
	for key: String in required.keys():
		var path: NodePath = required[key]
		if path.is_empty():
			return _fail_once("empty dependency path: %s" % key)
		var node := get_node_or_null(path)
		if node == null:
			return _fail_once("missing dependency: %s" % key)
		_plans[key] = node
	return true

func _validate_required_methods_and_signals() -> bool:
	var method_requirements: Array[Array] = [
		[_plans["shared_reward"], &"register_shard"],
		[_plans["player"], &"set_controls_enabled"],
		[_plans["progress"], &"arm"], [_plans["progress"], &"disarm"],
		[_plans["progress"], &"set_trial_complete"], [_plans["progress"], &"admitted_shard_collected"],
		[_plans["progress"], &"notify_fog_ready"], [_plans["progress"], &"set_center_present"],
		[_plans["arrival"], &"arm"], [_plans["arrival"], &"disarm"], [_plans["arrival"], &"commit_domain"],
		[_plans["soft_return"], &"disarm"], [_plans["soft_return"], &"commit_domain"],
		[_plans["trial_a"], &"disarm"], [_plans["trial_a"], &"commit_domain"],
		[_plans["trial_b"], &"disarm"], [_plans["trial_b"], &"commit_domain"], [_plans["trial_b"], &"validate_pad_registry"],
		[_plans["environment"], &"disarm"], [_plans["environment"], &"commit_domain"], [_plans["environment"], &"on_admitted_shard"],
		[_plans["central"], &"arm"], [_plans["central"], &"disarm"], [_plans["central"], &"commit_domain"],
		[_plans["portal_adapter"], &"commit_domain"], [_plans["portal_adapter"], &"show_finale_and_activate"],
	]
	for requirement: Array in method_requirements:
		if not _validate_method(requirement[0], requirement[1]):
			return false
	var signal_requirements: Array[Array] = [
		[_plans["trial_a"], &"trial_completed"],
		[_plans["trial_b"], &"trial_completed"],
		[_plans["reward_gate"], &"admitted_shard_collected"],
		[_plans["environment"], &"fog_ready"],
		[_plans["central"], &"center_presence_changed"],
		[_plans["progress"], &"finale_requested"],
	]
	for requirement: Array in signal_requirements:
		if not _validate_signal(requirement[0], requirement[1]):
			return false
	if not _plans["trial_b"].validate_pad_registry():
		return _fail_once("invalid Trial B pad registry")
	return true

func _prepare_slots_and_plans() -> bool:
	var slot_a: Node = _plans["trial_a"].get_node_or_null("ShardSlot_A")
	if slot_a == null:
		slot_a = _plans["trial_a"].get_node_or_null("Shard03Slot")
	var slot_b: Node = _plans["trial_b"].get_node_or_null("ShardSlot_B")
	if slot_b == null:
		slot_b = _plans["trial_b"].get_node_or_null("Shard04Slot")
	if not _prepare_slot(slot_a, SHARD_03_ID, SHARD_03_TEXT):
		return false
	if not _prepare_slot(slot_b, SHARD_04_ID, SHARD_04_TEXT):
		return false
	if not _add_connection(_plans["trial_a"], &"trial_completed", Callable(_plans["progress"], "set_trial_complete")):
		return false
	if not _add_connection(_plans["trial_b"], &"trial_completed", Callable(_plans["progress"], "set_trial_complete")):
		return false
	if not _add_connection(_plans["reward_gate"], &"admitted_shard_collected", Callable(_plans["progress"], "admitted_shard_collected")):
		return false
	if not _add_connection(_plans["reward_gate"], &"admitted_shard_collected", Callable(_plans["environment"], "on_admitted_shard")):
		return false
	if not _add_connection(_plans["environment"], &"fog_ready", Callable(_plans["progress"], "notify_fog_ready")):
		return false
	if not _add_connection(_plans["central"], &"center_presence_changed", Callable(_plans["progress"], "set_center_present")):
		return false
	if not _add_connection(_plans["progress"], &"finale_requested", Callable(_plans["portal_adapter"], "show_finale_and_activate")):
		return false
	for node: Node in [_plans["arrival"], _plans["trial_a"], _plans["trial_b"], _plans["environment"], _plans["central"], _plans["soft_return"], _plans["portal_adapter"]]:
		var domain_callable := Callable(node, "commit_domain")
		if not domain_callable.is_valid():
			return _fail_once("invalid domain commit callable")
		_domain_commit_plan.append(domain_callable)
	return true

func _prepare_slot(slot: Node, expected_id: StringName, expected_text: String) -> bool:
	if slot == null:
		return _fail_once("missing slot %s" % expected_id)
	if not _validate_method(slot, &"get_shard"):
		return false
	if not _validate_signal(slot, &"raw_shard_collected"):
		return false
	if not _validate_signal(slot, &"shard_available"):
		return false
	var shard: Node = slot.get_shard() as Node
	if shard == null:
		return _fail_once("missing shard %s" % expected_id)
	if shard.get("shard_id") != expected_id:
		return _fail_once("wrong shard id %s" % expected_id)
	if shard.get("reward_text") != expected_text:
		return _fail_once("wrong shard text %s" % expected_id)
	if not _validate_signal(shard, &"reward_sequence_requested"):
		return false
	if not _validate_signal(shard, &"collected"):
		return false
	if not _add_connection(slot, &"raw_shard_collected", Callable(_plans["reward_gate"], "observe_raw_collection")):
		return false
	if not _add_connection(slot, &"shard_available", Callable(_plans["reward_gate"], "observe_availability")):
		return false
	if not _add_connection(shard, &"reward_sequence_requested", Callable(_plans["reward_gate"], "observe_request")):
		return false
	_shared_registration_plan.append(shard)
	return true

func _add_connection(source: Object, signal_name: StringName, target_callable: Callable) -> bool:
	if not _validate_signal(source, signal_name):
		return false
	if not target_callable.is_valid():
		return _fail_once("invalid callable %s" % signal_name)
	if source.is_connected(signal_name, target_callable):
		return _fail_once("pre-existing connection %s" % signal_name)
	_connection_plan.append({"source": source, "signal_name": signal_name, "callable": target_callable})
	return true

func _validate_method(node: Object, method_name: StringName) -> bool:
	if node == null or not node.has_method(method_name):
		return _fail_once("missing method %s" % method_name)
	return true

func _validate_signal(node: Object, signal_name: StringName) -> bool:
	if node == null or not node.has_signal(signal_name):
		return _fail_once("missing signal %s" % signal_name)
	return true

func _final_eligibility_barrier() -> bool:
	if _connection_plan.size() != 13:
		return false
	if _shared_registration_plan.size() != 2:
		return false
	if _domain_commit_plan.size() != 7:
		return false
	for entry: Dictionary in _connection_plan:
		var source: Object = entry["source"]
		var signal_name: StringName = entry["signal_name"]
		var target_callable: Callable = entry["callable"]
		if source == null or not source.has_signal(signal_name) or not target_callable.is_valid() or source.is_connected(signal_name, target_callable):
			return false
	for shard: Node in _shared_registration_plan:
		if shard == null:
			return false
	for domain_callable: Callable in _domain_commit_plan:
		if not domain_callable.is_valid():
			return false
	return true

func _fail_once(reason: String) -> bool:
	if not _failed:
		_failed = true
		validation_failed.emit(reason)
	return false

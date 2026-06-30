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

var _prepared := false
var _committed := false
var _failed := false
var _plans: Dictionary = {}

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
	}
	for key in required.keys():
		var path: NodePath = required[key]
		if path.is_empty() or get_node_or_null(path) == null:
			return _fail_once("missing dependency: %s" % key)
		_plans[key] = get_node(path)
	if not shared_reward_controller_path.is_empty():
		_plans["shared_reward"] = get_node_or_null(shared_reward_controller_path)
	_prepared = true
	return true

func commit_startup() -> bool:
	if _committed:
		return true
	if not _prepared and not prepare():
		return false
	# 1. inert reassertion
	for node in [_plans.trial_a, _plans.trial_b, _plans.arrival, _plans.central, _plans.soft_return, _plans.progress]:
		if node.has_method("disarm"):
			node.disarm()
	# 2. exact local signal connections
	_connect_once(_plans.trial_a, "trial_completed", Callable(_plans.progress, "set_trial_complete").bind(&"trial_a"))
	_connect_once(_plans.trial_b, "trial_completed", Callable(_plans.progress, "set_trial_complete").bind(&"trial_b"))
	_connect_once(_plans.reward_gate, "admitted_shard_collected", Callable(_plans.progress, "admitted_shard_collected"))
	_connect_once(_plans.reward_gate, "admitted_shard_collected", Callable(_plans.environment, "on_admitted_shard"))
	_connect_once(_plans.environment, "fog_ready", Callable(_plans.progress, "notify_fog_ready"))
	_connect_once(_plans.central, "center_presence_changed", Callable(_plans.progress, "set_center_present"))
	_connect_once(_plans.progress, "finale_requested", Callable(_plans.portal_adapter, "show_finale_and_activate"))
	_register_slots(_plans.trial_a)
	_register_slots(_plans.trial_b)
	# 3. shared registration
	if _plans.has("shared_reward") and _plans.shared_reward != null:
		for shard in get_tree().get_nodes_in_group("level_02_shards"):
			if _plans.shared_reward.has_method("register_shard"):
				_plans.shared_reward.register_shard(shard)
	# 4. domain commits
	for node in [_plans.trial_a, _plans.trial_b, _plans.environment, _plans.central, _plans.soft_return, _plans.portal_adapter]:
		if node.has_method("commit_domain"):
			node.commit_domain()
	# 5. Progress arm
	if _plans.progress.has_method("arm"):
		_plans.progress.arm()
	# 6. Player enable
	if _plans.player.has_method("set_controls_enabled"):
		_plans.player.set_controls_enabled(true)
	elif "controls_enabled" in _plans.player:
		_plans.player.controls_enabled = true
	# 7. Arrival arm
	if _plans.arrival.has_method("arm"):
		_plans.arrival.arm()
	# 8. validation_passed
	_committed = true
	validation_passed.emit()
	return true

func _register_slots(root: Node) -> void:
	for child in root.find_children("*", "Level02ShardSlot", true, false):
		_connect_once(child, "raw_shard_collected", Callable(_plans.reward_gate, "observe_raw_collection"))
		_connect_once(child, "shard_available", Callable(_plans.reward_gate, "observe_availability"))
		var shard := child.get_shard()
		if shard != null:
			shard.add_to_group("level_02_shards")
			if shard.has_signal("reward_sequence_requested"):
				_connect_once(shard, "reward_sequence_requested", Callable(_plans.reward_gate, "observe_request"))

func _connect_once(source: Object, signal_name: StringName, callable: Callable) -> void:
	if source != null and source.has_signal(signal_name) and not source.is_connected(signal_name, callable):
		source.connect(signal_name, callable)

func _fail_once(reason: String) -> bool:
	if not _failed:
		_failed = true
		validation_failed.emit(reason)
	return false

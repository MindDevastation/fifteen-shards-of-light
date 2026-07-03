class_name Level03ProgressController
extends Node

signal all_rewards_completed
signal macro_state_changed(state: StringName)

@export var environment_state_path: NodePath = NodePath("../../EnvironmentStateRoot")
@export var recovery_controller_path: NodePath = NodePath("../Level03RecoveryController")
@export var reward_controller_path: NodePath = NodePath("../ShardRewardSequenceController")
@export var slot_05_path: NodePath = NodePath("../../GameplayRoot/ShardSlots/Slot_05")
@export var slot_06_path: NodePath = NodePath("../../GameplayRoot/ShardSlots/Slot_06")
@export var slot_07_path: NodePath = NodePath("../../GameplayRoot/ShardSlots/Slot_07")
@export var wind_trace_path: NodePath = NodePath("../../GameplayRoot/Puzzles/WindTrace")
@export var playful_spark_path: NodePath = NodePath("../../GameplayRoot/Puzzles/PlayfulSpark")
@export var breathing_meadow_path: NodePath = NodePath("../../GameplayRoot/Puzzles/BreathingMeadow")
@export var debug_enabled: bool = false

const SHARD_ORDER := [&"Shard_05", &"Shard_06", &"Shard_07"]
var macro_state: StringName = &"BOOT"
var completed_shards: Array[StringName] = []
var _all_rewards_emitted := false
var _initialized := false

func _ready() -> void:
	initialize_level()

func initialize_level() -> bool:
	if _initialized:
		return true
	_initialized = true
	_set_state(&"WIND_TRACE_ACTIVE")
	_call_env(&"E0")
	var reward_controller := get_node_or_null(reward_controller_path)
	for path in [slot_05_path, slot_06_path, slot_07_path]:
		var slot := get_node_or_null(path)
		if slot == null:
			return false
		slot.prepare_hidden()
		if not slot.shard_collection_started.is_connected(_on_shard_collection_started):
			slot.shard_collection_started.connect(_on_shard_collection_started)
		if not slot.shard_collected.is_connected(_on_shard_collected):
			slot.shard_collected.connect(_on_shard_collected)
		if reward_controller != null and reward_controller.has_method("register_shard"):
			var shard := slot.get_soul_shard()
			if shard != null:
				reward_controller.register_shard(shard)
	var meadow := get_node_or_null(breathing_meadow_path)
	if meadow != null and meadow.has_signal("petal_completed") and not meadow.petal_completed.is_connected(_on_meadow_petal_completed):
		meadow.petal_completed.connect(_on_meadow_petal_completed)
	_call_optional(wind_trace_path, &"arm")
	return true

func notify_wind_trace_solved() -> void:
	accept_puzzle_completed(&"wind_trace")

func notify_playful_spark_solved() -> void:
	accept_puzzle_completed(&"playful_spark")

func notify_breathing_meadow_solved() -> void:
	accept_puzzle_completed(&"breathing_meadow")

func accept_puzzle_completed(puzzle_id: StringName) -> bool:
	match [macro_state, puzzle_id]:
		[&"WIND_TRACE_ACTIVE", &"wind_trace"]:
			_reveal_slot(slot_05_path, &"SHARD_05_AVAILABLE")
			return true
		[&"PLAYFUL_SPARK_ACTIVE", &"playful_spark"]:
			_reveal_slot(slot_06_path, &"SHARD_06_AVAILABLE")
			return true
		[&"BREATHING_MEADOW_ACTIVE", &"breathing_meadow"]:
			_reveal_slot(slot_07_path, &"SHARD_07_AVAILABLE")
			return true
	return false

func _on_meadow_petal_completed(_petal_id: StringName) -> void:
	var env := get_node_or_null(environment_state_path)
	var meadow := get_node_or_null(breathing_meadow_path)
	if env != null and env.has_method("request_meadow_partial") and meadow != null and "visited" in meadow:
		env.request_meadow_partial(meadow.visited.size())

func _on_shard_collection_started(_shard_id: StringName) -> void:
	var recovery := get_node_or_null(recovery_controller_path)
	if recovery != null and recovery.has_method("suspend_recovery"):
		recovery.suspend_recovery(&"shard_reward", true)

func _on_shard_collected(shard_id: StringName) -> void:
	if completed_shards.has(shard_id):
		return
	var recovery := get_node_or_null(recovery_controller_path)
	if recovery != null and recovery.has_method("suspend_recovery"):
		recovery.suspend_recovery(&"shard_reward", false)
	completed_shards.append(shard_id)
	match shard_id:
		&"Shard_05":
			_call_env(&"E1")
			_set_state(&"PLAYFUL_SPARK_ACTIVE")
			_call_optional(playful_spark_path, &"arm")
		&"Shard_06":
			_call_env(&"E2")
			_set_state(&"BREATHING_MEADOW_ACTIVE")
			_call_optional(breathing_meadow_path, &"arm")
		&"Shard_07":
			_call_env(&"E5")
			_set_state(&"WAITING_FOR_FINAL_OVERLOOK")
			if not _all_rewards_emitted:
				_all_rewards_emitted = true
				all_rewards_completed.emit()

func _reveal_slot(path: NodePath, next_state: StringName) -> void:
	var slot := get_node_or_null(path)
	if slot != null:
		slot.reveal()
	_set_state(next_state)

func _call_env(phase: StringName) -> void:
	var env := get_node_or_null(environment_state_path)
	if env != null and env.has_method("request_phase"):
		env.request_phase(phase)

func _call_optional(path: NodePath, method: StringName) -> void:
	var node := get_node_or_null(path)
	if node != null and node.has_method(method):
		node.call(method)

func _set_state(state: StringName) -> void:
	macro_state = state
	macro_state_changed.emit(state)

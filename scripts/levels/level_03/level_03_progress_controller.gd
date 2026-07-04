class_name Level03ProgressController
extends Node

signal all_rewards_completed
signal macro_state_changed(state: StringName)
signal startup_completed

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

const SHARD_ORDER: Array[StringName] = [&"Shard_05", &"Shard_06", &"Shard_07"]
const SHARD_TEXTS := {
	&"Shard_05": "После наших разговоров я ещё долго вспоминаю твою интонацию.",
	&"Shard_06": "Мне особенно нравится, как ты вдруг смеёшься над какой-нибудь полной ерундой.",
	&"Shard_07": "Рядом с тобой я и сам чаще смеюсь и ненадолго перестаю быть таким серьёзным.",
}
var macro_state: StringName = &"BOOT"
var completed_shards: Array[StringName] = []
var _all_rewards_emitted := false
var _initialized := false

func _ready() -> void:
	initialize_level()

func initialize_level() -> bool:
	if _initialized:
		return true
	var prepared := _prepare_startup()
	if prepared.is_empty():
		return false
	# Commit phase: no validation decisions after this point.
	for slot in prepared.slots:
		slot.prepare_hidden()
	for plan in prepared.connections:
		var sig: Signal = plan[0]
		var callable: Callable = plan[1]
		if not sig.is_connected(callable):
			sig.connect(callable)
	for shard in prepared.shards:
		prepared.reward_controller.register_shard(shard)
	prepared.environment.request_phase(&"E0")
	_set_state(&"WIND_TRACE_ACTIVE")
	prepared.wind_trace.arm()
	_initialized = true
	startup_completed.emit()
	return true

func _prepare_startup() -> Dictionary:
	var env := get_node_or_null(environment_state_path)
	var recovery := get_node_or_null(recovery_controller_path)
	var reward_controller := get_node_or_null(reward_controller_path)
	var wind := get_node_or_null(wind_trace_path)
	var spark := get_node_or_null(playful_spark_path)
	var meadow := get_node_or_null(breathing_meadow_path)
	if env == null or not env.has_method("request_phase") or not env.has_method("request_meadow_partial"):
		return {}
	if recovery == null or not recovery.has_method("suspend_recovery"):
		return {}
	if reward_controller == null or not reward_controller.has_method("register_shard"):
		return {}
	for puzzle in [wind, spark, meadow]:
		if puzzle == null or not puzzle.has_method("arm") or not puzzle.has_signal("puzzle_completed"):
			return {}
	var slot_paths := [slot_05_path, slot_06_path, slot_07_path]
	var slots: Array[Node] = []
	var shards: Array[Node] = []
	for i in range(slot_paths.size()):
		var slot := get_node_or_null(slot_paths[i])
		if slot == null or not slot.has_method("prepare_hidden") or not slot.has_method("reveal") or not slot.has_method("get_soul_shard"):
			return {}
		if not slot.has_signal("shard_collection_started") or not slot.has_signal("shard_collected") or not slot.has_signal("shard_available"):
			return {}
		var shard: Node = slot.get_soul_shard()
		if shard == null or not shard.has_signal("reward_sequence_requested") or not shard.has_signal("collected"):
			return {}
		var expected_id: StringName = SHARD_ORDER[i]
		if not ("shard_id" in shard) or shard.shard_id != expected_id:
			return {}
		if not ("reward_text" in shard) or shard.reward_text != SHARD_TEXTS[expected_id]:
			return {}
		slots.append(slot)
		shards.append(shard)
	var connections: Array[Array] = [
		[slots[0].shard_collection_started, Callable(self, "_on_shard_collection_started")],
		[slots[1].shard_collection_started, Callable(self, "_on_shard_collection_started")],
		[slots[2].shard_collection_started, Callable(self, "_on_shard_collection_started")],
		[slots[0].shard_collected, Callable(self, "_on_shard_collected")],
		[slots[1].shard_collected, Callable(self, "_on_shard_collected")],
		[slots[2].shard_collected, Callable(self, "_on_shard_collected")],
		[wind.puzzle_completed, Callable(self, "accept_puzzle_completed")],
		[spark.puzzle_completed, Callable(self, "accept_puzzle_completed")],
		[meadow.puzzle_completed, Callable(self, "accept_puzzle_completed")],
	]
	if meadow.has_signal("petal_completed"):
		connections.append([meadow.petal_completed, Callable(self, "_on_meadow_petal_completed")])
	return {"environment": env, "recovery": recovery, "reward_controller": reward_controller, "wind_trace": wind, "playful_spark": spark, "breathing_meadow": meadow, "slots": slots, "shards": shards, "connections": connections}

func accept_puzzle_completed(puzzle_id: StringName) -> bool:
	match [macro_state, puzzle_id]:
		[&"WIND_TRACE_ACTIVE", &"wind_trace"]:
			return _reveal_slot(slot_05_path, &"SHARD_05_AVAILABLE")
		[&"PLAYFUL_SPARK_ACTIVE", &"playful_spark"]:
			return _reveal_slot(slot_06_path, &"SHARD_06_AVAILABLE")
		[&"BREATHING_MEADOW_ACTIVE", &"breathing_meadow"]:
			return _reveal_slot(slot_07_path, &"SHARD_07_AVAILABLE")
	return false

func _on_meadow_petal_completed(_petal_id: StringName) -> void:
	var env := get_node_or_null(environment_state_path)
	var meadow := get_node_or_null(breathing_meadow_path)
	if env != null and env.has_method("request_meadow_partial") and meadow != null and "visited" in meadow:
		env.request_meadow_partial(meadow.visited.size())

func _on_shard_collection_started(shard_id: StringName) -> void:
	if not _is_expected_available_shard(shard_id):
		return
	var recovery := get_node_or_null(recovery_controller_path)
	recovery.suspend_recovery(&"shard_reward", true)

func _on_shard_collected(shard_id: StringName) -> void:
	if completed_shards.has(shard_id) or not _is_expected_available_shard(shard_id):
		return
	var recovery := get_node_or_null(recovery_controller_path)
	recovery.suspend_recovery(&"shard_reward", false)
	completed_shards.append(shard_id)
	match shard_id:
		&"Shard_05":
			if _require_env(&"E1"):
				_set_state(&"PLAYFUL_SPARK_ACTIVE")
				_call_optional(playful_spark_path, &"arm")
		&"Shard_06":
			if _require_env(&"E2"):
				_set_state(&"BREATHING_MEADOW_ACTIVE")
				_call_optional(breathing_meadow_path, &"arm")
		&"Shard_07":
			if _require_env(&"E5"):
				_set_state(&"WAITING_FOR_FINAL_OVERLOOK")
				if not _all_rewards_emitted:
					_all_rewards_emitted = true
					all_rewards_completed.emit()

func _is_expected_available_shard(shard_id: StringName) -> bool:
	match macro_state:
		&"SHARD_05_AVAILABLE": return shard_id == &"Shard_05" and completed_shards.is_empty()
		&"SHARD_06_AVAILABLE": return shard_id == &"Shard_06" and completed_shards == [&"Shard_05"]
		&"SHARD_07_AVAILABLE": return shard_id == &"Shard_07" and completed_shards == [&"Shard_05", &"Shard_06"]
	return false

func _reveal_slot(path: NodePath, next_state: StringName) -> bool:
	var slot := get_node_or_null(path)
	if slot == null or not slot.reveal():
		return false
	_set_state(next_state)
	return true

func _require_env(phase: StringName) -> bool:
	var env := get_node_or_null(environment_state_path)
	return env != null and env.has_method("request_phase") and env.request_phase(phase)

func _call_optional(path: NodePath, method: StringName) -> void:
	var node := get_node_or_null(path)
	if node != null and node.has_method(method):
		node.call(method)

func _set_state(state: StringName) -> void:
	macro_state = state
	macro_state_changed.emit(state)

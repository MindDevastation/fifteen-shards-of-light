class_name Level03ProgressController
extends Node

signal all_rewards_completed
signal macro_state_changed(state: StringName)

@export var environment_state_path: NodePath = NodePath("../../EnvironmentStateRoot")
@export var recovery_controller_path: NodePath = NodePath("../Level03RecoveryController")
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

func _ready() -> void:
	initialize_level()

func initialize_level() -> bool:
	_set_state(&"WIND_TRACE_ACTIVE")
	_call_env(&"E0")
	for path in [slot_05_path, slot_06_path, slot_07_path]:
		var slot := get_node_or_null(path)
		if slot != null:
			slot.prepare_hidden()
			if not slot.shard_collected.is_connected(_on_shard_collected):
				slot.shard_collected.connect(_on_shard_collected)
	return true

func notify_wind_trace_solved() -> void:
	_reveal_slot(slot_05_path, &"SHARD_05_AVAILABLE")

func notify_playful_spark_solved() -> void:
	_reveal_slot(slot_06_path, &"SHARD_06_AVAILABLE")

func notify_breathing_meadow_solved() -> void:
	_reveal_slot(slot_07_path, &"SHARD_07_AVAILABLE")

func _on_shard_collected(shard_id: StringName) -> void:
	if completed_shards.has(shard_id):
		return
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

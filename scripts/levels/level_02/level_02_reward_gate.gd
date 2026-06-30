extends Node
class_name Level02RewardGate

signal admitted_shard_collected(shard_id: StringName)
signal reward_blocked(reason: String)

const EXPECTED_TEXT := {
	&"Shard_03": "В тебе есть свет, который не нужно делать громче",
	&"Shard_04": "Рядом с мыслью о тебе во мне больше жизни",
}
var available: Dictionary = {}
var requested: Dictionary = {}
var admitted: Dictionary = {}
var active_request: StringName = &""
var blocked := false

func observe_availability(shard_id: StringName) -> void:
	available[shard_id] = true

func observe_request(shard: Node, shard_id: StringName, reward_text: String, _world_position: Vector3) -> void:
	if blocked: return
	if not EXPECTED_TEXT.has(shard_id): return _block("unexpected request")
	if reward_text != EXPECTED_TEXT[shard_id]: return _block("text mismatch")
	if not available.has(shard_id): return _block("request before availability")
	if active_request != &"": return _block("concurrent request")
	if requested.has(shard_id): return _block("duplicate request")
	if shard == null: return _block("missing shard")
	requested[shard_id] = shard
	active_request = shard_id

func observe_raw_collection(shard: Node, shard_id: StringName) -> void:
	if blocked: return
	if active_request != shard_id: return _block("raw collection without admission")
	if not requested.has(shard_id) or requested[shard_id] != shard: return _block("mismatched release")
	if admitted.has(shard_id): return _block("duplicate collection")
	active_request = &""
	admitted[shard_id] = true
	admitted_shard_collected.emit(shard_id)

func _block(reason: String) -> void:
	blocked = true
	reward_blocked.emit(reason)

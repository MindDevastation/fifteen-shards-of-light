extends Node
class_name Level02RewardGate
signal admitted_shard_collected(shard_id: StringName)
signal reward_blocked(reason: String)
var expected: Dictionary = {&"Shard_03": true, &"Shard_04": true}
var requested: Dictionary = {}
var admitted: Dictionary = {}
var active_request := false
var blocked := false
func observe_request(_shard: Node, shard_id: StringName, _text: String, _pos: Vector3) -> void:
	if blocked: return
	if not expected.has(shard_id): return _block("unexpected request")
	if active_request: return _block("concurrent request")
	if requested.has(shard_id): return _block("duplicate request")
	requested[shard_id] = true
	active_request = true
func observe_raw_collection(_shard: Node, shard_id: StringName) -> void:
	if blocked: return
	if not requested.has(shard_id): return _block("raw collection without admission")
	if admitted.has(shard_id): return _block("duplicate collection")
	active_request = false
	admitted[shard_id] = true
	admitted_shard_collected.emit(shard_id)
func _block(reason: String) -> void:
	blocked = true
	reward_blocked.emit(reason)

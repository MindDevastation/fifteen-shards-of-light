class_name Level03ShardSlot
extends Node3D

signal shard_reveal_started(shard_id: StringName)
signal shard_available(shard_id: StringName)
signal shard_collection_started(shard_id: StringName)
signal shard_collected(shard_id: StringName)

@export var soul_shard_path: NodePath = NodePath("SoulShard")
@export var debug_enabled: bool = false

var shard_id: StringName = &""
var reward_text: String = ""
var revealed := false
var available := false
var collection_started := false
var collection_completed := false
var _soul_shard: Node = null

func _ready() -> void:
	_bind_child_shard()

func prepare_hidden() -> void:
	_bind_child_shard()
	revealed = false
	available = false
	collection_started = false
	collection_completed = false
	visible = false
	if _soul_shard != null:
		_soul_shard.visible = false
		_set_child_monitoring(false)

func reveal() -> bool:
	_bind_child_shard()
	if _soul_shard == null or collection_completed:
		return false
	if not revealed:
		revealed = true
		visible = true
		_soul_shard.visible = true
		_set_child_monitoring(true)
		shard_reveal_started.emit(shard_id)
	if not available:
		available = true
		shard_available.emit(shard_id)
	return true

func get_soul_shard() -> Node:
	_bind_child_shard()
	return _soul_shard

func _bind_child_shard() -> bool:
	if _soul_shard != null and is_instance_valid(_soul_shard):
		return true
	_soul_shard = get_node_or_null(soul_shard_path)
	if _soul_shard == null:
		return false
	if "shard_id" in _soul_shard:
		shard_id = _soul_shard.shard_id
	if "reward_text" in _soul_shard:
		reward_text = _soul_shard.reward_text
	if _soul_shard.has_signal("reward_sequence_requested") and not _soul_shard.reward_sequence_requested.is_connected(_on_reward_sequence_requested):
		_soul_shard.reward_sequence_requested.connect(_on_reward_sequence_requested)
	if _soul_shard.has_signal("collected") and not _soul_shard.collected.is_connected(_on_child_collected):
		_soul_shard.collected.connect(_on_child_collected)
	return true

func _on_reward_sequence_requested(_shard: Node, requested_id: StringName, _text: String, _world_position: Vector3) -> void:
	if collection_completed or collection_started:
		return
	if requested_id != shard_id:
		return
	collection_started = true
	shard_collection_started.emit(shard_id)

func _on_child_collected() -> void:
	if collection_completed:
		return
	collection_completed = true
	available = false
	visible = false
	shard_collected.emit(shard_id)

func _set_child_monitoring(enabled: bool) -> void:
	if _soul_shard == null:
		return
	var stack: Array[Node] = [_soul_shard]
	while not stack.is_empty():
		var node: Node = stack.pop_back()
		if node is Area3D:
			node.monitoring = enabled
			node.monitorable = enabled
		if node is CollisionShape3D:
			node.disabled = not enabled
		for child in node.get_children():
			stack.append(child)

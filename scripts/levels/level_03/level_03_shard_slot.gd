class_name Level03ShardSlot
extends Node3D

signal shard_reveal_started(shard_id: StringName)
signal shard_available(shard_id: StringName)
signal shard_collection_started(shard_id: StringName)
signal shard_collected(shard_id: StringName)

@export var soul_shard_path: NodePath = NodePath("SoulShard")
@export var reveal_fallback_seconds: float = 0.25
@export var debug_enabled: bool = false

var shard_id: StringName = &""
var reward_text: String = ""
var revealed := false
var available := false
var collection_started := false
var collection_completed := false
var reveal_generation := 0
var _soul_shard: Node = null

func _ready() -> void:
	_bind_child_shard()

func prepare_hidden() -> void:
	_bind_child_shard()
	revealed = false
	available = false
	collection_started = false
	collection_completed = false
	reveal_generation += 1
	visible = false
	if _soul_shard != null:
		_soul_shard.visible = false
		_set_child_collectability(false)

func reveal() -> bool:
	_bind_child_shard()
	if _soul_shard == null or collection_completed or revealed:
		return false
	if not _validate_serialized_hidden_state():
		return false
	revealed = true
	reveal_generation += 1
	var generation := reveal_generation
	visible = true
	_soul_shard.visible = true
	shard_reveal_started.emit(shard_id)
	_deferred_enable_after_physics(generation)
	return true

func get_soul_shard() -> Node:
	_bind_child_shard()
	return _soul_shard

func _deferred_enable_after_physics(generation: int) -> void:
	await get_tree().create_timer(reveal_fallback_seconds).timeout
	await get_tree().physics_frame
	if generation != reveal_generation or collection_completed or available:
		return
	_set_child_collectability(true)
	await get_tree().physics_frame
	if generation != reveal_generation or collection_completed or available:
		return
	if not _verify_effective_collectability():
		return
	available = true
	shard_available.emit(shard_id)

func _validate_serialized_hidden_state() -> bool:
	if _soul_shard == null:
		return false
	return not visible and not _soul_shard.visible and not _has_enabled_collision_or_monitoring()

func _verify_effective_collectability() -> bool:
	return _has_enabled_collision_or_monitoring()

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
	if collection_completed or collection_started or not available or requested_id != shard_id:
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

func _set_child_collectability(enabled: bool) -> void:
	if _soul_shard == null:
		return
	for node in _walk_child_nodes(_soul_shard):
		if node is Area3D:
			node.monitoring = enabled
			node.monitorable = enabled
		if node is CollisionShape3D:
			node.disabled = not enabled

func _has_enabled_collision_or_monitoring() -> bool:
	if _soul_shard == null:
		return false
	for node in _walk_child_nodes(_soul_shard):
		if node is Area3D and node.monitoring and node.monitorable:
			return true
		if node is CollisionShape3D and not node.disabled:
			return true
	return false

func _walk_child_nodes(root_node: Node) -> Array[Node]:
	var result: Array[Node] = []
	var stack: Array[Node] = [root_node]
	while not stack.is_empty():
		var node: Node = stack.pop_back()
		result.append(node)
		for child in node.get_children():
			stack.append(child)
	return result

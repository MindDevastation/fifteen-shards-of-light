extends Node3D
class_name Level02ShardSlot

signal raw_shard_collected(actual_shard_node: Node, shard_id: StringName)
signal shard_revealed(shard_id: StringName)
signal shard_available(shard_id: StringName)

@export var shard_id: StringName
@export var shard_path: NodePath
var revealed := false
var collected := false

func _ready() -> void:
	var shard := get_shard()
	if shard:
		shard.visible = false
		if "monitoring" in shard: shard.monitoring = false
		if "monitorable" in shard: shard.monitorable = false
		if shard.has_signal("collected") and not shard.collected.is_connected(_on_collected):
			shard.collected.connect(_on_collected)

func get_shard() -> Node:
	return get_node_or_null(shard_path)

func reveal() -> void:
	if revealed: return
	revealed = true
	var shard := get_shard()
	if shard:
		shard.visible = true
		if "monitoring" in shard: shard.monitoring = true
		if "monitorable" in shard: shard.monitorable = true
	shard_revealed.emit(shard_id)
	shard_available.emit(shard_id)

func _on_collected() -> void:
	if collected: return
	collected = true
	raw_shard_collected.emit(get_shard(), shard_id)

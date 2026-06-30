extends Node3D
class_name Level02ShardSlot
signal raw_shard_collected(actual_shard_node: Node, shard_id: StringName)
signal shard_revealed(shard_id: StringName)
@export var shard_id: StringName
@export var shard_path: NodePath
var revealed := false
func _ready() -> void:
	var shard := get_node_or_null(shard_path)
	if shard:
		shard.visible = false
		if shard.has_signal("collected"):
			shard.collected.connect(func(): raw_shard_collected.emit(shard, shard_id))
func reveal() -> void:
	revealed = true
	var shard := get_node_or_null(shard_path)
	if shard: shard.visible = true
	shard_revealed.emit(shard_id)

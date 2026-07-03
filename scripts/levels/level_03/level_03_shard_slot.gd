class_name Level03ShardSlot
extends Node3D

signal shard_reveal_started(shard_id: StringName)
signal shard_available(shard_id: StringName)
signal shard_collection_started(shard_id: StringName)
signal shard_collected(shard_id: StringName)
signal reward_sequence_requested(shard: Node, shard_id: StringName, reward_text: String, world_position: Vector3)
signal collected

@export var shard_id: StringName = &""
@export_multiline var reward_text: String = ""
@export var interaction_radius: float = 1.8
@export var debug_enabled: bool = false

var revealed := false
var available := false
var collection_started := false
var collection_completed := false

func prepare_hidden() -> void:
	revealed = false
	available = false
	collection_started = false
	collection_completed = false
	visible = false
	set_process(false)

func reveal() -> bool:
	if collection_completed:
		return false
	if not revealed:
		revealed = true
		visible = true
		shard_reveal_started.emit(shard_id)
	if not available:
		available = true
		shard_available.emit(shard_id)
	return true

func can_player_interact(_player: Node) -> bool:
	return available and not collection_started and not collection_completed

func interact(_player: Node) -> void:
	if not can_player_interact(_player):
		return
	collection_started = true
	shard_collection_started.emit(shard_id)
	reward_sequence_requested.emit(self, shard_id, reward_text, global_position)

func complete_collection_sequence() -> void:
	if collection_completed:
		return
	collection_completed = true
	available = false
	visible = false
	shard_collected.emit(shard_id)
	collected.emit()

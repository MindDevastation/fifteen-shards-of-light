extends Node3D
class_name Level04ShardSlot

signal shard_available(shard_id, anchor_context)
signal shard_collection_started(shard_id)
signal shard_collected(shard_id)
signal configuration_error(component, message)

enum SlotState {
	PACKED_HIDDEN,
	REVEALING,
	AVAILABLE,
	COLLECTION_STARTED,
	COLLECTED,
}

enum AnchorContext {
	FIRST_PASS,
	REMAINING_PASS,
}

@export var shard_id: StringName
@export var branch_id: StringName
@export_multiline var shard_text: String
@export var first_pass_anchor_path: NodePath = NodePath("FirstPassAnchor")
@export var remaining_pass_anchor_path: NodePath = NodePath("RemainingPassAnchor")
@export var soul_shard_path: NodePath = NodePath("SoulShard")
@export var reveal_vfx_root_path: NodePath = NodePath("RevealVFXRoot")

var _state: SlotState = SlotState.PACKED_HIDDEN
var _active_anchor_context: AnchorContext = AnchorContext.FIRST_PASS
var _availability_emitted := false
var _collection_started_emitted := false
var _collected_emitted := false
var _pending_reveal_token := 0

@onready var _first_pass_anchor: Marker3D = get_node_or_null(first_pass_anchor_path) as Marker3D
@onready var _remaining_pass_anchor: Marker3D = get_node_or_null(remaining_pass_anchor_path) as Marker3D
@onready var _soul_shard: Area3D = get_node_or_null(soul_shard_path) as Area3D
@onready var _reveal_vfx_root: Node3D = get_node_or_null(reveal_vfx_root_path) as Node3D


func _ready() -> void:
	debug_validate_configuration()
	_apply_packed_hidden_state()
	_connect_soul_shard_lifecycle()


func reveal_at(anchor_context: AnchorContext) -> bool:
	if _state != SlotState.PACKED_HIDDEN:
		return false
	if not debug_validate_configuration():
		return false
	_state = SlotState.REVEALING
	_active_anchor_context = anchor_context
	_pending_reveal_token += 1
	var reveal_token := _pending_reveal_token
	var anchor := _get_anchor_for_context(anchor_context)
	_soul_shard.global_transform = anchor.global_transform
	_soul_shard.visible = true
	_soul_shard.monitorable = true
	_soul_shard.monitoring = false
	_set_soul_shard_collision_disabled(true)
	if _reveal_vfx_root != null:
		_reveal_vfx_root.visible = true
	_enable_collectability_after_physics_frame.call_deferred(reveal_token)
	return true


func get_shard_id() -> StringName:
	return shard_id


func get_branch_id() -> StringName:
	return branch_id


func get_state() -> SlotState:
	return _state


func is_available() -> bool:
	return _state == SlotState.AVAILABLE


func is_collected() -> bool:
	return _state == SlotState.COLLECTED


func get_active_anchor_context() -> AnchorContext:
	return _active_anchor_context


func debug_validate_configuration() -> bool:
	var ok := true
	if shard_id == &"":
		_emit_configuration_error(&"Level04ShardSlot", "shard_id is empty")
		ok = false
	if branch_id == &"":
		_emit_configuration_error(&"Level04ShardSlot", "branch_id is empty")
		ok = false
	if get_node_or_null(first_pass_anchor_path) == null:
		_emit_configuration_error(&"Level04ShardSlot", "FirstPassAnchor path does not resolve")
		ok = false
	if get_node_or_null(remaining_pass_anchor_path) == null:
		_emit_configuration_error(&"Level04ShardSlot", "RemainingPassAnchor path does not resolve")
		ok = false
	var shard := get_node_or_null(soul_shard_path)
	if shard == null or not shard is Area3D:
		_emit_configuration_error(&"Level04ShardSlot", "SoulShard path does not resolve to Area3D")
		ok = false
	elif not shard.has_signal(&"reward_sequence_requested") or not shard.has_signal(&"collected"):
		_emit_configuration_error(&"Level04ShardSlot", "SoulShard public signals are unavailable")
		ok = false
	elif not shard.has_method(&"can_player_interact") or not shard.has_method(&"interact") or not shard.has_method(&"complete_collection_sequence"):
		_emit_configuration_error(&"Level04ShardSlot", "SoulShard public collection API is unavailable")
		ok = false
	return ok


func debug_get_active_anchor_global_transform() -> Transform3D:
	var anchor := _get_anchor_for_context(_active_anchor_context)
	if anchor == null:
		return Transform3D.IDENTITY
	return anchor.global_transform


func debug_get_soul_shard() -> Node:
	return _soul_shard


func debug_is_soul_shard_collectable() -> bool:
	if _soul_shard == null:
		return false
	var shape := _soul_shard.get_node_or_null("CollisionShape3D") as CollisionShape3D
	return _soul_shard.visible and _soul_shard.monitoring and _soul_shard.monitorable and shape != null and not shape.disabled


func _apply_packed_hidden_state() -> void:
	_state = SlotState.PACKED_HIDDEN
	_availability_emitted = false
	_collection_started_emitted = false
	_collected_emitted = false
	if _soul_shard != null:
		_soul_shard.visible = false
		_soul_shard.monitoring = false
		_soul_shard.monitorable = false
		_soul_shard.set(&"shard_id", shard_id)
		_soul_shard.set(&"reward_text", shard_text)
		_set_soul_shard_collision_disabled(true)
	if _reveal_vfx_root != null:
		_reveal_vfx_root.visible = false


func _connect_soul_shard_lifecycle() -> void:
	if _soul_shard == null:
		return
	if not _soul_shard.is_connected(&"reward_sequence_requested", _on_soul_shard_reward_sequence_requested):
		_soul_shard.connect(&"reward_sequence_requested", _on_soul_shard_reward_sequence_requested)
	if not _soul_shard.is_connected(&"collected", _on_soul_shard_collected):
		_soul_shard.connect(&"collected", _on_soul_shard_collected)


func _enable_collectability_after_physics_frame(reveal_token: int) -> void:
	await get_tree().physics_frame
	if reveal_token != _pending_reveal_token or _state != SlotState.REVEALING or _soul_shard == null:
		return
	_set_soul_shard_collision_disabled(false)
	_soul_shard.monitorable = true
	_soul_shard.monitoring = true
	await get_tree().physics_frame
	if reveal_token != _pending_reveal_token or _state != SlotState.REVEALING:
		return
	if not debug_is_soul_shard_collectable():
		_emit_configuration_error(&"Level04ShardSlot", "SoulShard collectability verification failed")
		return
	_state = SlotState.AVAILABLE
	if not _availability_emitted:
		_availability_emitted = true
		shard_available.emit(shard_id, _active_anchor_context)


func _on_soul_shard_reward_sequence_requested(_shard: Node, requested_shard_id: StringName, _reward_text: String, _world_position: Vector3) -> void:
	if requested_shard_id != shard_id:
		return
	if _state == SlotState.COLLECTED:
		return
	if not _collection_started_emitted:
		_collection_started_emitted = true
		_state = SlotState.COLLECTION_STARTED
		shard_collection_started.emit(shard_id)


func _on_soul_shard_collected() -> void:
	if _collected_emitted:
		return
	_collected_emitted = true
	_state = SlotState.COLLECTED
	shard_collected.emit(shard_id)


func _get_anchor_for_context(anchor_context: AnchorContext) -> Marker3D:
	if anchor_context == AnchorContext.REMAINING_PASS:
		return _remaining_pass_anchor
	return _first_pass_anchor


func _set_soul_shard_collision_disabled(disabled: bool) -> void:
	if _soul_shard == null:
		return
	var shape := _soul_shard.get_node_or_null("CollisionShape3D") as CollisionShape3D
	if shape != null:
		shape.set_deferred("disabled", disabled)


func _emit_configuration_error(component: StringName, message: String) -> void:
	push_error("%s: %s" % [String(component), message])
	configuration_error.emit(component, message)

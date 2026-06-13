extends Node
class_name ShardRewardSequenceController

enum SequenceState {
	IDLE,
	OPENING,
	WAITING_FOR_CONFIRMATION,
	RETURNING,
	COMPLETING,
}

@export var overlay_path: NodePath = NodePath("")
@export var player_path: NodePath = NodePath("")
@export var shard_search_root_path: NodePath = NodePath("..")

var _state := SequenceState.IDLE
var _overlay: Node = null
var _player: Node = null
var _active_shard: Node = null
var _active_shard_id: StringName = &""
var _active_reward_text: String = ""
var _active_world_position := Vector3.ZERO


func _ready() -> void:
	_overlay = _resolve_overlay()
	_player = _resolve_player()
	_connect_overlay_signals()
	call_deferred("_connect_existing_shards")


func register_shard(shard: Node) -> void:
	_connect_shard(shard)


func _connect_existing_shards() -> void:
	var root := get_node_or_null(shard_search_root_path)
	if root == null:
		root = get_tree().current_scene
	_scan_for_shards(root)


func _scan_for_shards(node: Node) -> void:
	if node == null:
		return
	_connect_shard(node)
	for child in node.get_children():
		_scan_for_shards(child)


func _connect_shard(shard: Node) -> void:
	if shard == null:
		return
	if not shard.has_signal("reward_sequence_requested"):
		return
	if shard.is_connected("reward_sequence_requested", _on_reward_sequence_requested):
		return
	shard.connect("reward_sequence_requested", _on_reward_sequence_requested)


func _on_reward_sequence_requested(shard: Node, shard_id: StringName, reward_text: String, world_position: Vector3) -> void:
	if _state != SequenceState.IDLE:
		push_warning("ShardRewardSequenceController rejected a second active shard request.")
		if shard != null and shard.has_method("complete_collection_sequence"):
			shard.call("complete_collection_sequence")
		return

	_active_shard = shard
	_active_shard_id = shard_id
	_active_reward_text = reward_text
	_active_world_position = world_position
	_state = SequenceState.OPENING
	_player = _resolve_player()
	_set_player_controls_enabled(false)

	_overlay = _resolve_overlay()
	_connect_overlay_signals()
	if _overlay == null or not _overlay.has_method("play_reward"):
		push_warning("ShardRewardSequenceController could not find ShardRewardOverlay; completing shard safely.")
		_complete_without_return()
		return

	var camera := _resolve_camera()
	if camera == null:
		push_warning("ShardRewardSequenceController could not find active Camera3D; completing shard safely.")
		_complete_without_return()
		return

	var origin_screen_position := _project_world_to_screen(camera, world_position)
	_overlay.call("play_reward", reward_text, origin_screen_position)
	_state = SequenceState.WAITING_FOR_CONFIRMATION


func _on_overlay_confirmation_requested() -> void:
	if _state != SequenceState.WAITING_FOR_CONFIRMATION:
		return

	_state = SequenceState.RETURNING
	var camera := _resolve_camera()
	var orb_visual := _resolve_active_orb_visual()
	if camera == null or orb_visual == null:
		push_warning("ShardRewardSequenceController could not resolve camera or SoulOrb target; completing shard safely.")
		_complete_without_return()
		return

	var target_screen_position := _project_world_to_screen(camera, orb_visual.global_position)
	if _overlay != null and _overlay.has_method("play_return_to"):
		_overlay.call("play_return_to", target_screen_position)
	else:
		_complete_without_return()


func _on_overlay_return_completed() -> void:
	if _state != SequenceState.RETURNING:
		return

	_state = SequenceState.COMPLETING
	var orb_visual := _resolve_active_orb_visual()
	if orb_visual != null and orb_visual.has_method("play_absorb_pulse"):
		orb_visual.call("play_absorb_pulse")
	_complete_active_shard()
	_reset_sequence_state()


func _complete_without_return() -> void:
	if _overlay != null and _overlay.has_method("reset_overlay"):
		_overlay.call("reset_overlay")
	_complete_active_shard()
	_reset_sequence_state()


func _complete_active_shard() -> void:
	if _active_shard != null and is_instance_valid(_active_shard) and _active_shard.has_method("complete_collection_sequence"):
		_active_shard.call("complete_collection_sequence")


func _reset_sequence_state() -> void:
	_set_player_controls_enabled(true)
	_active_shard = null
	_active_shard_id = &""
	_active_reward_text = ""
	_active_world_position = Vector3.ZERO
	_state = SequenceState.IDLE


func _resolve_overlay() -> Node:
	if not overlay_path.is_empty():
		var explicit_overlay := get_node_or_null(overlay_path)
		if explicit_overlay != null:
			return explicit_overlay
	var scene := get_tree().current_scene
	return _find_node_with_method(scene, "play_reward")


func _resolve_player() -> Node:
	if _player != null and is_instance_valid(_player):
		return _player
	if not player_path.is_empty():
		var explicit_player := get_node_or_null(player_path)
		if explicit_player != null:
			return explicit_player
	return _find_node_named(get_tree().current_scene, "Player")


func _resolve_camera() -> Camera3D:
	var viewport := get_viewport()
	if viewport == null:
		return null
	return viewport.get_camera_3d()


func _resolve_active_orb_visual() -> Node3D:
	var candidates := get_tree().get_nodes_in_group("soul_orb_visual")
	var fallback: Node3D = null
	for candidate in candidates:
		if not candidate is Node3D:
			continue
		var visual := candidate as Node3D
		if not visual.is_inside_tree() or not visual.is_visible_in_tree():
			continue
		if _has_ancestor_named(visual, "SoulOrb_Follow"):
			return visual
		if fallback == null:
			fallback = visual
	return fallback


func _project_world_to_screen(camera: Camera3D, world_position: Vector3) -> Vector2:
	var viewport_size := get_viewport().get_visible_rect().size
	if camera == null:
		return viewport_size * 0.5
	var screen_position := camera.unproject_position(world_position)
	return screen_position.clamp(Vector2.ZERO, viewport_size)


func _connect_overlay_signals() -> void:
	if _overlay == null:
		return
	if _overlay.has_signal("confirmation_requested") and not _overlay.is_connected("confirmation_requested", _on_overlay_confirmation_requested):
		_overlay.connect("confirmation_requested", _on_overlay_confirmation_requested)
	if _overlay.has_signal("return_completed") and not _overlay.is_connected("return_completed", _on_overlay_return_completed):
		_overlay.connect("return_completed", _on_overlay_return_completed)


func _set_player_controls_enabled(enabled: bool) -> void:
	var player := _resolve_player()
	if player != null and player.has_method("set_controls_enabled"):
		player.call("set_controls_enabled", enabled)


func _find_node_with_method(node: Node, method_name: StringName) -> Node:
	if node == null:
		return null
	if node.has_method(method_name):
		return node
	for child in node.get_children():
		var found := _find_node_with_method(child, method_name)
		if found != null:
			return found
	return null


func _find_node_named(node: Node, target_name: StringName) -> Node:
	if node == null:
		return null
	if node.name == target_name:
		return node
	for child in node.get_children():
		var found := _find_node_named(child, target_name)
		if found != null:
			return found
	return null


func _has_ancestor_named(node: Node, ancestor_name: StringName) -> bool:
	var current := node.get_parent()
	while current != null:
		if current.name == ancestor_name:
			return true
		current = current.get_parent()
	return false

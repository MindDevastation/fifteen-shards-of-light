extends Node

@export var level_id: int = 1
@export var soul_shard_path: NodePath = ^"../SoulShard"
@export var poem_reward_ui_path: NodePath = ^"../UILayer/PoemRewardUI"
@export var level_portal_path: NodePath = ^"../LevelPortal"

var _poem_reward_ui: Node
var _level_portal: Node


func _ready() -> void:
	print("LevelManager ready for level %d." % level_id)
	_connect_stage_1d_nodes()


func _connect_stage_1d_nodes() -> void:
	var soul_shard := get_node_or_null(soul_shard_path)
	_poem_reward_ui = get_node_or_null(poem_reward_ui_path)
	_level_portal = get_node_or_null(level_portal_path)

	if soul_shard != null and soul_shard.has_signal("collected"):
		soul_shard.connect("collected", _on_soul_shard_collected)
	else:
		push_warning("Level %d has no Stage 1D SoulShard connected." % level_id)

	if _poem_reward_ui != null:
		_poem_reward_ui.hide()
		if _poem_reward_ui.has_signal("closed"):
			_poem_reward_ui.connect("closed", _on_poem_reward_ui_closed)
	else:
		push_warning("Level %d has no Stage 1D PoemRewardUI connected." % level_id)


func _on_soul_shard_collected() -> void:
	print("Level %d SoulShard collected; showing placeholder reward UI." % level_id)

	if _poem_reward_ui == null:
		return

	if _poem_reward_ui.has_method("show_placeholder_reward"):
		_poem_reward_ui.call("show_placeholder_reward")
	else:
		_poem_reward_ui.show()


func _on_poem_reward_ui_closed() -> void:
	if _poem_reward_ui != null:
		_poem_reward_ui.hide()

	if _level_portal != null and _level_portal.has_method("activate"):
		_level_portal.call("activate")

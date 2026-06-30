extends Node
class_name Level02RuntimeContractValidator

signal validation_failed(reason: String)
signal validation_passed

@export var player_path: NodePath
@export var progress_path: NodePath
@export var arrival_path: NodePath
@export var soft_return_path: NodePath
@export var reward_controller_path: NodePath
var _prepared := false
var _committed := false

func prepare() -> bool:
	_prepared = false
	for p in [player_path, progress_path, arrival_path, soft_return_path]:
		if p.is_empty() or get_node_or_null(p) == null:
			validation_failed.emit("missing dependency: %s" % [p])
			return false
	_prepared = true
	return true

func commit_startup() -> bool:
	if _committed:
		return true
	if not _prepared and not prepare():
		return false
	var progress := get_node(progress_path)
	var player := get_node(player_path)
	var arrival := get_node(arrival_path)
	var soft_return := get_node(soft_return_path)
	if soft_return.has_method("arm"):
		soft_return.arm()
	if progress.has_method("arm"):
		progress.arm()
	if player.has_method("set_controls_enabled"):
		player.set_controls_enabled(true)
	elif "controls_enabled" in player:
		player.controls_enabled = true
	if arrival.has_method("arm"):
		arrival.arm()
	_committed = true
	validation_passed.emit()
	return true

extends Node
class_name Level01ProgressionController

signal all_required_shards_collected
signal barrier_opening_started
signal barrier_opened

enum BarrierState { LOCKED, OPEN_PENDING, OPENING, OPEN }

@export var required_shard_paths: Array[NodePath] = []
@export var barrier_path: NodePath
@export var barrier_open_offset: Vector3 = Vector3(0.0, -7.0, 0.0)
@export_range(0.1, 10.0, 0.1) var barrier_open_duration: float = 5.0
@export var barrier_transition: Tween.TransitionType = Tween.TRANS_SINE
@export var barrier_ease: Tween.EaseType = Tween.EASE_IN_OUT

var _barrier_state := BarrierState.LOCKED
var _required_shards: Array[Node] = []
var _collected_shard_ids: Dictionary = {}
var _barrier: Node3D
var _barrier_tween: Tween
var _configuration_valid := false


func _ready() -> void:
	_configuration_valid = _configure()


func are_all_required_shards_collected() -> bool:
	return _configuration_valid and _collected_shard_ids.size() == _required_shards.size()


func is_barrier_open() -> bool:
	return _barrier_state == BarrierState.OPEN


func is_finale_unlocked() -> bool:
	return is_barrier_open()


func _configure() -> bool:
	if barrier_path.is_empty():
		push_error("Level01ProgressionController requires barrier_path.")
		return false
	var barrier_node := get_node_or_null(barrier_path)
	if not barrier_node is Node3D:
		push_error("Level01ProgressionController barrier_path must resolve to Node3D: %s" % [barrier_path])
		return false
	_barrier = barrier_node
	if required_shard_paths.is_empty():
		push_error("Level01ProgressionController requires at least one required shard path.")
		return false
	var seen_ids := {}
	for shard_path in required_shard_paths:
		var shard := get_node_or_null(shard_path)
		if shard == null:
			push_error("Level01ProgressionController missing required shard: %s" % [shard_path])
			return false
		if not shard.has_signal(&"collected"):
			push_error("Required shard has no collected signal: %s" % [shard_path])
			return false
		var instance_id := shard.get_instance_id()
		if seen_ids.has(instance_id):
			push_error("Duplicate required shard reference: %s" % [shard_path])
			return false
		seen_ids[instance_id] = true
		_required_shards.append(shard)
		shard.collected.connect(_on_required_shard_collected.bind(shard))
	return true


func _on_required_shard_collected(shard: Node) -> void:
	if not _configuration_valid or _barrier_state != BarrierState.LOCKED:
		return
	var instance_id := shard.get_instance_id()
	if _collected_shard_ids.has(instance_id):
		return
	_collected_shard_ids[instance_id] = true
	if _collected_shard_ids.size() != _required_shards.size():
		return
	_barrier_state = BarrierState.OPEN_PENDING
	all_required_shards_collected.emit()
	call_deferred("_begin_barrier_opening")


func _begin_barrier_opening() -> void:
	if not _configuration_valid or _barrier_state != BarrierState.OPEN_PENDING:
		return
	_barrier_state = BarrierState.OPENING
	if _barrier_tween != null and _barrier_tween.is_valid():
		_barrier_tween.kill()
	barrier_opening_started.emit()
	var target_position := _barrier.position + barrier_open_offset
	_barrier_tween = create_tween()
	_barrier_tween.set_trans(barrier_transition)
	_barrier_tween.set_ease(barrier_ease)
	_barrier_tween.tween_property(_barrier, "position", target_position, barrier_open_duration)
	_barrier_tween.finished.connect(_on_barrier_tween_finished)


func _on_barrier_tween_finished() -> void:
	if _barrier_state != BarrierState.OPENING:
		return
	_barrier_state = BarrierState.OPEN
	barrier_opened.emit()

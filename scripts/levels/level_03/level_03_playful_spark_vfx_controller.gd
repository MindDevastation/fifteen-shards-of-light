class_name Level03PlayfulSparkVFXController
extends Node3D

signal preglow_finished(from_id: StringName, to_id: StringName, generation: int)
signal hop_finished(from_id: StringName, to_id: StringName, generation: int)

@export var enabled: bool = true
@export var spark_visual_path: NodePath = NodePath("SparkVisual")
@export var destination_telegraph_path: NodePath = NodePath("DestinationTelegraph")

var _preglow_generation := -1
var _hop_generation := -1
var _telegraph_generation := -1
var _preglow_tween: Tween = null
var _hop_tween: Tween = null
var _telegraph_tween: Tween = null

func show_destination_telegraph(perch_id: StringName, world_position: Vector3, generation: int) -> bool:
	if not enabled or not is_inside_tree() or perch_id == &"" or world_position == Vector3.INF:
		return false
	if generation < _telegraph_generation:
		return false
	_telegraph_generation = generation
	var telegraph := get_node_or_null(destination_telegraph_path) as Node3D
	if telegraph == null:
		return false
	if _telegraph_tween != null and _telegraph_tween.is_valid():
		_telegraph_tween.kill()
	telegraph.global_position = world_position
	telegraph.visible = true
	telegraph.scale = Vector3.ONE * 0.75
	_telegraph_tween = create_tween().set_loops(2)
	_telegraph_tween.tween_property(telegraph, "scale", Vector3.ONE * 1.25, 0.18)
	_telegraph_tween.tween_property(telegraph, "scale", Vector3.ONE * 0.85, 0.18)
	return true

func hide_destination_telegraph(generation: int) -> void:
	if generation < _telegraph_generation:
		return
	var telegraph := get_node_or_null(destination_telegraph_path) as Node3D
	if telegraph != null:
		telegraph.visible = false

func play_preglow(from_id: StringName, to_id: StringName, generation: int, from_world_position: Vector3, to_world_position: Vector3, duration: float) -> bool:
	if not enabled or not is_inside_tree() or from_world_position == Vector3.INF or to_world_position == Vector3.INF:
		return false
	var visual := get_node_or_null(spark_visual_path) as Node3D
	if visual == null:
		return false
	_preglow_generation = generation
	if _preglow_tween != null and _preglow_tween.is_valid():
		_preglow_tween.kill()
	visual.visible = true
	visual.global_position = from_world_position
	visual.scale = Vector3.ONE * 0.6
	_preglow_tween = create_tween()
	_preglow_tween.tween_property(visual, "scale", Vector3.ONE * 1.45, max(duration * 0.5, 0.01))
	_preglow_tween.tween_property(visual, "scale", Vector3.ONE * 0.9, max(duration * 0.5, 0.01))
	_preglow_tween.finished.connect(func() -> void:
		if _preglow_generation == generation:
			preglow_finished.emit(from_id, to_id, generation)
	)
	return true

func play_hop(from_id: StringName, to_id: StringName, generation: int, from_world_position: Vector3, to_world_position: Vector3, duration: float) -> bool:
	if not enabled or not is_inside_tree() or from_world_position == Vector3.INF or to_world_position == Vector3.INF:
		return false
	var visual := get_node_or_null(spark_visual_path) as Node3D
	if visual == null:
		return false
	_hop_generation = generation
	if _hop_tween != null and _hop_tween.is_valid():
		_hop_tween.kill()
	visual.visible = true
	visual.global_position = from_world_position
	visual.scale = Vector3.ONE
	_hop_tween = create_tween()
	_hop_tween.tween_property(visual, "global_position", to_world_position, clamp(duration, 0.75, 0.90))
	_hop_tween.finished.connect(func() -> void:
		if _hop_generation == generation:
			visual.global_position = to_world_position
			hop_finished.emit(from_id, to_id, generation)
	)
	return true

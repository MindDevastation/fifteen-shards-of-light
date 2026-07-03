class_name Level03BreathingMeadowVFXController
extends Node3D

signal petal_presentation_finished(petal_id: StringName, generation: int)

@export var enabled: bool = true
@export var channels_root_path: NodePath = NodePath("PetalChannels")
@export var teaching_root_path: NodePath = NodePath("TeachingIndicators")
@export var rest_progress_root_path: NodePath = NodePath("RestProgressVisuals")

var _active_generations: Dictionary = {}
var _active_tweens: Dictionary = {}
var _petal_positions: Dictionary = {}
var _rest_generation := -1

func show_teaching_preglow(petal_positions: Dictionary, generation: int) -> bool:
	if not enabled or not is_inside_tree():
		return false
	_petal_positions = petal_positions.duplicate()
	var teaching_root := get_node_or_null(teaching_root_path)
	if teaching_root == null:
		return false
	for petal_id in _petal_positions.keys():
		var visual := teaching_root.get_node_or_null(String(petal_id)) as Node3D
		if visual == null:
			continue
		visual.global_position = _petal_positions[petal_id]
		visual.visible = true
		visual.scale = Vector3.ONE * 0.5
		var tween := create_tween()
		tween.tween_property(visual, "scale", Vector3.ONE * 0.9, 0.35)
		tween.tween_property(visual, "scale", Vector3.ONE * 0.65, 0.35)
	return true

func play_petal_presentation(petal_id: StringName, generation: int, duration: float) -> bool:
	if not enabled or not is_inside_tree() or petal_id == &"" or generation < 0:
		return false
	var visual := _get_channel_visual(petal_id)
	if visual == null:
		return false
	var world_position: Vector3 = _petal_positions.get(petal_id, visual.global_position)
	_active_generations[petal_id] = generation
	var old_tween: Tween = _active_tweens.get(petal_id)
	if old_tween != null and old_tween.is_valid():
		old_tween.kill()
	visual.visible = true
	visual.global_position = world_position
	visual.scale = Vector3.ONE * 0.55
	var tween := create_tween()
	_active_tweens[petal_id] = tween
	tween.tween_property(visual, "scale", Vector3.ONE * 1.35, max(duration * 0.45, 0.01))
	tween.parallel().tween_property(visual, "position:y", visual.position.y + 0.45, max(duration * 0.45, 0.01))
	tween.tween_property(visual, "scale", Vector3.ONE * 0.85, max(duration * 0.55, 0.01))
	tween.finished.connect(func() -> void:
		if _active_generations.get(petal_id) == generation:
			petal_presentation_finished.emit(petal_id, generation)
	)
	return true

func set_rest_progress(unique_count: int, generation: int) -> bool:
	if not enabled or not is_inside_tree():
		return false
	if generation < _rest_generation:
		return false
	_rest_generation = generation
	var root := get_node_or_null(rest_progress_root_path)
	if root == null:
		return false
	for i in range(1, 4):
		var segment := root.get_node_or_null("Segment_%02d" % i) as Node3D
		if segment == null:
			continue
		segment.visible = i <= unique_count
		if segment.visible:
			segment.scale = Vector3.ONE * (0.6 + 0.15 * i)
	var convergence := root.get_node_or_null("Convergence") as Node3D
	if convergence != null:
		convergence.visible = unique_count >= 3
	return true

func _get_channel_visual(petal_id: StringName) -> Node3D:
	var root := get_node_or_null(channels_root_path)
	if root == null:
		return null
	return root.get_node_or_null(String(petal_id)) as Node3D

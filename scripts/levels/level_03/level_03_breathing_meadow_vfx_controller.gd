class_name Level03BreathingMeadowVFXController
extends Node3D

signal petal_presentation_finished(petal_id: StringName, generation: int)

@export var enabled: bool = true

var _active_generations: Dictionary = {}
var _active_tweens: Dictionary = {}

func play_petal_presentation(petal_id: StringName, generation: int, duration: float) -> bool:
	if not enabled or not is_inside_tree() or petal_id == &"" or generation < 0:
		return false
	_active_generations[petal_id] = generation
	var old_tween: Tween = _active_tweens.get(petal_id)
	if old_tween != null and old_tween.is_valid():
		old_tween.kill()
	var tween := create_tween()
	_active_tweens[petal_id] = tween
	tween.tween_interval(max(duration, 0.01))
	tween.finished.connect(func() -> void:
		if _active_generations.get(petal_id) == generation:
			petal_presentation_finished.emit(petal_id, generation)
	)
	return true

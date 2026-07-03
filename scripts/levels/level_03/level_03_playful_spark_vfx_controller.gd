class_name Level03PlayfulSparkVFXController
extends Node3D

signal hop_finished(from_id: StringName, to_id: StringName, generation: int)

@export var enabled: bool = true

var _active_generation := -1
var _active_tween: Tween = null

func play_hop(from_id: StringName, to_id: StringName, generation: int, duration: float) -> bool:
	if not enabled or not is_inside_tree() or from_id == &"" or to_id == &"" or generation < 0:
		return false
	_active_generation = generation
	if _active_tween != null and _active_tween.is_valid():
		_active_tween.kill()
	_active_tween = create_tween()
	_active_tween.tween_interval(max(duration, 0.01))
	_active_tween.finished.connect(func() -> void:
		if _active_generation == generation:
			hop_finished.emit(from_id, to_id, generation)
	)
	return true

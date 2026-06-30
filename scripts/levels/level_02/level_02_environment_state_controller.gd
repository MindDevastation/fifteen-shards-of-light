extends Node
class_name Level02EnvironmentStateController

signal color_ready
signal fog_ready
signal transition_started(index: int)
signal transition_finished(index: int)

@export var saturation := 0.20
@export var fog_ratio := 1.00
@export var color_duration := 9.0
@export var second_fog_duration := 7.0
var admitted_count := 0
var _color_tween: Tween
var _fog_tween: Tween

func on_admitted_shard(_shard_id: StringName) -> void:
	admitted_count += 1
	transition_started.emit(admitted_count)
	if admitted_count == 1:
		_start_color_restore()
		fog_ratio = 0.92
		transition_finished.emit(1)
	elif admitted_count == 2:
		_start_second_fog()

func _start_color_restore() -> void:
	if _color_tween: _color_tween.kill()
	_color_tween = create_tween()
	_color_tween.tween_property(self, "saturation", 1.0, color_duration)
	_color_tween.finished.connect(func(): saturation = 1.0; color_ready.emit())

func _start_second_fog() -> void:
	if _fog_tween: _fog_tween.kill()
	saturation = 1.0
	_fog_tween = create_tween()
	_fog_tween.tween_property(self, "fog_ratio", 0.55, second_fog_duration)
	_fog_tween.finished.connect(func(): fog_ratio = 0.55; fog_ready.emit(); transition_finished.emit(2))

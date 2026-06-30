extends Node
class_name Level02EnvironmentStateController
signal color_ready
signal fog_ready
@export var saturation := 0.20
@export var fog_ratio := 1.00
var admitted_count := 0
func on_admitted_shard(_shard_id: StringName) -> void:
	admitted_count += 1
	if admitted_count == 1:
		saturation = 1.0; fog_ratio = 0.92; color_ready.emit()
	elif admitted_count >= 2:
		saturation = 1.0; fog_ratio = 0.55; fog_ready.emit()

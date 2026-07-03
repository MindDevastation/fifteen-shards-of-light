class_name PlayfulSparkController
extends Node3D
signal solved
@export var progress_controller_path: NodePath = NodePath("../../../LevelRuntimeRoot/Level03ProgressController")
const ORDER := [&"Perch_A", &"Perch_B", &"Perch_C"]
var armed := false
var index := 0
var completed := false
func arm() -> bool:
	armed = true
	return true
func accept_perch(perch_id: StringName) -> void:
	if not armed or completed:
		return
	if perch_id == ORDER[index]:
		index += 1
		if index >= ORDER.size():
			completed = true
			solved.emit()
			var progress := get_node_or_null(progress_controller_path)
			if progress != null and progress.has_method("notify_playful_spark_solved"):
				progress.notify_playful_spark_solved()
	else:
		index = 0

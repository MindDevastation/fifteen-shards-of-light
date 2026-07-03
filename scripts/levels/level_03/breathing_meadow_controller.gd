class_name BreathingMeadowController
extends Node3D
signal solved
@export var progress_controller_path: NodePath = NodePath("../../../LevelRuntimeRoot/Level03ProgressController")
const REQUIRED := [&"Petal_W", &"Petal_SE", &"Petal_NE"]
var armed := false
var completed := false
var visited: Array[StringName] = []
func arm() -> bool:
	armed = true
	return true
func accept_petal(petal_id: StringName) -> void:
	if not armed or completed or not REQUIRED.has(petal_id):
		return
	if not visited.has(petal_id):
		visited.append(petal_id)
	if visited.size() == REQUIRED.size():
		completed = true
		solved.emit()
		var progress := get_node_or_null(progress_controller_path)
		if progress != null and progress.has_method("notify_breathing_meadow_solved"):
			progress.notify_breathing_meadow_solved()

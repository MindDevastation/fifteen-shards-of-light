class_name WindTraceController
extends Node3D
signal solved
@export var progress_controller_path: NodePath = NodePath("../../../LevelRuntimeRoot/Level03ProgressController")
@export var debug_enabled: bool = false
const ORDER := [&"Arch_01", &"Arch_02", &"Arch_03"]
var armed := true
var index := 0
var completed := false
func arm() -> bool:
	armed = true
	return true
func reset_attempt() -> void:
	if not completed:
		index = 0
func accept_arch(arch_id: StringName) -> void:
	if not armed or completed:
		return
	if arch_id == ORDER[index]:
		index += 1
		if index >= ORDER.size():
			completed = true
			solved.emit()
			var progress := get_node_or_null(progress_controller_path)
			if progress != null and progress.has_method("notify_wind_trace_solved"):
				progress.notify_wind_trace_solved()
	else:
		reset_attempt()

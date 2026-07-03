class_name PlayfulSparkController
extends Node3D
signal puzzle_completed(puzzle_id: StringName)
signal solved
@export var progress_controller_path: NodePath = NodePath("../../../LevelRuntimeRoot/Level03ProgressController")
const PUZZLE_ID := &"playful_spark"
const ORDER := [&"Perch_A", &"Perch_B", &"Perch_C"]
var armed := false
var index := 0
var completed := false
var generation := 0
var occupied_perch: StringName = &""
func arm() -> bool:
	if completed: return false
	armed = true; generation += 1; return true
func accept_perch(perch_id: StringName) -> void:
	if not armed or completed: return
	if occupied_perch == perch_id: return
	occupied_perch = perch_id
	if perch_id != ORDER[index]:
		index = 0; return
	index += 1
	if index >= ORDER.size(): _complete(generation)
func clear_occupancy(perch_id: StringName) -> void:
	if occupied_perch == perch_id: occupied_perch = &""
func _complete(source_generation: int) -> void:
	if completed or source_generation != generation: return
	completed = true; armed = false
	puzzle_completed.emit(PUZZLE_ID); solved.emit()
	var progress := get_node_or_null(progress_controller_path)
	if progress != null and progress.has_method("accept_puzzle_completed"):
		progress.accept_puzzle_completed(PUZZLE_ID)

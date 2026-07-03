class_name BreathingMeadowController
extends Node3D
signal puzzle_completed(puzzle_id: StringName)
signal solved
signal petal_completed(petal_id: StringName)
@export var progress_controller_path: NodePath = NodePath("../../../LevelRuntimeRoot/Level03ProgressController")
const PUZZLE_ID := &"breathing_meadow"
const REQUIRED := [&"Petal_W", &"Petal_SE", &"Petal_NE"]
var armed := false
var completed := false
var generation := 0
var visited: Array[StringName] = []
func arm() -> bool:
	if completed: return false
	armed = true; generation += 1; return true
func accept_petal(petal_id: StringName) -> void:
	if not armed or completed or not REQUIRED.has(petal_id): return
	if visited.has(petal_id): return
	visited.append(petal_id); petal_completed.emit(petal_id)
	if visited.size() == REQUIRED.size(): _complete(generation)
func _complete(source_generation: int) -> void:
	if completed or source_generation != generation: return
	completed = true; armed = false
	puzzle_completed.emit(PUZZLE_ID); solved.emit()
	var progress := get_node_or_null(progress_controller_path)
	if progress != null and progress.has_method("accept_puzzle_completed"):
		progress.accept_puzzle_completed(PUZZLE_ID)

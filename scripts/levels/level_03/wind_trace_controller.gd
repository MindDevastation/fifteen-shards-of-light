class_name WindTraceController
extends Node3D
signal puzzle_completed(puzzle_id: StringName)
signal solved
@export var progress_controller_path: NodePath = NodePath("../../../LevelRuntimeRoot/Level03ProgressController")
@export var fallback_seconds: float = 4.0
@export var debug_enabled: bool = false
const PUZZLE_ID := &"wind_trace"
const ORDER := [&"Arch_01", &"Arch_02", &"Arch_03"]
var armed := false
var index := 0
var completed := false
var generation := 0
var latched: Dictionary = {}
func arm() -> bool:
	if completed: return false
	armed = true; generation += 1; return true
func accept_arch(arch_id: StringName) -> void:
	if not armed or completed: return
	if not ORDER.has(arch_id): return
	if latched.has(arch_id): return
	var expected: StringName = ORDER[index]
	if arch_id != expected:
		index = 0; latched.clear(); return
	latched[arch_id] = generation
	index += 1
	if index >= ORDER.size(): _complete(generation)
func reevaluate_active_overlap() -> void:
	# Hook for Area3D overlap re-check; production-safe no-op when no body is already overlapping.
	pass
func _complete(source_generation: int) -> void:
	if completed or source_generation != generation: return
	completed = true; armed = false
	puzzle_completed.emit(PUZZLE_ID); solved.emit()
	var progress := get_node_or_null(progress_controller_path)
	if progress != null and progress.has_method("accept_puzzle_completed"):
		progress.accept_puzzle_completed(PUZZLE_ID)

class_name WindTraceController
extends Node3D
signal activity_confirmed
signal puzzle_completed(puzzle_id: StringName)
signal solved
@export var auto_confirm_seconds: float = 4.0
@export var debug_enabled: bool = false
const PUZZLE_ID := &"wind_trace"
const ORDER: Array[StringName] = [&"Arch_01", &"Arch_02", &"Arch_03"]
var armed := false
var index := 0
var completed := false
var generation := 0
var activity_is_confirmed := false
var latched: Dictionary = {}
func _ready() -> void: set_process_unhandled_input(true)
func arm() -> bool:
	if completed: return false
	armed = true; generation += 1; index = 0; latched.clear(); activity_is_confirmed = false
	_auto_confirm_later(generation)
	return true
func _unhandled_input(event: InputEvent) -> void:
	if armed and not activity_is_confirmed and (event is InputEventKey or event is InputEventMouseMotion): confirm_activity()
func confirm_activity() -> void:
	if activity_is_confirmed or completed: return
	activity_is_confirmed = true; activity_confirmed.emit()
func _auto_confirm_later(source_generation: int) -> void:
	await get_tree().create_timer(auto_confirm_seconds).timeout
	if armed and not completed and not activity_is_confirmed and source_generation == generation: confirm_activity()
func accept_arch(arch_id: StringName, body: Node = null) -> void:
	if body != null and not (body is CharacterBody3D): return
	if not armed or completed or not activity_is_confirmed: return
	if not ORDER.has(arch_id) or latched.has(arch_id): return
	var expected: StringName = ORDER[index]
	if arch_id != expected:
		index = 0; latched.clear(); return
	latched[arch_id] = generation
	index += 1
	if index >= ORDER.size(): _complete(generation)
	else: reevaluate_active_overlap()
func reevaluate_active_overlap() -> void:
	if completed or not armed or index >= ORDER.size(): return
	var active_arch := get_node_or_null(String(ORDER[index]))
	if active_arch is Area3D:
		for body in active_arch.get_overlapping_bodies(): accept_arch(ORDER[index], body)
func _complete(source_generation: int) -> void:
	if completed or source_generation != generation: return
	completed = true; armed = false
	puzzle_completed.emit(PUZZLE_ID); solved.emit()

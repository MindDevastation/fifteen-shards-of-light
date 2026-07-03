class_name BreathingMeadowController
extends Node3D

signal puzzle_completed(puzzle_id: StringName)
signal solved
signal petal_completed(petal_id: StringName)
signal petal_activated(petal_id: StringName)
signal meadow_progress_changed(completed_ids: Array[StringName])
signal meadow_hint_requested(hint_level: int)
signal petal_presentation_started(petal_id: StringName, generation: int)
signal petal_presentation_completed(petal_id: StringName, generation: int, via_fallback: bool)

@export var progress_controller_path: NodePath = NodePath("../../../LevelRuntimeRoot/Level03ProgressController")
@export var player_path: NodePath = NodePath("../../../PlayerRoot/Player")
@export var dwell_seconds: float = 0.65
@export var presentation_seconds: float = 1.45
@export var fallback_deadline_seconds: float = 1.80
@export var first_hint_seconds: float = 25.0
@export var second_hint_seconds: float = 45.0

const PUZZLE_ID := &"breathing_meadow"
const REQUIRED: Array[StringName] = [&"Petal_W", &"Petal_SE", &"Petal_NE"]
enum MeadowState { LOCKED, ACTIVE, COMPLETED }

var state: MeadowState = MeadowState.LOCKED
var armed := false
var completed := false
var generation := 0
var visited: Array[StringName] = []
var _player: Node = null
var _petals: Dictionary = {}
var _records: Dictionary = {}
var _active_dwell_id: StringName = &""
var _hint_generation := 0

func _ready() -> void:
	_collect_petals()
	_set_all_petals_enabled(false)
	set_physics_process(true)

func arm() -> bool:
	if completed or armed or state != MeadowState.LOCKED:
		return false
	if not _prepare_runtime_contract():
		return false
	armed = true
	state = MeadowState.ACTIVE
	generation += 1
	_hint_generation += 1
	_set_all_petals_enabled(true)
	_start_hint_timer(_hint_generation, first_hint_seconds, 1)
	_start_hint_timer(_hint_generation, second_hint_seconds, 2)
	return true

func accept_petal(petal_id: StringName) -> void:
	if state != MeadowState.ACTIVE or completed or not REQUIRED.has(petal_id):
		return
	if visited.has(petal_id) or _active_dwell_id != &"":
		return
	var record: Dictionary = _records[petal_id]
	record.entered = true
	record.dwell_elapsed = 0.0
	_records[petal_id] = record
	_active_dwell_id = petal_id

func clear_petal(petal_id: StringName) -> void:
	if not _records.has(petal_id):
		return
	var record: Dictionary = _records[petal_id]
	record.entered = false
	if not record.logical_completed:
		record.dwell_elapsed = 0.0
	_records[petal_id] = record
	if _active_dwell_id == petal_id:
		_active_dwell_id = &""

func petal_presentation_terminal(petal_id: StringName, presentation_generation: int, via_fallback: bool) -> bool:
	if not _records.has(petal_id):
		return false
	var record: Dictionary = _records[petal_id]
	if record.presentation_terminal_accepted or record.presentation_generation != presentation_generation:
		return false
	record.presentation_terminal_accepted = true
	_records[petal_id] = record
	petal_presentation_completed.emit(petal_id, presentation_generation, via_fallback)
	return true

func get_completed_petals() -> Array[StringName]:
	return visited.duplicate()

func get_state_name() -> StringName:
	return StringName(MeadowState.keys()[state])

func _physics_process(delta: float) -> void:
	if state != MeadowState.ACTIVE or _active_dwell_id == &"":
		return
	if _player == null or not _player.has_method("is_on_floor") or not _player.is_on_floor():
		_reset_active_dwell()
		return
	var petal_id := _active_dwell_id
	var record: Dictionary = _records[petal_id]
	if not record.entered or record.logical_completed:
		_reset_active_dwell()
		return
	record.dwell_elapsed += delta
	_records[petal_id] = record
	if record.dwell_elapsed >= dwell_seconds:
		_complete_petal(petal_id)

func _prepare_runtime_contract() -> bool:
	_player = get_node_or_null(player_path)
	if _player == null or not _player.has_method("is_on_floor"):
		return false
	_collect_petals()
	_records.clear()
	for id in REQUIRED:
		if not _petals.has(id):
			return false
		var petal: Node = _petals[id]
		if not petal.has_method("register_player") or not petal.has_method("set_acceptance_enabled"):
			return false
		petal.register_player(_player)
		_records[id] = _new_record()
	return true

func _collect_petals() -> void:
	_petals.clear()
	for child in get_children():
		if child is BreathingMeadowPetal:
			_petals[child.petal_id] = child

func _new_record() -> Dictionary:
	return {
		"entered": false,
		"dwell_elapsed": 0.0,
		"logical_completed": false,
		"presentation_generation": 0,
		"presentation_terminal_accepted": false,
	}

func _complete_petal(petal_id: StringName) -> void:
	if visited.has(petal_id):
		_reset_active_dwell()
		return
	var record: Dictionary = _records[petal_id]
	record.logical_completed = true
	record.dwell_elapsed = dwell_seconds
	visited.append(petal_id)
	_records[petal_id] = record
	_active_dwell_id = &""
	petal_activated.emit(petal_id)
	petal_completed.emit(petal_id)
	meadow_progress_changed.emit(visited.duplicate())
	_start_petal_presentation(petal_id)
	if visited.size() == REQUIRED.size():
		_complete()

func _start_petal_presentation(petal_id: StringName) -> void:
	var record: Dictionary = _records[petal_id]
	record.presentation_generation += 1
	record.presentation_terminal_accepted = false
	_records[petal_id] = record
	var presentation_generation: int = record.presentation_generation
	petal_presentation_started.emit(petal_id, presentation_generation)
	_start_real_presentation_timer(petal_id, presentation_generation)
	_start_fallback_presentation_timer(petal_id, presentation_generation)

func _start_real_presentation_timer(petal_id: StringName, presentation_generation: int) -> void:
	await get_tree().create_timer(presentation_seconds).timeout
	petal_presentation_terminal(petal_id, presentation_generation, false)

func _start_fallback_presentation_timer(petal_id: StringName, presentation_generation: int) -> void:
	await get_tree().create_timer(fallback_deadline_seconds).timeout
	petal_presentation_terminal(petal_id, presentation_generation, true)

func _reset_active_dwell() -> void:
	if _active_dwell_id == &"":
		return
	var petal_id := _active_dwell_id
	if _records.has(petal_id):
		var record: Dictionary = _records[petal_id]
		if not record.logical_completed:
			record.dwell_elapsed = 0.0
		_records[petal_id] = record
	_active_dwell_id = &""

func _start_hint_timer(source_generation: int, delay: float, level: int) -> void:
	await get_tree().create_timer(delay).timeout
	if state == MeadowState.ACTIVE and source_generation == _hint_generation:
		meadow_hint_requested.emit(level)

func _set_all_petals_enabled(enabled: bool) -> void:
	for petal in _petals.values():
		if petal.has_method("set_acceptance_enabled"):
			petal.set_acceptance_enabled(enabled)

func _complete() -> void:
	if completed:
		return
	completed = true
	armed = false
	state = MeadowState.COMPLETED
	_set_all_petals_enabled(false)
	puzzle_completed.emit(PUZZLE_ID)
	solved.emit()
	var progress := get_node_or_null(progress_controller_path)
	if progress != null and progress.has_method("accept_puzzle_completed"):
		progress.accept_puzzle_completed(PUZZLE_ID)

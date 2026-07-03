class_name PlayfulSparkController
extends Node3D

signal puzzle_completed(puzzle_id: StringName)
signal solved
signal spark_hint_requested(stage_index: int, hint_level: int)
signal spark_hop_started(from_id: StringName, to_id: StringName, generation: int)
signal spark_hop_settled(to_id: StringName, generation: int)

@export var progress_controller_path: NodePath = NodePath("../../../LevelRuntimeRoot/Level03ProgressController")
@export var player_path: NodePath = NodePath("../../../PlayerRoot/Player")
@export var vfx_path: NodePath = NodePath("../../../VFXRoot/Level03PlayfulSparkVFX")
@export var intro_seconds: float = 0.10
@export var pre_glow_seconds: float = 0.55
@export var pre_glow_fallback_seconds: float = 0.70
@export var hop_seconds: float = 0.80
@export var fallback_deadline_seconds: float = 1.20
@export var settle_seconds: float = 0.65
@export var first_hint_seconds: float = 15.0
@export var second_hint_seconds: float = 30.0

const PUZZLE_ID := &"playful_spark"
const ORDER: Array[StringName] = [&"Perch_A", &"Perch_B", &"Perch_C"]
enum SparkState { LOCKED, INTRO, WAITING_FOR_PERCH, PRE_GLOW, HOPPING, SETTLING, COMPLETED }

var state: SparkState = SparkState.LOCKED
var index := 0
var completed := false
var presentation_generation := 0
var accepted_preglow_generation := -1
var accepted_terminal_generation := -1
var _player: Node = null
var _vfx: Node = null
var _perches: Dictionary = {}
var _completed_perches: Array[StringName] = []
var _armed_once := false
var _hint_generation := 0
var _current_from_id: StringName = &""
var _current_to_id: StringName = &""
var _current_from_position := Vector3.ZERO
var _current_to_position := Vector3.ZERO

func _ready() -> void:
	_collect_perches()
	_set_all_perches_enabled(false)

func arm() -> bool:
	if _armed_once or completed or state != SparkState.LOCKED:
		return false
	if not _prepare_runtime_contract():
		return false
	_armed_once = true
	_hint_generation += 1
	state = SparkState.INTRO
	_start_intro(_hint_generation)
	return true

func accept_perch(perch_id: StringName) -> void:
	if state != SparkState.WAITING_FOR_PERCH or completed:
		return
	if index >= ORDER.size() or perch_id != ORDER[index]:
		return
	if _completed_perches.has(perch_id):
		return
	_completed_perches.append(perch_id)
	_set_all_perches_enabled(false)
	presentation_generation += 1
	accepted_preglow_generation = -1
	accepted_terminal_generation = -1
	_current_from_id = ORDER[index]
	_current_from_position = _get_landing_position(_current_from_id)
	if index >= ORDER.size() - 1:
		_hide_destination_telegraph(presentation_generation)
		_complete()
		return
	_current_to_id = ORDER[index + 1]
	_current_to_position = _get_landing_position(_current_to_id)
	state = SparkState.PRE_GLOW
	_start_preglow_sequence(_current_from_id, _current_to_id, presentation_generation)

func clear_occupancy(_perch_id: StringName) -> void:
	# Leave/re-enter persistence: logical stage remains untouched.
	pass

func spark_preglow_terminal(to_id: StringName, generation: int, via_fallback: bool) -> bool:
	if state != SparkState.PRE_GLOW or generation != presentation_generation:
		return false
	if accepted_preglow_generation == generation:
		return false
	if to_id != _current_to_id:
		return false
	accepted_preglow_generation = generation
	_begin_hop(generation, via_fallback)
	return true

func spark_hop_terminal(to_id: StringName, generation: int, via_fallback: bool) -> bool:
	if state != SparkState.HOPPING or generation != presentation_generation:
		return false
	if accepted_terminal_generation == generation:
		return false
	if to_id != _current_to_id:
		return false
	accepted_terminal_generation = generation
	state = SparkState.SETTLING
	_settle_after_delay(to_id, generation, via_fallback)
	return true

func get_state_name() -> StringName:
	return StringName(SparkState.keys()[state])

func get_expected_perch_id() -> StringName:
	if index >= ORDER.size():
		return &""
	return ORDER[index]

func get_completed_perches() -> Array[StringName]:
	return _completed_perches.duplicate()

func _prepare_runtime_contract() -> bool:
	_player = get_node_or_null(player_path)
	_vfx = get_node_or_null(vfx_path)
	if _vfx != null:
		for required_signal in [&"preglow_finished", &"hop_finished"]:
			if not _vfx.has_signal(required_signal):
				return false
		for required_method in [&"show_destination_telegraph", &"hide_destination_telegraph", &"play_preglow", &"play_hop"]:
			if not _vfx.has_method(required_method):
				return false
		if not _vfx.preglow_finished.is_connected(_on_vfx_preglow_finished):
			_vfx.preglow_finished.connect(_on_vfx_preglow_finished)
		if not _vfx.hop_finished.is_connected(_on_vfx_hop_finished):
			_vfx.hop_finished.connect(_on_vfx_hop_finished)
	if _player == null:
		return false
	_collect_perches()
	for id in ORDER:
		if not _perches.has(id):
			return false
		var perch: Node = _perches[id]
		if not perch.has_method("register_player") or not perch.has_method("set_acceptance_enabled") or not perch.has_method("reevaluate_registered_player_overlap") or not perch.has_method("get_landing_world_position"):
			return false
		perch.register_player(_player)
		if perch.get_landing_world_position() == Vector3.INF:
			return false
	return true

func _collect_perches() -> void:
	_perches.clear()
	for child in get_children():
		if child.has_method("register_player") and child.has_signal("perch_entered"):
			_perches[child.perch_id] = child

func _start_intro(source_generation: int) -> void:
	await get_tree().create_timer(intro_seconds).timeout
	if state != SparkState.INTRO or source_generation != _hint_generation:
		return
	state = SparkState.WAITING_FOR_PERCH
	_enable_expected_perch()
	_show_destination_telegraph(ORDER[index], presentation_generation)
	_start_hint_timer(source_generation, first_hint_seconds, 1)
	_start_hint_timer(source_generation, second_hint_seconds, 2)

func _start_hint_timer(source_generation: int, delay: float, level: int) -> void:
	await get_tree().create_timer(delay).timeout
	if completed or state == SparkState.LOCKED or source_generation != _hint_generation:
		return
	spark_hint_requested.emit(index, level)

func _start_preglow_sequence(from_id: StringName, to_id: StringName, generation: int) -> void:
	_show_destination_telegraph(to_id, generation)
	_start_vfx_preglow(from_id, to_id, generation)
	_start_preglow_fallback_timer(to_id, generation)

func _start_vfx_preglow(from_id: StringName, to_id: StringName, generation: int) -> bool:
	if _vfx == null or not _vfx.has_method("play_preglow"):
		return false
	return _vfx.play_preglow(from_id, to_id, generation, _current_from_position, _current_to_position, pre_glow_seconds)

func _on_vfx_preglow_finished(_from_id: StringName, to_id: StringName, generation: int) -> void:
	spark_preglow_terminal(to_id, generation, false)

func _start_preglow_fallback_timer(to_id: StringName, generation: int) -> void:
	await get_tree().create_timer(pre_glow_fallback_seconds).timeout
	spark_preglow_terminal(to_id, generation, true)

func _begin_hop(generation: int, _via_fallback: bool) -> void:
	if state != SparkState.PRE_GLOW or generation != presentation_generation:
		return
	state = SparkState.HOPPING
	spark_hop_started.emit(_current_from_id, _current_to_id, generation)
	_start_vfx_hop(_current_from_id, _current_to_id, generation)
	_start_hop_fallback_timer(_current_to_id, generation)

func _start_vfx_hop(from_id: StringName, to_id: StringName, generation: int) -> bool:
	if _vfx == null or not _vfx.has_method("play_hop"):
		return false
	return _vfx.play_hop(from_id, to_id, generation, _current_from_position, _current_to_position, hop_seconds)

func _on_vfx_hop_finished(_from_id: StringName, to_id: StringName, generation: int) -> void:
	spark_hop_terminal(to_id, generation, false)

func _start_hop_fallback_timer(to_id: StringName, generation: int) -> void:
	await get_tree().create_timer(fallback_deadline_seconds).timeout
	spark_hop_terminal(to_id, generation, true)

func _settle_after_delay(to_id: StringName, generation: int, _via_fallback: bool) -> void:
	await get_tree().create_timer(settle_seconds).timeout
	if state != SparkState.SETTLING or generation != presentation_generation:
		return
	spark_hop_settled.emit(to_id, generation)
	index += 1
	if index >= ORDER.size():
		_complete()
		return
	state = SparkState.WAITING_FOR_PERCH
	_enable_expected_perch()
	_show_destination_telegraph(ORDER[index], generation)
	_defer_expected_overlap_reevaluation(ORDER[index], generation)

func _defer_expected_overlap_reevaluation(expected_id: StringName, source_generation: int) -> void:
	await get_tree().physics_frame
	if completed or state != SparkState.WAITING_FOR_PERCH or source_generation != presentation_generation or index >= ORDER.size() or ORDER[index] != expected_id:
		return
	var perch: Node = _perches.get(expected_id)
	if perch != null and perch.has_method("reevaluate_registered_player_overlap"):
		perch.reevaluate_registered_player_overlap()

func _enable_expected_perch() -> void:
	_set_all_perches_enabled(false)
	if index < ORDER.size():
		var perch: Node = _perches.get(ORDER[index])
		if perch != null:
			perch.set_acceptance_enabled(true)

func _set_all_perches_enabled(enabled: bool) -> void:
	for perch in _perches.values():
		if perch.has_method("set_acceptance_enabled"):
			perch.set_acceptance_enabled(enabled)

func _show_destination_telegraph(perch_id: StringName, generation: int) -> void:
	if _vfx == null or not _vfx.has_method("show_destination_telegraph"):
		return
	_vfx.show_destination_telegraph(perch_id, _get_landing_position(perch_id), generation)

func _hide_destination_telegraph(generation: int) -> void:
	if _vfx != null and _vfx.has_method("hide_destination_telegraph"):
		_vfx.hide_destination_telegraph(generation)

func _get_landing_position(perch_id: StringName) -> Vector3:
	var perch: Node = _perches.get(perch_id)
	if perch == null or not perch.has_method("get_landing_world_position"):
		return Vector3.INF
	return perch.get_landing_world_position()

func _complete() -> void:
	if completed:
		return
	completed = true
	state = SparkState.COMPLETED
	_hide_destination_telegraph(presentation_generation)
	_set_all_perches_enabled(false)
	puzzle_completed.emit(PUZZLE_ID)
	solved.emit()
	var progress := get_node_or_null(progress_controller_path)
	if progress != null and progress.has_method("accept_puzzle_completed"):
		progress.accept_puzzle_completed(PUZZLE_ID)

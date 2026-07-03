extends Node
class_name TrialBController

signal trial_completed(trial_id: StringName)
signal stage_completed(stage: int)
signal assistance_requested(message: String)
signal sequence_presented(stage: int)

@export var shard_slot_path: NodePath
@export var display_duration := 0.65
@export var display_gap := 0.25
const SEQUENCE: Array[StringName] = [&"leaf", &"sun", &"wave", &"star"]
enum TrialBState { INERT, SHOWING_SEQUENCE, WAITING_FOR_INPUT, COMPLETED }
var armed := false
var completed := false
var stage := 1
var input: Array[StringName] = []
var failures := 0
var presenting := false
var completed_stages: Dictionary = {}
var pads: Dictionary = {}
var state := TrialBState.INERT
var presentation_generation := 0
var completion_count := 0
var shard_reveal_count := 0

func commit_domain() -> void:
	arm()

func arm() -> void:
	if completed:
		return
	armed = true
	_register_pads()
	_begin_presentation()

func disarm() -> void:
	armed = false
	state = TrialBState.INERT
	presenting = false
	presentation_generation += 1
	for pad in pads.values():
		pad.disarm()

func validate_pad_registry() -> bool:
	var expected: Array[StringName] = [&"leaf", &"sun", &"wave", &"star"]
	var found: Dictionary = {}
	for child in get_children():
		if not (child.name in ["Leaf", "Sun", "Wave", "Star"]):
			continue
		if not child.has_signal("pad_pressed"):
			return false
		if not child.has_method("arm") or not child.has_method("disarm") or not child.has_method("interact"):
			return false
		var child_id: Variant = child.get("pad_id")
		if not (child_id in expected):
			return false
		if found.has(child_id):
			return false
		found[child_id] = child
	return found.size() == expected.size()

func _register_pads() -> void:
	pads.clear()
	if not validate_pad_registry():
		push_error("Trial B pad registry is invalid.")
		return
	for child in get_children():
		if not (child.name in ["Leaf", "Sun", "Wave", "Star"]):
			continue
		var child_id: StringName = child.get("pad_id")
		pads[child_id] = child
		var c := Callable(self, "_on_pad")
		if not child.is_connected("pad_pressed", c):
			child.pad_pressed.connect(c)

func _begin_presentation() -> void:
	if not armed or completed:
		return
	presentation_generation += 1
	var generation := presentation_generation
	presenting = true
	state = TrialBState.SHOWING_SEQUENCE
	_set_pads_armed(false)
	_present_sequence_async(generation)

func _present_sequence_async(generation: int) -> void:
	await get_tree().create_timer((display_duration + display_gap) * float(stage)).timeout
	if generation != presentation_generation or not armed or completed or state != TrialBState.SHOWING_SEQUENCE:
		return
	presenting = false
	state = TrialBState.WAITING_FOR_INPUT
	_set_pads_armed(true)
	sequence_presented.emit(stage)

func _set_pads_armed(value: bool) -> void:
	for pad in pads.values():
		if value:
			pad.arm()
		else:
			pad.disarm()

func _on_pad(pad_id: StringName) -> void:
	if not armed or completed or state != TrialBState.WAITING_FOR_INPUT:
		return
	input.append(pad_id)
	var expected := SEQUENCE[input.size() - 1]
	if pad_id != expected:
		failures += 1
		input.clear()
		if failures == 2:
			assistance_requested.emit("Сначала лист, потом солнце")
		elif failures >= 3:
			assistance_requested.emit("Путь света: лист, солнце, волна, звезда")
		_begin_presentation()
		return
	if input.size() == stage:
		completed_stages[stage] = true
		stage_completed.emit(stage)
		input.clear()
		if stage >= 4:
			_complete_trial()
		else:
			stage += 1
			_begin_presentation()

func _complete_trial() -> void:
	if completed:
		return
	completed = true
	armed = false
	presenting = false
	state = TrialBState.COMPLETED
	presentation_generation += 1
	_set_pads_armed(false)
	completion_count += 1
	var slot := get_node_or_null(shard_slot_path)
	if slot and slot.has_method("reveal"):
		shard_reveal_count += 1
		slot.reveal()
	trial_completed.emit(&"trial_b")

func replay() -> void:
	if not armed or completed:
		return
	if state == TrialBState.SHOWING_SEQUENCE:
		return
	_begin_presentation()

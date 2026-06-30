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
var armed := false
var completed := false
var stage := 1
var input: Array[StringName] = []
var failures := 0
var presenting := false
var completed_stages: Dictionary = {}
var pads: Dictionary = {}

func commit_domain() -> void:
	arm()

func arm() -> void:
	armed = true
	_register_pads()
	_present_sequence()

func disarm() -> void:
	armed = false
	for pad in pads.values():
		if pad.has_method("disarm"):
			pad.disarm()

func _register_pads() -> void:
	pads.clear()
	for child in get_children():
		if child is TrialBSymbolPad:
			pads[child.pad_id] = child
			var c := Callable(self, "_on_pad")
			if not child.is_connected("pad_pressed", c):
				child.pad_pressed.connect(c)

func _present_sequence() -> void:
	presenting = true
	_set_pads_armed(false)
	await get_tree().create_timer((display_duration + display_gap) * float(stage)).timeout
	presenting = false
	_set_pads_armed(true)
	sequence_presented.emit(stage)

func _set_pads_armed(value: bool) -> void:
	for pad in pads.values():
		if value and pad.has_method("arm"):
			pad.arm()
		elif not value and pad.has_method("disarm"):
			pad.disarm()

func _on_pad(pad_id: StringName) -> void:
	if not armed or completed or presenting:
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
		_present_sequence()
		return
	if input.size() == stage:
		completed_stages[stage] = true
		stage_completed.emit(stage)
		input.clear()
		if stage >= 4:
			completed = true
			_set_pads_armed(false)
			var slot := get_node_or_null(shard_slot_path)
			if slot and slot.has_method("reveal"):
				slot.reveal()
			trial_completed.emit(&"trial_b")
		else:
			stage += 1
			_present_sequence()

func replay() -> void:
	if armed and not completed:
		_present_sequence()

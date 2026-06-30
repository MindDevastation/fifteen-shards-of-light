extends Node
class_name TrialBController
signal trial_completed
signal stage_completed(stage: int)
signal assistance_requested(message: String)
@export var shard_slot_path: NodePath
const SEQUENCE: Array[StringName] = [&"Leaf", &"Sun", &"Wave", &"Star"]
var armed := false
var completed := false
var stage := 1
var input: Array[StringName] = []
var failures := 0
func arm() -> void:
	armed = true
	for child in get_children():
		if child.has_method("arm"): child.arm()
		if child.has_signal("pad_pressed"): child.pad_pressed.connect(_on_pad)
func _on_pad(pad_id: StringName) -> void:
	if not armed or completed: return
	input.append(pad_id)
	var expected := SEQUENCE[input.size() - 1]
	if pad_id != expected:
		failures += 1; input.clear()
		if failures >= 2: assistance_requested.emit("Следуй живому свету: Leaf, Sun, Wave, Star")
		return
	if input.size() == stage:
		stage_completed.emit(stage)
		input.clear()
		if stage >= 4:
			completed = true
			var slot := get_node_or_null(shard_slot_path)
			if slot and slot.has_method("reveal"): slot.reveal()
			trial_completed.emit()
		else: stage += 1
func replay() -> Array[StringName]: return SEQUENCE.slice(0, stage)

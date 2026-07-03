extends Node
class_name TrialAController

signal trial_completed(trial_id: StringName)
signal assistance_requested(message: String)

@export var shard_slot_path: NodePath
@export var assistance_thresholds: PackedFloat32Array = [12.0, 24.0, 36.0]
var armed := false
var completed := false
var locked: Dictionary = {}
var _elapsed := 0.0
var _assistance_index := 0

func _process(delta: float) -> void:
	if not armed or completed:
		return
	_elapsed += delta
	if _assistance_index < assistance_thresholds.size() and _elapsed >= assistance_thresholds[_assistance_index]:
		_assistance_index += 1
		assistance_requested.emit("Каждый луч находит покой в среднем положении")

func commit_domain() -> void:
	arm()

func arm() -> void:
	armed = true
	for child in get_children():
		if child.has_method("arm"):
			child.arm()
		if child.has_signal("locked"):
			var c := Callable(self, "_on_locked")
			if not child.is_connected("locked", c):
				child.locked.connect(c)

func disarm() -> void:
	armed = false
	for child in get_children():
		if child.has_method("disarm"):
			child.disarm()

func _on_locked(statue_id: StringName) -> void:
	if not armed or completed:
		return
	locked[statue_id] = true
	if locked.size() == 3:
		completed = true
		var slot := get_node_or_null(shard_slot_path)
		if slot and slot.has_method("reveal"):
			slot.reveal()
		trial_completed.emit(&"trial_a")

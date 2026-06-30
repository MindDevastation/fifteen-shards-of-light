extends Node
class_name TrialAController
signal trial_completed
signal assistance_requested(message: String)
@export var shard_slot_path: NodePath
var armed := false
var completed := false
var locked: Dictionary = {}
func arm() -> void:
	armed = true
	for child in get_children():
		if child.has_method("arm"):
			child.arm()
		if child.has_signal("locked"):
			child.locked.connect(_on_locked)
func _on_locked(statue_id: StringName) -> void:
	if not armed or completed: return
	locked[statue_id] = true
	if locked.size() == 3:
		completed = true
		var slot := get_node_or_null(shard_slot_path)
		if slot and slot.has_method("reveal"): slot.reveal()
		trial_completed.emit()

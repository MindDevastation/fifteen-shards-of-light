extends Node
class_name Level02ProgressController

signal both_shards_admitted
signal final_ready
signal finale_requested
signal portal_unlock_requested

var armed := false
var trial_a_complete := false
var trial_b_complete := false
var admitted: Dictionary = {}
var fog_ready := false
var center_present := false
var final_started := false

func arm() -> void:
	armed = true
	_check_final()

func set_trial_complete(trial_id: StringName) -> void:
	if trial_id == &"TrialA": trial_a_complete = true
	if trial_id == &"TrialB": trial_b_complete = true

func admitted_shard_collected(shard_id: StringName) -> void:
	if not armed: return
	admitted[shard_id] = true
	if admitted.size() >= 2:
		both_shards_admitted.emit()
	_check_final()

func notify_fog_ready() -> void:
	fog_ready = true
	_check_final()

func set_center_present(value: bool) -> void:
	center_present = value
	_check_final()

func _check_final() -> void:
	if armed and not final_started and admitted.size() >= 2 and fog_ready and center_present:
		final_started = true
		final_ready.emit()
		finale_requested.emit()
		portal_unlock_requested.emit()

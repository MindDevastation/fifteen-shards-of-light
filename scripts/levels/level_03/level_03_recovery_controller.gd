class_name Level03RecoveryController
extends Node

signal recovery_started(anchor_id: StringName)
signal recovery_completed(anchor_id: StringName)

@export var player_path: NodePath = NodePath("../../PlayerRoot/Player")
@export var fade_overlay_path: NodePath = NodePath("../../UILayer/RecoveryFadeOverlay")
@export var debug_enabled: bool = false

const ANCHORS := {
	&"RA0": Vector3(-6.0, 0.65, -49.0),
	&"RA1": Vector3(-3.5, 1.45, -23.5),
	&"RA2": Vector3(-8.0, 1.55, -16.0),
	&"RA3": Vector3(7.0, 1.65, -3.0),
	&"RA4": Vector3(-4.0, 1.93, 18.0),
	&"RA5": Vector3(-7.0, 1.95, 28.5),
	&"RA6": Vector3(6.0, 2.25, 47.0),
}

var current_anchor: StringName = &"RA0"
var suspended_sources: Dictionary = {}

func set_current_anchor(anchor_id: StringName) -> bool:
	if not ANCHORS.has(anchor_id):
		return false
	current_anchor = anchor_id
	return true

func suspend_recovery(source_id: StringName, suspended: bool) -> void:
	if suspended:
		suspended_sources[source_id] = true
	else:
		suspended_sources.erase(source_id)

func can_recover() -> bool:
	return suspended_sources.is_empty()

func recover_to_current_anchor() -> bool:
	return recover_to_anchor(current_anchor)

func recover_to_anchor(anchor_id: StringName) -> bool:
	if not can_recover() or not ANCHORS.has(anchor_id):
		return false
	var player := get_node_or_null(player_path) as Node3D
	if player == null:
		return false
	recovery_started.emit(anchor_id)
	player.global_position = ANCHORS[anchor_id]
	if "velocity" in player:
		player.velocity = Vector3.ZERO
	current_anchor = anchor_id
	recovery_completed.emit(anchor_id)
	return true

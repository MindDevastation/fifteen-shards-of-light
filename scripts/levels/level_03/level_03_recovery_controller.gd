class_name Level03RecoveryController
extends Node

signal recovery_started(anchor_id: StringName)
signal recovery_completed(anchor_id: StringName)

@export var player_path: NodePath = NodePath("../../PlayerRoot/Player")
@export var fade_overlay_path: NodePath = NodePath("../../UILayer/RecoveryFadeOverlay")
@export var recovery_anchor_root_path: NodePath = NodePath("../../MarkerRoot/RecoveryAnchors")
@export var fade_duration: float = 0.30
@export var reentry_cooldown_seconds: float = 0.25
@export var debug_enabled: bool = false

const SUSPEND_SHARD_REWARD := &"shard_reward"
const SUSPEND_MAIN_TEXT := &"main_text"
const ANCHOR_NAMES := [&"RA0", &"RA1", &"RA2", &"RA3", &"RA4", &"RA5", &"RA6"]

var current_anchor: StringName = &"RA0"
var suspended_sources: Dictionary = {}
var pending_volume_id: StringName = &""
var active_invalid_volumes: Dictionary = {}
var recovery_generation := 0
var recovering := false
var cooldown_until_msec := 0

func set_current_anchor(anchor_id: StringName) -> bool:
	if not ANCHOR_NAMES.has(anchor_id): return false
	current_anchor = anchor_id
	return true

func suspend_recovery(source_id: StringName, suspended: bool) -> void:
	if not [SUSPEND_SHARD_REWARD, SUSPEND_MAIN_TEXT].has(source_id): return
	if suspended:
		suspended_sources[source_id] = true
	else:
		suspended_sources.erase(source_id)
		if pending_volume_id != &"" and can_recover() and active_invalid_volumes.has(pending_volume_id):
			var volume := pending_volume_id
			pending_volume_id = &""
			request_recovery(current_anchor, volume)

func can_recover() -> bool:
	return suspended_sources.is_empty() and not recovering

func notify_volume_entered(volume_id: StringName, anchor_id: StringName) -> bool:
	active_invalid_volumes[volume_id] = true
	return request_recovery(anchor_id, volume_id)

func notify_volume_exited(volume_id: StringName) -> void:
	active_invalid_volumes.erase(volume_id)
	if pending_volume_id == volume_id:
		pending_volume_id = &""

func request_recovery(anchor_id: StringName = &"", volume_id: StringName = &"explicit") -> bool:
	if Time.get_ticks_msec() < cooldown_until_msec: return false
	if anchor_id != &"" and ANCHOR_NAMES.has(anchor_id): current_anchor = anchor_id
	if not can_recover():
		pending_volume_id = volume_id
		return false
	if volume_id != &"explicit" and not active_invalid_volumes.has(volume_id): return false
	recovery_generation += 1
	_run_recovery(recovery_generation, current_anchor, volume_id)
	return true

func _run_recovery(generation: int, anchor_id: StringName, volume_id: StringName) -> void:
	recovering = true
	recovery_started.emit(anchor_id)
	var fade := get_node_or_null(fade_overlay_path) as CanvasItem
	if fade != null: fade.visible = true
	await get_tree().create_timer(fade_duration).timeout
	if generation != recovery_generation: return
	if volume_id != &"explicit" and not active_invalid_volumes.has(volume_id):
		_finish_cancelled(fade)
		return
	var player := get_node_or_null(player_path) as Node3D
	var marker := _get_anchor_marker(anchor_id)
	if player == null or marker == null:
		_finish_cancelled(fade)
		return
	player.global_position = marker.global_position
	if "velocity" in player: player.velocity = Vector3.ZERO
	await get_tree().create_timer(fade_duration).timeout
	if fade != null: fade.visible = false
	recovering = false
	cooldown_until_msec = Time.get_ticks_msec() + int(reentry_cooldown_seconds * 1000.0)
	recovery_completed.emit(anchor_id)

func _finish_cancelled(fade: CanvasItem) -> void:
	if fade != null: fade.visible = false
	recovering = false

func _get_anchor_marker(anchor_id: StringName) -> Marker3D:
	var root := get_node_or_null(recovery_anchor_root_path)
	if root == null: return null
	return root.get_node_or_null(String(anchor_id)) as Marker3D

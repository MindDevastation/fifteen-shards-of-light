extends Node
class_name Level01FinaleController

signal finale_armed
signal finale_started
signal finale_completed

enum FinaleState { LOCKED, ARMED, REVEALING_LANDMARK, ACTIVATING_PORTAL, PORTAL_READY, SHOWING_FINAL_TEXT, TRANSITIONING, COMPLETE }

@export var progression_controller_path: NodePath
@export var player_path: NodePath
@export var trigger_area_path: NodePath
@export var trigger_collision_path: NodePath
@export var approach_marker_path: NodePath
@export var light_column_path: NodePath
@export var finale_overlay_path: NodePath
@export var portal_path: NodePath
@export var minimum_entry_height: float = 0.5
@export_range(-1.0, 1.0, 0.01) var minimum_approach_dot: float = 0.25
@export var finale_text: String = "Первый свет открыл дорогу дальше.\nПусть каждый следующий шаг будет мягче."

var _state := FinaleState.LOCKED
var _progression_controller: Node
var _player: Node3D
var _trigger_area: Area3D
var _trigger_collision: CollisionShape3D
var _approach_marker: Node3D
var _light_column: Node
var _finale_overlay: Node
var _portal: Node
var _configuration_valid := false
var _started_once := false
var _controls_locked_by_finale := false
var _pending_entry_player: Node

func _ready() -> void:
	_configuration_valid = _configure()
	_set_trigger_enabled(false)

func is_armed() -> bool:
	return _state == FinaleState.ARMED

func has_started() -> bool:
	return _started_once

func _configure() -> bool:
	_progression_controller = get_node_or_null(progression_controller_path)
	_player = get_node_or_null(player_path) as Node3D
	_trigger_area = get_node_or_null(trigger_area_path) as Area3D
	_trigger_collision = get_node_or_null(trigger_collision_path) as CollisionShape3D
	_approach_marker = get_node_or_null(approach_marker_path) as Node3D
	_light_column = get_node_or_null(light_column_path)
	_finale_overlay = get_node_or_null(finale_overlay_path)
	_portal = get_node_or_null(portal_path)
	if _progression_controller == null or not _progression_controller.has_signal(&"barrier_opened"):
		push_error("Level01FinaleController requires progression_controller_path with barrier_opened signal.")
		return false
	if _player == null or _trigger_area == null or _trigger_collision == null or _approach_marker == null:
		push_error("Level01FinaleController missing required player, trigger, collision, or approach marker path.")
		return false
	if _portal == null:
		push_error("Level01FinaleController requires portal_path.")
		return false
	_progression_controller.barrier_opened.connect(_on_barrier_opened)
	_trigger_area.body_entered.connect(_on_trigger_body_entered)
	if _portal.has_signal(&"entry_confirmation_requested"):
		_portal.entry_confirmation_requested.connect(_on_portal_entry_confirmation_requested)
	if _portal.has_signal(&"activation_completed"):
		_portal.activation_completed.connect(_on_portal_activation_completed)
	if _portal.has_signal(&"transition_failed"):
		_portal.transition_failed.connect(_on_portal_transition_failed)
	if _portal.has_signal(&"transition_completed"):
		_portal.transition_completed.connect(_on_portal_transition_completed)
	return true

func _on_barrier_opened() -> void:
	if not _configuration_valid or _state != FinaleState.LOCKED:
		return
	_state = FinaleState.ARMED
	_set_trigger_enabled(true)
	finale_armed.emit()

func _on_trigger_body_entered(body: Node3D) -> void:
	if body != _player:
		return
	_attempt_start_finale()

func _attempt_start_finale() -> void:
	if not _configuration_valid or _state != FinaleState.ARMED or _started_once:
		return
	if not _passes_height_gate() or not _passes_approach_gate():
		return
	_started_once = true
	_state = FinaleState.REVEALING_LANDMARK
	_set_trigger_enabled(false)
	finale_started.emit()
	_start_landmark_reveal()

func _start_landmark_reveal() -> void:
	if _light_column != null and _light_column.has_signal(&"appearance_completed") and _light_column.has_method("appear"):
		_light_column.appearance_completed.connect(_on_light_column_appearance_completed, CONNECT_ONE_SHOT)
		_light_column.call("appear")
		return
	_on_light_column_appearance_completed()

func _on_light_column_appearance_completed() -> void:
	if _state != FinaleState.REVEALING_LANDMARK:
		_recover_to_portal_ready()
		return
	_state = FinaleState.ACTIVATING_PORTAL
	if _portal != null and _portal.has_method("activate"):
		_portal.call("activate")
		return
	_recover_to_portal_ready()

func _on_portal_activation_completed() -> void:
	if _state != FinaleState.ACTIVATING_PORTAL:
		return
	_state = FinaleState.PORTAL_READY

func _on_portal_entry_confirmation_requested(player: Node) -> void:
	if _state != FinaleState.PORTAL_READY or player != _player:
		_cancel_portal_confirmation(player)
		return
	_pending_entry_player = player
	_state = FinaleState.SHOWING_FINAL_TEXT
	_lock_controls_for_finale()
	var opened := false
	if _finale_overlay != null and _finale_overlay.has_signal(&"closed") and _finale_overlay.has_method("show_finale_text"):
		if not _finale_overlay.closed.is_connected(_on_finale_overlay_closed):
			_finale_overlay.closed.connect(_on_finale_overlay_closed, CONNECT_ONE_SHOT)
		opened = bool(_finale_overlay.call("show_finale_text", finale_text))
	if not opened:
		_disconnect_finale_overlay_closed()
		_recover_to_portal_ready()

func _disconnect_finale_overlay_closed() -> void:
	if _finale_overlay != null and _finale_overlay.has_signal(&"closed") and _finale_overlay.closed.is_connected(_on_finale_overlay_closed):
		_finale_overlay.closed.disconnect(_on_finale_overlay_closed)

func _on_finale_overlay_closed() -> void:
	if _state != FinaleState.SHOWING_FINAL_TEXT:
		_recover_to_portal_ready()
		return
	_state = FinaleState.TRANSITIONING
	if _portal != null and _portal.has_method("continue_entry_after_confirmation") and _pending_entry_player != null:
		_portal.call("continue_entry_after_confirmation", _pending_entry_player)
		return
	_recover_to_portal_ready()

func _on_portal_transition_failed(player: Node, _error_code: int) -> void:
	if player != _pending_entry_player and player != _player:
		return
	_recover_to_portal_ready()

func _on_portal_transition_completed() -> void:
	if _state != FinaleState.TRANSITIONING:
		return
	_state = FinaleState.COMPLETE
	_controls_locked_by_finale = false
	_pending_entry_player = null
	finale_completed.emit()

func _recover_to_portal_ready() -> void:
	_unlock_controls_if_owned()
	if _pending_entry_player != null:
		_cancel_portal_confirmation(_pending_entry_player)
	elif _player != null:
		_cancel_portal_confirmation(_player)
	_pending_entry_player = null
	if _started_once:
		_state = FinaleState.PORTAL_READY
	else:
		_state = FinaleState.ARMED
		_set_trigger_enabled(true)

func _cancel_portal_confirmation(player: Node) -> void:
	if _portal != null and _portal.has_method("cancel_entry_confirmation"):
		_portal.call("cancel_entry_confirmation", player)

func _lock_controls_for_finale() -> void:
	if _controls_locked_by_finale:
		return
	_set_player_controls(false)
	_controls_locked_by_finale = true

func _unlock_controls_if_owned() -> void:
	if not _controls_locked_by_finale:
		return
	_set_player_controls(true)
	_controls_locked_by_finale = false

func _passes_height_gate() -> bool:
	return _player.global_position.y >= _approach_marker.global_position.y + minimum_entry_height

func _passes_approach_gate() -> bool:
	var to_player := (_player.global_position - _approach_marker.global_position)
	to_player.y = 0.0
	if to_player.length_squared() <= 0.0001:
		return false
	var forward := -_approach_marker.global_transform.basis.z
	forward.y = 0.0
	return forward.normalized().dot(to_player.normalized()) >= minimum_approach_dot

func _set_trigger_enabled(enabled: bool) -> void:
	if _trigger_area != null:
		_trigger_area.set_deferred("monitoring", enabled)
		_trigger_area.set_deferred("monitorable", enabled)
	if _trigger_collision != null:
		_trigger_collision.set_deferred("disabled", not enabled)

func _set_player_controls(enabled: bool) -> void:
	if _player != null and _player.has_method("set_controls_enabled"):
		_player.call("set_controls_enabled", enabled)

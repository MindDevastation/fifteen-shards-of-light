extends Node
class_name Level04FinaleController

signal main_text_started(text_id)
signal main_text_closed(text_id)
signal configuration_error(component, message)

const MAIN_TEXT_ID := &"LEVEL_04_MAIN_TEXT"
const SUSPENSION_MAIN_TEXT := &"main_text"
const LOCKED_MAIN_TEXT := "Сначала я думал, что жду наших разговоров ради твоего голоса и смеха. Потом понял, что мне дороги и те минуты, когда ты серьёзна, говоришь прямо или между нами просто становится тихо. Я скучаю не только по лёгким разговорам. Я скучаю по тебе - и поэтому в памяти остаются даже маленькие вещи."

@export var player_path := NodePath("../../PlayerRoot/Player")
@export var final_text_gate_path := NodePath("../../GameplayRoot/RouteAuthorityRoot/FinalTextGate")
@export var finale_overlay_path := NodePath("../../UILayer/LevelFinaleOverlay")
@export var recovery_controller_path := NodePath("../Level04RecoveryController")
@export var main_text_id: StringName = &"LEVEL_04_MAIN_TEXT"
@export_multiline var main_text: String = LOCKED_MAIN_TEXT

var _armed := false
var _player_inside_gate := false
var _showing_text := false
var _main_text_complete := false
var _started_emitted := false
var _closed_emitted := false
var _owns_player_lock := false
var _owns_recovery_suspension := false
var _last_error_component: StringName = &""
var _last_error_message := ""
var _overlay_connected := false


func _ready() -> void:
	_wire_overlay_close_signal()


func arm_finale() -> bool:
	if _armed:
		call_deferred("_reevaluate_gate_after_arm")
		return true
	if not debug_validate_configuration():
		_release_owned_locks()
		return false
	_armed = true
	_wire_overlay_close_signal()
	call_deferred("_reevaluate_gate_after_arm")
	return true


func disarm_finale() -> void:
	_armed = false
	if not _showing_text:
		_release_owned_locks()


func is_armed() -> bool:
	return _armed


func is_showing_text() -> bool:
	return _showing_text


func report_gate_presence(inside: bool) -> void:
	_player_inside_gate = inside
	_reevaluate_gate_after_arm()


func debug_validate_configuration() -> bool:
	var ok := true
	if main_text_id != MAIN_TEXT_ID:
		_emit_configuration_error(&"Level04FinaleController", "main text ID mismatch")
		ok = false
	if main_text != LOCKED_MAIN_TEXT:
		_emit_configuration_error(&"Level04FinaleController", "main text literal mismatch")
		ok = false
	var player := _player()
	if player == null or not player.has_method(&"set_controls_enabled"):
		_emit_configuration_error(&"Level04FinaleController", "Player set_controls_enabled API missing")
		ok = false
	var gate := _gate()
	if gate == null or not gate.is_class("Area3D"):
		_emit_configuration_error(&"Level04FinaleController", "FinalTextGate Area3D missing")
		ok = false
	var overlay := _overlay()
	if overlay == null or not overlay.has_method(&"show_finale_text") or not overlay.has_signal(&"closed"):
		_emit_configuration_error(&"Level04FinaleController", "LevelFinaleOverlay API missing")
		ok = false
	var recovery := _recovery()
	if recovery == null or not recovery.has_method(&"add_suspension_source") or not recovery.has_method(&"remove_suspension_source"):
		_emit_configuration_error(&"Level04FinaleController", "Recovery suspension API missing")
		ok = false
	return ok


func debug_force_overlay_close() -> void:
	_on_finale_overlay_closed()


func request_debug_snapshot() -> Dictionary:
	return {
		"armed": _armed,
		"player_inside_gate": _player_inside_gate,
		"showing_text": _showing_text,
		"main_text_complete": _main_text_complete,
		"started_emitted": _started_emitted,
		"closed_emitted": _closed_emitted,
		"main_text_id": main_text_id,
		"main_text_exact": main_text == LOCKED_MAIN_TEXT,
		"owns_player_lock": _owns_player_lock,
		"owns_recovery_suspension": _owns_recovery_suspension,
		"last_error_component": _last_error_component,
		"last_error_message": _last_error_message,
	}


func _on_final_text_gate_body_entered(body: Node) -> void:
	if body == _player():
		report_gate_presence(true)


func _on_final_text_gate_body_exited(body: Node) -> void:
	if body == _player():
		report_gate_presence(false)


func _reevaluate_gate_after_arm() -> void:
	if not _armed or _showing_text or _main_text_complete or not _player_inside_gate:
		return
	_start_main_text_fail_closed()


func _start_main_text_fail_closed() -> void:
	if not debug_validate_configuration():
		_release_owned_locks()
		return
	var overlay := _overlay()
	var accepted := bool(overlay.call(&"show_finale_text", main_text))
	if not accepted:
		_release_owned_locks()
		_emit_configuration_error(&"Level04FinaleController", "LevelFinaleOverlay rejected main text")
		return
	var player := _player()
	player.call(&"set_controls_enabled", false)
	_owns_player_lock = true
	var recovery := _recovery()
	recovery.call(&"add_suspension_source", SUSPENSION_MAIN_TEXT)
	_owns_recovery_suspension = true
	_showing_text = true
	if not _started_emitted:
		_started_emitted = true
		main_text_started.emit(main_text_id)


func _on_finale_overlay_closed() -> void:
	if not _showing_text or _closed_emitted:
		return
	_closed_emitted = true
	_showing_text = false
	_main_text_complete = true
	_release_owned_locks()
	main_text_closed.emit(main_text_id)


func _wire_overlay_close_signal() -> void:
	var overlay := _overlay()
	if overlay == null or not overlay.has_signal(&"closed"):
		return
	if not overlay.is_connected(&"closed", _on_finale_overlay_closed):
		overlay.connect(&"closed", _on_finale_overlay_closed)
	_overlay_connected = true


func _release_owned_locks() -> void:
	if _owns_player_lock:
		var player := _player()
		if player != null and player.has_method(&"set_controls_enabled"):
			player.call(&"set_controls_enabled", true)
		_owns_player_lock = false
	if _owns_recovery_suspension:
		var recovery := _recovery()
		if recovery != null and recovery.has_method(&"remove_suspension_source"):
			recovery.call(&"remove_suspension_source", SUSPENSION_MAIN_TEXT)
		_owns_recovery_suspension = false


func _player() -> Node:
	return get_node_or_null(player_path)


func _gate() -> Node:
	return get_node_or_null(final_text_gate_path)


func _overlay() -> Node:
	return get_node_or_null(finale_overlay_path)


func _recovery() -> Node:
	return get_node_or_null(recovery_controller_path)


func _emit_configuration_error(component: StringName, message: String) -> void:
	_last_error_component = component
	_last_error_message = message
	push_error("%s: %s" % [String(component), message])
	configuration_error.emit(component, message)

class_name Level03FinaleController
extends Node

signal finale_armed
signal finale_completed

enum FinaleState { UNARMED, WAITING_FOR_PRESENCE, SYNTHESIS_ACTIVE, MAIN_TEXT_ACTIVE, COMPLETED }

@export var progress_controller_path: NodePath = NodePath("../Level03ProgressController")
@export var overlay_path: NodePath = NodePath("../../UILayer/LevelFinaleOverlay")
@export var player_path: NodePath = NodePath("../../PlayerRoot/Player")
@export var environment_state_path: NodePath = NodePath("../../EnvironmentStateRoot")
@export var portal_adapter_path: NodePath = NodePath("../Level03PortalAdapter")
@export var recovery_controller_path: NodePath = NodePath("../Level03RecoveryController")
@export var synthesis_duration: float = 0.35
@export_multiline var main_text: String = "Сначала я просто заметил, что жду наших разговоров. Потом понял, что после них ещё долго вспоминаю твою интонацию, а когда ты внезапно смеёшься над какой-нибудь ерундой, я и сам перестаю быть таким серьёзным. Мне дорого не только то, как легко мне бывает рядом с тобой. Мне дорога ты."

var state: FinaleState = FinaleState.UNARMED
var player_inside_gate := false
var synthesis_generation := 0
var overlay_opened := false
var controls_locked := false
var portal_requested := false

func _ready() -> void:
	var progress := get_node_or_null(progress_controller_path)
	if progress != null and progress.has_signal("all_rewards_completed") and not progress.all_rewards_completed.is_connected(_on_all_rewards_completed):
		progress.all_rewards_completed.connect(_on_all_rewards_completed)
	var overlay := get_node_or_null(overlay_path)
	if overlay != null and overlay.has_signal("closed") and not overlay.closed.is_connected(_on_overlay_closed):
		overlay.closed.connect(_on_overlay_closed)

func _on_all_rewards_completed() -> void:
	arm_finale()

func arm_finale() -> void:
	if state != FinaleState.UNARMED:
		return
	state = FinaleState.WAITING_FOR_PRESENCE
	finale_armed.emit()
	var env := get_node_or_null(environment_state_path)
	if env != null and env.has_method("request_phase"):
		env.request_phase(&"E6")
	if player_inside_gate:
		_start_synthesis()

func set_player_in_gate(inside: bool) -> void:
	player_inside_gate = inside
	if inside and state == FinaleState.WAITING_FOR_PRESENCE:
		_start_synthesis()

func _start_synthesis() -> void:
	if state != FinaleState.WAITING_FOR_PRESENCE:
		return
	state = FinaleState.SYNTHESIS_ACTIVE
	synthesis_generation += 1
	_finish_synthesis_later(synthesis_generation)

func _finish_synthesis_later(source_generation: int) -> void:
	await get_tree().create_timer(synthesis_duration).timeout
	if state != FinaleState.SYNTHESIS_ACTIVE or source_generation != synthesis_generation:
		return
	_show_main_text()

func _show_main_text() -> bool:
	if state != FinaleState.SYNTHESIS_ACTIVE or overlay_opened:
		return false
	var overlay := get_node_or_null(overlay_path)
	if overlay == null or not overlay.has_method("show_finale_text"):
		return false
	var ok: bool = overlay.show_finale_text(main_text)
	if not ok:
		return false
	overlay_opened = true
	state = FinaleState.MAIN_TEXT_ACTIVE
	_set_player_controls(false)
	var recovery := get_node_or_null(recovery_controller_path)
	if recovery != null and recovery.has_method("suspend_recovery"):
		recovery.suspend_recovery(&"main_text", true)
	return true

func _on_overlay_closed() -> void:
	if state != FinaleState.MAIN_TEXT_ACTIVE:
		return
	complete_finale()

func complete_finale() -> void:
	if state == FinaleState.COMPLETED:
		return
	state = FinaleState.COMPLETED
	_set_player_controls(true)
	var recovery := get_node_or_null(recovery_controller_path)
	if recovery != null and recovery.has_method("suspend_recovery"):
		recovery.suspend_recovery(&"main_text", false)
	finale_completed.emit()
	if not portal_requested:
		portal_requested = true
		var portal := get_node_or_null(portal_adapter_path)
		if portal != null and portal.has_method("request_portal_activation"):
			portal.request_portal_activation()

func _set_player_controls(enabled: bool) -> void:
	if controls_locked == (not enabled):
		return
	controls_locked = not enabled
	var player := get_node_or_null(player_path)
	if player != null and player.has_method("set_controls_enabled"):
		player.set_controls_enabled(enabled)

func on_final_overlook_body_entered(body: Node) -> void:
	if _is_player_body(body):
		set_player_in_gate(true)

func on_final_overlook_body_exited(body: Node) -> void:
	if _is_player_body(body):
		set_player_in_gate(false)

func _is_player_body(body: Node) -> bool:
	var player := get_node_or_null(player_path)
	return body == player

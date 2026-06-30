extends Node
class_name Level02PortalAdapter

signal portal_requested
signal portal_activation_completed
signal portal_activation_blocked(reason: String)
signal portal_transition_failed(error_code: int)

@export var portal_path: NodePath
@export var finale_overlay_path: NodePath
@export var player_path: NodePath
@export_multiline var main_text: String = "Мне дорого, что в тебе есть свой свет - иногда яркий, иногда совсем тихий. Его не нужно делать громче или превращать во что-то другое. Мне нравится, что он твой. И рядом с мыслью о тебе во мне становится больше жизни"
var activated := false
var _lock_owned := false

func commit_domain() -> void:
	var portal := get_node_or_null(portal_path)
	if portal:
		_connect_once(portal, "activation_completed", Callable(self, "_on_activation_completed"))
		_connect_once(portal, "transition_failed", Callable(self, "_on_transition_failed"))

func show_finale_and_activate() -> bool:
	if activated:
		return true
	var overlay := get_node_or_null(finale_overlay_path)
	if overlay == null or not overlay.has_method("show_finale_text"):
		portal_activation_blocked.emit("missing finale overlay")
		return false
	if not overlay.show_finale_text(main_text):
		portal_activation_blocked.emit("finale presentation failed")
		return false
	_lock_player(true)
	_connect_once(overlay, "closed", Callable(self, "_on_closed"))
	return true

func _on_closed() -> void:
	_lock_player(false)
	if activated: return
	activated = true
	var portal := get_node_or_null(portal_path)
	if portal and portal.has_method("activate"):
		portal.activate()
		portal_requested.emit()
	else:
		portal_activation_blocked.emit("missing portal")

func _on_activation_completed() -> void:
	portal_activation_completed.emit()

func _on_transition_failed(_player: Node, error_code: int) -> void:
	portal_transition_failed.emit(error_code)

func _lock_player(locked: bool) -> void:
	var player := get_node_or_null(player_path)
	if player == null: return
	_lock_owned = locked
	if player.has_method("set_controls_enabled"):
		player.set_controls_enabled(not locked)

func _connect_once(source: Object, signal_name: StringName, callable: Callable) -> void:
	if source != null and source.has_signal(signal_name) and not source.is_connected(signal_name, callable):
		source.connect(signal_name, callable)

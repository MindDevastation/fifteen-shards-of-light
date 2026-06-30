extends Node
class_name Level02PortalAdapter
signal portal_requested
@export var portal_path: NodePath
@export var finale_overlay_path: NodePath
@export_multiline var main_text: String = "Мне дорого, что в тебе есть свой свет - иногда яркий, иногда совсем тихий. Его не нужно делать громче или превращать во что-то другое. Мне нравится, что он твой. И рядом с мыслью о тебе во мне становится больше жизни"
var activated := false
func show_finale_and_activate() -> bool:
	var overlay := get_node_or_null(finale_overlay_path)
	if overlay == null or not overlay.has_method("show_finale_text"):
		return false
	if not overlay.show_finale_text(main_text):
		return false
	if overlay.has_signal("closed") and not overlay.closed.is_connected(_on_closed):
		overlay.closed.connect(_on_closed)
	return true
func _on_closed() -> void:
	if activated: return
	activated = true
	var portal := get_node_or_null(portal_path)
	if portal and portal.has_method("activate"):
		portal.activate()
	portal_requested.emit()

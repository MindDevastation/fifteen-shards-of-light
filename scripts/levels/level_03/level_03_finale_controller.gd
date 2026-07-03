class_name Level03FinaleController
extends Node

signal finale_armed
signal finale_completed

@export var progress_controller_path: NodePath = NodePath("../Level03ProgressController")
@export var overlay_path: NodePath = NodePath("../../UILayer/LevelFinaleOverlay")
@export var environment_state_path: NodePath = NodePath("../../EnvironmentStateRoot")
@export var portal_adapter_path: NodePath = NodePath("../Level03PortalAdapter")
@export_multiline var main_text: String = "Сначала я просто заметил, что жду наших разговоров. Потом понял, что после них ещё долго вспоминаю твою интонацию, а когда ты внезапно смеёшься над какой-нибудь ерундой, я и сам перестаю быть таким серьёзным. Мне дорого не только то, как легко мне бывает рядом с тобой. Мне дорога ты."
var armed := false
var completed := false

func _ready() -> void:
	var progress := get_node_or_null(progress_controller_path)
	if progress != null and progress.has_signal("all_rewards_completed") and not progress.all_rewards_completed.is_connected(arm_finale):
		progress.all_rewards_completed.connect(arm_finale)

func arm_finale() -> void:
	if armed:
		return
	armed = true
	finale_armed.emit()
	var env := get_node_or_null(environment_state_path)
	if env != null and env.has_method("request_phase"):
		env.request_phase(&"E6")

func show_finale_if_armed() -> bool:
	if not armed or completed:
		return false
	var overlay := get_node_or_null(overlay_path)
	if overlay != null:
		overlay.visible = true
		var label := overlay.get_node_or_null("Text") as Label
		if label != null:
			label.text = main_text
	return true

func complete_finale() -> void:
	if completed:
		return
	completed = true
	var overlay := get_node_or_null(overlay_path)
	if overlay != null:
		overlay.visible = false
	finale_completed.emit()
	var portal := get_node_or_null(portal_adapter_path)
	if portal != null and portal.has_method("request_portal_activation"):
		portal.request_portal_activation()

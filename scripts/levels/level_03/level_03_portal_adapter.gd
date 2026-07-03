class_name Level03PortalAdapter
extends Node

signal portal_activation_requested
signal portal_active

@export var portal_core_path: NodePath = NodePath("../../GameplayRoot/FinalOverlook/LevelPortalRoot/PortalCore")
@export var local_portal_vfx_path: NodePath = NodePath("../../VFXRoot/Level03PortalAccentVFX")
var activation_requested := false
var active := false

func _ready() -> void:
	var portal := get_node_or_null(portal_core_path)
	if portal != null and portal.has_signal("activation_completed") and not portal.activation_completed.is_connected(_on_activation_completed):
		portal.activation_completed.connect(_on_activation_completed)

func request_portal_activation() -> bool:
	if activation_requested:
		return false
	var portal := get_node_or_null(portal_core_path)
	if portal == null or not portal.has_method("activate"):
		return false
	activation_requested = true
	portal_activation_requested.emit()
	if "target_scene_path" in portal:
		portal.target_scene_path = "res://scenes/levels/Level_04.tscn"
	if "require_entry_confirmation" in portal:
		portal.require_entry_confirmation = false
	if "entry_mode" in portal:
		portal.entry_mode = 0
	portal.activate()
	return true

func _on_activation_completed() -> void:
	if active:
		return
	active = true
	portal_active.emit()

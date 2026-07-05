extends Node
class_name Level04PortalAdapter

signal portal_activation_requested
signal portal_activated
signal portal_activation_blocked(reason)
signal configuration_error(component, message)

const EXPECTED_PORTAL_ANCHOR_POSITION := Vector3(6.0, 2.0, 56.5)
const POSITION_EPSILON := 0.001

@export var portal_path := NodePath("../../GameplayRoot/PortalRoot/PortalFloorAnchor/LevelPortal")
@export var portal_floor_anchor_path := NodePath("../../GameplayRoot/PortalRoot/PortalFloorAnchor")
@export var portal_accent_vfx_path := NodePath("../../VFXRoot/PortalAccentVFX")
@export var expected_target_scene_path := "res://scenes/levels/Level_05.tscn"
@export var activation_timeout_seconds: float = 4.0

var _activation_requested := false
var _portal_activated := false
var _activation_started_observed := false
var _blocked_reasons: Array[StringName] = []
var _validation_errors: Array[Dictionary] = []
var _timeout_timer: SceneTreeTimer = null

func request_activation() -> bool:
	if _activation_requested:
		return true
	if not debug_validate_configuration():
		_emit_blocked(&"configuration_invalid")
		return false
	var portal := get_node_or_null(portal_path)
	_activation_requested = true
	_connect_portal_signals(portal)
	_start_portal_accent()
	portal_activation_requested.emit()
	portal.call(&"activate")
	_start_timeout_timer()
	return true

func is_activation_requested() -> bool:
	return _activation_requested

func is_portal_activated() -> bool:
	return _portal_activated

func debug_validate_configuration() -> bool:
	_validation_errors.clear()
	var ok := true
	var portal := get_node_or_null(portal_path)
	if portal == null:
		_record_validation_error(&"Level04PortalAdapter", "portal_path does not resolve")
		ok = false
	else:
		if not _is_shared_level_portal(portal):
			_record_validation_error(&"Level04PortalAdapter", "portal_path does not resolve to shared LevelPortal")
			ok = false
		if not portal.has_method(&"activate"):
			_record_validation_error(&"Level04PortalAdapter", "LevelPortal.activate is missing")
			ok = false
		if not portal.has_signal(&"activation_started"):
			_record_validation_error(&"Level04PortalAdapter", "LevelPortal.activation_started is missing")
			ok = false
		if not portal.has_signal(&"activation_completed"):
			_record_validation_error(&"Level04PortalAdapter", "LevelPortal.activation_completed is missing")
			ok = false
		if not _validate_portal_configuration(portal):
			ok = false
	var portal_floor_anchor := get_node_or_null(portal_floor_anchor_path)
	if portal_floor_anchor == null or not portal_floor_anchor is Node3D:
		_record_validation_error(&"Level04PortalAdapter", "PortalFloorAnchor path does not resolve to Node3D")
		ok = false
	else:
		var anchor_node := portal_floor_anchor as Node3D
		if not anchor_node.position.is_equal_approx(EXPECTED_PORTAL_ANCHOR_POSITION):
			_record_validation_error(&"Level04PortalAdapter", "PortalFloorAnchor local position is not Vector3(6, 2, 56.5)")
			ok = false
	if portal != null and portal is Node3D:
		var portal_node := portal as Node3D
		if portal_node.get_parent() != portal_floor_anchor:
			_record_validation_error(&"Level04PortalAdapter", "LevelPortal is not a direct child of PortalFloorAnchor")
			ok = false
		if not _is_identity_local_transform(portal_node):
			_record_validation_error(&"Level04PortalAdapter", "LevelPortal local transform is not identity")
			ok = false
	if get_node_or_null(portal_accent_vfx_path) == null:
		_record_validation_error(&"Level04PortalAdapter", "PortalAccentVFX path does not resolve")
		ok = false
	return ok

func request_debug_snapshot() -> Dictionary:
	return {
		"activation_requested": _activation_requested,
		"portal_activated": _portal_activated,
		"activation_started_observed": _activation_started_observed,
		"blocked_reasons": _blocked_reasons.duplicate(),
		"validation_errors": _validation_errors.duplicate(true),
		"portal_path": str(portal_path),
		"portal_floor_anchor_path": str(portal_floor_anchor_path),
		"portal_accent_vfx_path": str(portal_accent_vfx_path),
		"expected_target_scene_path": expected_target_scene_path,
	}

func debug_force_activation_timeout() -> void:
	_on_activation_timeout()

func _validate_portal_configuration(portal: Node) -> bool:
	var ok := true
	if not "target_scene_path" in portal or portal.target_scene_path != expected_target_scene_path:
		_record_validation_error(&"Level04PortalAdapter", "LevelPortal target_scene_path is not Level_05")
		ok = false
	if not "entry_mode" in portal or int(portal.entry_mode) != 0:
		_record_validation_error(&"Level04PortalAdapter", "LevelPortal entry_mode is not AUTO_ENTER")
		ok = false
	if not "require_entry_confirmation" in portal or bool(portal.require_entry_confirmation):
		_record_validation_error(&"Level04PortalAdapter", "LevelPortal require_entry_confirmation is not false")
		ok = false
	return ok

func _is_shared_level_portal(portal: Node) -> bool:
	var script: Script = portal.get_script()
	if script == null:
		return false
	if script.get_global_name() == "LevelPortal":
		return true
	return script.resource_path == "res://scripts/core/level_portal.gd"


func _connect_portal_signals(portal: Node) -> void:
	if portal.has_signal(&"activation_started") and not portal.is_connected(&"activation_started", _on_shared_portal_activation_started):
		portal.connect(&"activation_started", _on_shared_portal_activation_started)
	if portal.has_signal(&"activation_completed") and not portal.is_connected(&"activation_completed", _on_shared_portal_activation_completed):
		portal.connect(&"activation_completed", _on_shared_portal_activation_completed)

func _start_portal_accent() -> void:
	var portal_accent := get_node_or_null(portal_accent_vfx_path)
	if portal_accent == null:
		return
	if "visible" in portal_accent:
		portal_accent.visible = true
	for child in portal_accent.get_children():
		if "visible" in child:
			child.visible = true

func _cleanup_portal_accent() -> void:
	var portal_accent := get_node_or_null(portal_accent_vfx_path)
	if portal_accent != null and "visible" in portal_accent:
		portal_accent.visible = false

func _start_timeout_timer() -> void:
	if activation_timeout_seconds <= 0.0:
		return
	_timeout_timer = get_tree().create_timer(activation_timeout_seconds)
	_timeout_timer.timeout.connect(_on_activation_timeout)

func _on_shared_portal_activation_started() -> void:
	_activation_started_observed = true

func _on_shared_portal_activation_completed() -> void:
	if _portal_activated:
		return
	_portal_activated = true
	portal_activated.emit()

func _on_activation_timeout() -> void:
	if _portal_activated:
		return
	_cleanup_portal_accent()
	_emit_blocked(&"activation_timeout")

func _emit_blocked(reason: StringName) -> void:
	if not _blocked_reasons.has(reason):
		_blocked_reasons.append(reason)
	portal_activation_blocked.emit(reason)

func _record_validation_error(component: StringName, message: String) -> void:
	_validation_errors.append({"component": component, "message": message})
	configuration_error.emit(component, message)

func _is_identity_local_transform(node: Node3D) -> bool:
	return node.position.length() <= POSITION_EPSILON and node.rotation.length() <= POSITION_EPSILON and node.scale.is_equal_approx(Vector3.ONE)

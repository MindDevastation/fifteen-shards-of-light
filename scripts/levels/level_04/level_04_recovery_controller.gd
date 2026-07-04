extends Node
class_name Level04RecoveryController

signal recovery_performed(anchor_id, volume_id)
signal configuration_error(component, message)

const EXPECTED_VOLUME_IDS: Array[StringName] = [
	&"RV_SOFT_RETURN",
	&"RV_OOB_WEST_PERIMETER",
	&"RV_OOB_EAST_PERIMETER",
	&"RV_OOB_SOUTH_PERIMETER",
	&"RV_OOB_NORTH_PERIMETER",
]
const EXPECTED_ANCHOR_IDS: Array[StringName] = [
	&"RA0_ARRIVAL",
	&"RA1_CROSSING_TREE",
	&"RA2_CANOPY_INITIAL",
	&"RA3_CANOPY_FIRST_PASS",
	&"RA4_RIPPLE_INITIAL",
	&"RA5_RIPPLE_FIRST_PASS",
	&"RA6_UPPER_CROSSING",
	&"RA7_LOWER_CROSSING",
	&"RA8_CANOPY_REMAINING",
	&"RA9_RIPPLE_REMAINING",
	&"RA10_WEATHER_WEAVE",
	&"RA11_FINAL_PAVILION",
]
const SUSPENSION_SHARD_REWARD := &"shard_reward"
const SUSPENSION_MAIN_TEXT := &"main_text"
const SOUTH_VOLUME_ID := &"RV_OOB_SOUTH_PERIMETER"
const SOUTH_EXPECTED_POSITION := Vector3(0.0, 1.0, -65.0)
const SOUTH_EXPECTED_EXTENTS := Vector3(39.0, 10.0, 4.0)

@export var player_path: NodePath = NodePath("../../PlayerRoot/Player")
@export var recovery_volumes_root_path: NodePath = NodePath("../../GameplayRoot/SafetyRoot/RecoveryVolumes")
@export var recovery_anchors_root_path: NodePath = NodePath("../../GameplayRoot/SafetyRoot/RecoveryAnchors")
@export var recovery_volume_paths: Array[NodePath] = []
@export var recovery_anchor_paths: Array[NodePath] = []

@onready var _player: CharacterBody3D = get_node_or_null(player_path) as CharacterBody3D

var _registered_volumes: Dictionary = {}
var _registered_anchors: Dictionary = {}
var _latest_valid_anchor_id: StringName = &""
var _active_volume_ids: Dictionary = {}
var _suspension_sources: Dictionary = {}
var _pending_volume_id: StringName = &""
var _fall_token := 0
var _fall_token_open := true
var _rearm_after_clear := false
var _configuration_valid := false


func _ready() -> void:
	_configuration_valid = _validate_and_register_configuration()
	if not _configuration_valid:
		set_physics_process(false)
		return
	set_physics_process(true)


func _physics_process(_delta: float) -> void:
	if _rearm_after_clear and _active_volume_ids.is_empty():
		await get_tree().physics_frame
		if _active_volume_ids.is_empty():
			_fall_token_open = true
			_rearm_after_clear = false


func register_recovery_volume(volume, expected_volume_id) -> bool:
	if volume == null or not volume.has_method("get_volume_id") or not volume.has_method("set_sensor_enabled"):
		_emit_configuration_error("Level04RecoveryController", "Recovery volume type mismatch for %s" % [expected_volume_id])
		return false
	var typed_volume: Node = volume
	var volume_id: StringName = typed_volume.get_volume_id()
	if volume_id != StringName(expected_volume_id):
		_emit_configuration_error("Level04RecoveryController", "Recovery volume ID mismatch: expected %s got %s" % [expected_volume_id, volume_id])
		return false
	if _registered_volumes.has(volume_id):
		_emit_configuration_error("Level04RecoveryController", "Duplicate recovery volume ID %s" % [volume_id])
		return false
	_registered_volumes[volume_id] = typed_volume
	if not typed_volume.body_entered.is_connected(_on_recovery_volume_body_entered.bind(volume_id)):
		typed_volume.body_entered.connect(_on_recovery_volume_body_entered.bind(volume_id))
	if not typed_volume.body_exited.is_connected(_on_recovery_volume_body_exited.bind(volume_id)):
		typed_volume.body_exited.connect(_on_recovery_volume_body_exited.bind(volume_id))
	return true


func register_anchor_zone(zone, expected_anchor_id) -> bool:
	if zone == null or not zone.has_method("get_anchor_id") or not zone.has_method("get_floor_anchor_global_transform"):
		_emit_configuration_error("Level04RecoveryController", "Recovery anchor type mismatch for %s" % [expected_anchor_id])
		return false
	var typed_zone: Node = zone
	var anchor_id: StringName = typed_zone.get_anchor_id()
	if anchor_id != StringName(expected_anchor_id):
		_emit_configuration_error("Level04RecoveryController", "Recovery anchor ID mismatch: expected %s got %s" % [expected_anchor_id, anchor_id])
		return false
	if _registered_anchors.has(anchor_id):
		_emit_configuration_error("Level04RecoveryController", "Duplicate recovery anchor ID %s" % [anchor_id])
		return false
	_registered_anchors[anchor_id] = typed_zone
	if not typed_zone.recovery_anchor_reached.is_connected(report_recovery_anchor_reached.bind(typed_zone)):
		typed_zone.recovery_anchor_reached.connect(report_recovery_anchor_reached.bind(typed_zone))
	if _latest_valid_anchor_id == &"":
		_latest_valid_anchor_id = anchor_id
	return true


func report_recovery_anchor_reached(anchor_id, source_zone) -> void:
	var typed_id := StringName(anchor_id)
	if not _configuration_valid or not _registered_anchors.has(typed_id):
		return
	if _registered_anchors[typed_id] != source_zone:
		return
	if _player == null or not _player.is_on_floor():
		return
	_latest_valid_anchor_id = typed_id


func get_latest_valid_anchor_id() -> StringName:
	return _latest_valid_anchor_id


func get_latest_valid_anchor_transform() -> Transform3D:
	if _registered_anchors.has(_latest_valid_anchor_id):
		return _registered_anchors[_latest_valid_anchor_id].get_floor_anchor_global_transform()
	return Transform3D.IDENTITY


func add_suspension_source(source_key) -> void:
	var typed_key := StringName(source_key)
	if typed_key != SUSPENSION_SHARD_REWARD and typed_key != SUSPENSION_MAIN_TEXT:
		return
	_suspension_sources[typed_key] = true


func remove_suspension_source(source_key) -> void:
	_suspension_sources.erase(StringName(source_key))
	if _suspension_sources.is_empty() and _pending_volume_id != &"":
		if _active_volume_ids.is_empty():
			_pending_volume_id = &""
		else:
			_perform_recovery(_pending_volume_id)
			_pending_volume_id = &""


func debug_get_registered_volume_ids() -> Array[StringName]:
	var ids: Array[StringName] = []
	for id in _registered_volumes.keys():
		ids.append(id)
	return ids


func debug_get_registered_anchor_ids() -> Array[StringName]:
	var ids: Array[StringName] = []
	for id in _registered_anchors.keys():
		ids.append(id)
	return ids


func _validate_and_register_configuration() -> bool:
	if _player == null:
		_emit_configuration_error("Level04RecoveryController", "Player path did not resolve to CharacterBody3D")
		return false
	if recovery_volume_paths.size() != EXPECTED_VOLUME_IDS.size():
		_emit_configuration_error("Level04RecoveryController", "Recovery volume path count mismatch")
		return false
	if recovery_anchor_paths.size() != EXPECTED_ANCHOR_IDS.size():
		_emit_configuration_error("Level04RecoveryController", "Recovery anchor path count mismatch")
		return false
	for index in EXPECTED_VOLUME_IDS.size():
		var volume := get_node_or_null(recovery_volume_paths[index])
		if not register_recovery_volume(volume, EXPECTED_VOLUME_IDS[index]):
			return false
		if not _validate_volume_shape(volume, EXPECTED_VOLUME_IDS[index]):
			return false
	for index in EXPECTED_ANCHOR_IDS.size():
		var anchor := get_node_or_null(recovery_anchor_paths[index])
		if not register_anchor_zone(anchor, EXPECTED_ANCHOR_IDS[index]):
			return false
	return true


func _validate_volume_shape(volume: Node, expected_id: StringName) -> bool:
	var collision_shape := volume.get_node_or_null(volume.collision_shape_path) as CollisionShape3D
	if collision_shape == null or not collision_shape.shape is BoxShape3D:
		_emit_configuration_error("Level04RecoveryController", "Recovery volume shape mismatch for %s" % [expected_id])
		return false
	if expected_id == SOUTH_VOLUME_ID:
		var box := collision_shape.shape as BoxShape3D
		if not volume.position.is_equal_approx(SOUTH_EXPECTED_POSITION):
			_emit_configuration_error("Level04RecoveryController", "OOB_SouthPerimeter position mismatch")
			return false
		if not volume.rotation.is_equal_approx(Vector3.ZERO):
			_emit_configuration_error("Level04RecoveryController", "OOB_SouthPerimeter rotation mismatch")
			return false
		if not box.size.is_equal_approx(SOUTH_EXPECTED_EXTENTS * 2.0):
			_emit_configuration_error("Level04RecoveryController", "OOB_SouthPerimeter extents mismatch")
			return false
	return true


func _on_recovery_volume_body_entered(body: Node3D, volume_id: StringName) -> void:
	if body != _player or not _configuration_valid:
		return
	_active_volume_ids[volume_id] = true
	if not _fall_token_open:
		return
	_fall_token_open = false
	_fall_token += 1
	if not _suspension_sources.is_empty():
		_pending_volume_id = volume_id
		return
	_perform_recovery(volume_id)


func _on_recovery_volume_body_exited(body: Node3D, volume_id: StringName) -> void:
	if body != _player:
		return
	_active_volume_ids.erase(volume_id)
	if _active_volume_ids.is_empty() and not _pending_volume_id == &"":
		_pending_volume_id = &""
		_fall_token_open = true


func _perform_recovery(volume_id: StringName) -> void:
	if _player == null or not _registered_anchors.has(_latest_valid_anchor_id):
		return
	_player.global_transform = get_latest_valid_anchor_transform()
	_player.velocity = Vector3.ZERO
	recovery_performed.emit(_latest_valid_anchor_id, volume_id)
	_rearm_after_clear = true


func _emit_configuration_error(component: String, message: String) -> void:
	push_error("%s: %s" % [component, message])
	configuration_error.emit(component, message)

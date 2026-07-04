extends Node3D
class_name Level04RecoveryAnchorZone

signal recovery_anchor_reached(anchor_id)

@export var anchor_id: StringName
@export var floor_anchor_path: NodePath = NodePath("FloorAnchor")
@export var arrival_zone_path: NodePath = NodePath("ArrivalZone")
@export var player_path: NodePath = NodePath("../../../../PlayerRoot/Player")

@onready var _floor_anchor: Marker3D = get_node_or_null(floor_anchor_path) as Marker3D
@onready var _arrival_zone: Area3D = get_node_or_null(arrival_zone_path) as Area3D
@onready var _player: CharacterBody3D = get_node_or_null(player_path) as CharacterBody3D

var _current_generation := 0


func _ready() -> void:
	if _arrival_zone != null:
		_arrival_zone.body_entered.connect(_on_arrival_zone_body_entered)
		_arrival_zone.body_exited.connect(_on_arrival_zone_body_exited)
	call_deferred("debug_reevaluate_overlap")


func get_anchor_id() -> StringName:
	return anchor_id


func get_floor_anchor_global_transform() -> Transform3D:
	if _floor_anchor == null:
		return global_transform
	return _floor_anchor.global_transform


func set_sensor_enabled(enabled: bool) -> void:
	if _arrival_zone == null:
		return
	_arrival_zone.monitoring = enabled
	_arrival_zone.monitorable = enabled
	for child in _arrival_zone.get_children():
		var shape := child as CollisionShape3D
		if shape != null:
			shape.disabled = not enabled


func debug_reevaluate_overlap() -> void:
	if _arrival_zone == null or _player == null or not _arrival_zone.monitoring:
		return
	await get_tree().physics_frame
	for body in _arrival_zone.get_overlapping_bodies():
		if body == _player:
			_attempt_report_current_player()
			return


func _on_arrival_zone_body_entered(body: Node3D) -> void:
	if body != _player:
		return
	_attempt_report_current_player()


func _on_arrival_zone_body_exited(body: Node3D) -> void:
	if body != _player:
		return
	_current_generation += 1


func _attempt_report_current_player() -> void:
	if _player == null:
		return
	var generation := _current_generation
	await get_tree().physics_frame
	if generation != _current_generation:
		return
	if _arrival_zone == null or not _arrival_zone.get_overlapping_bodies().has(_player):
		return
	if _player.is_on_floor():
		recovery_anchor_reached.emit(anchor_id)

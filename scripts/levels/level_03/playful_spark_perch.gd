class_name PlayfulSparkPerch
extends Area3D

signal perch_entered(perch_id: StringName)
signal perch_exited(perch_id: StringName)

@export var perch_id: StringName = &""

var _registered_player: Node = null
var _acceptance_enabled := false
var _occupied := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	_update_monitoring_state()

func register_player(player: Node) -> void:
	_registered_player = player

func set_acceptance_enabled(enabled: bool) -> void:
	_acceptance_enabled = enabled
	_update_monitoring_state()

func is_player_inside() -> bool:
	return _occupied

func reevaluate_registered_player_overlap() -> void:
	if not _acceptance_enabled or _registered_player == null:
		return
	for body in get_overlapping_bodies():
		if body == _registered_player:
			_on_body_entered(body)
			return

func _on_body_entered(body: Node) -> void:
	if not _acceptance_enabled or body != _registered_player or _occupied:
		return
	_occupied = true
	perch_entered.emit(perch_id)

func _on_body_exited(body: Node) -> void:
	if body != _registered_player:
		return
	if _occupied:
		_occupied = false
		perch_exited.emit(perch_id)

func _update_monitoring_state() -> void:
	monitoring = _acceptance_enabled
	monitorable = true

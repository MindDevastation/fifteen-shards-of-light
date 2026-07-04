class_name BreathingMeadowPetal
extends Area3D

signal petal_entered(petal_id: StringName)
signal petal_exited(petal_id: StringName)

@export var petal_id: StringName = &""

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

func is_registered_player_inside() -> bool:
	return _occupied

func _on_body_entered(body: Node) -> void:
	if not _acceptance_enabled or body != _registered_player or _occupied:
		return
	_occupied = true
	petal_entered.emit(petal_id)

func _on_body_exited(body: Node) -> void:
	if body != _registered_player:
		return
	if _occupied:
		_occupied = false
		petal_exited.emit(petal_id)

func _update_monitoring_state() -> void:
	set_deferred("monitoring", _acceptance_enabled)
	set_deferred("monitorable", true)

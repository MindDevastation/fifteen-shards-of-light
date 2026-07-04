extends Node3D
class_name Level04PresenceFootprint

signal presence_accepted(id, footprint_id, route_context)

enum RouteContext {
	INITIAL,
	REMAINING,
}

@export var target_id: StringName
@export var footprint_id: StringName
@export var route_context: RouteContext
@export var player_path: NodePath
@export var dwell_seconds: float = 0.45
@export var sensor_path := NodePath("Area3D")

var _sensor: Area3D
var _player: Node
var _accepted := false
var _valid_overlap := false
var _dwell_elapsed := 0.0

func _ready() -> void:
	_sensor = get_node_or_null(sensor_path) as Area3D
	_player = get_node_or_null(player_path)
	if _sensor != null:
		if not _sensor.body_entered.is_connected(_on_body_entered):
			_sensor.body_entered.connect(_on_body_entered)
		if not _sensor.body_exited.is_connected(_on_body_exited):
			_sensor.body_exited.connect(_on_body_exited)
	call_deferred("_reevaluate_current_overlap")

func _physics_process(delta: float) -> void:
	if _accepted:
		return
	_update_valid_overlap()
	if not _valid_overlap:
		_dwell_elapsed = 0.0
		return
	_dwell_elapsed += delta
	if _dwell_elapsed >= dwell_seconds:
		_accept_presence()

func reset_activation() -> void:
	_accepted = false
	_dwell_elapsed = 0.0
	call_deferred("_reevaluate_current_overlap")

func set_footprint_enabled(enabled: bool) -> void:
	set_physics_process(enabled)
	visible = enabled
	if _sensor != null:
		_sensor.monitoring = enabled
		_sensor.monitorable = enabled
	if enabled:
		_dwell_elapsed = 0.0
		call_deferred("_reevaluate_current_overlap")
	else:
		_valid_overlap = false

func _on_body_entered(body: Node) -> void:
	if body == _player:
		_update_valid_overlap()

func _on_body_exited(body: Node) -> void:
	if body == _player:
		_valid_overlap = false
		_dwell_elapsed = 0.0

func _reevaluate_current_overlap() -> void:
	_update_valid_overlap()

func _update_valid_overlap() -> void:
	_valid_overlap = false
	if _accepted or _sensor == null or _player == null or not _sensor.monitoring:
		return
	if not _sensor.get_overlapping_bodies().has(_player):
		return
	if not _is_player_grounded(_player):
		return
	_valid_overlap = true

func _is_player_grounded(player: Node) -> bool:
	if player.has_method("is_on_floor"):
		return bool(player.call("is_on_floor"))
	if "is_grounded" in player:
		return bool(player.get("is_grounded"))
	if player.has_method("is_grounded"):
		return bool(player.call("is_grounded"))
	return false

func _accept_presence() -> void:
	_accepted = true
	_valid_overlap = false
	_dwell_elapsed = 0.0
	presence_accepted.emit(target_id, footprint_id, route_context)

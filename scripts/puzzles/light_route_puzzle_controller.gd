extends Node3D
class_name LightRoutePuzzleController

signal puzzle_completed

const LightRouteBeamScene := preload("res://scripts/puzzles/light_route_beam.gd")

@export var source_lamps: Array[NodePath] = []
@export var relay_lamps: Array[NodePath] = []
@export var destination_lamps: Array[NodePath] = []
@export var channel_paths: Array = []
@export var channel_colors: Array[Color] = [Color(1.0, 0.64, 0.28, 1.0), Color(0.72, 0.88, 1.0, 1.0)]
@export var barrier_path: NodePath
@export var invalid_cooldown: float = 0.25

var _lamps_by_id: Dictionary = {}
var _lamp_channels: Dictionary = {}
var _active_index_by_channel: Array[int] = []
var _selected_lamp: Node
var _completed_channels: Dictionary = {}
var _barrier: Node
var _beam_root: Node3D
var _completed := false

func _ready() -> void:
	_beam_root = Node3D.new()
	_beam_root.name = "RuntimeBeams"
	add_child(_beam_root)
	_configure_lamps()
	_barrier = get_node_or_null(barrier_path)
	_reset_puzzle_state()

func has_selected_endpoint() -> bool:
	return _selected_lamp != null

func can_lamp_be_interacted(lamp: Node) -> bool:
	if _completed or lamp == null:
		return false
	if _selected_lamp == null:
		return lamp.state == 1
	return lamp.state == 0

func _on_lamp_interaction(lamp: Node, _player: Node) -> void:
	if _selected_lamp == null:
		if lamp.state != 1:
			lamp.play_invalid_feedback()
			return
		_selected_lamp = lamp
		lamp.set_lamp_state(2)
		return
	_try_connect_to(lamp)

func _try_connect_to(target: Node) -> void:
	var source: Node = _selected_lamp
	if source == null:
		return
	var channel := int(_lamp_channels.get(source.lamp_id, -1))
	var path: Array = channel_paths[channel] if channel >= 0 and channel < channel_paths.size() else []
	var active_index := int(_active_index_by_channel[channel])
	var expected_next := StringName(path[active_index + 1]) if active_index + 1 < path.size() else StringName()
	if target.lamp_id != expected_next or target.state != 0:
		target.play_invalid_feedback()
		source.set_lamp_state(1)
		_selected_lamp = null
		return
	_create_beam(source, target, _channel_color(channel))
	source.set_lamp_state(3)
	if target.role == 2:
		target.set_lamp_state(4)
		_completed_channels[channel] = true
	else:
		target.set_lamp_state(1)
	_active_index_by_channel[channel] = active_index + 1
	_lamp_channels[target.lamp_id] = channel
	target.play_success_feedback()
	_selected_lamp = null
	_check_completion()

func _configure_lamps() -> void:
	_lamps_by_id.clear()
	for path in source_lamps + relay_lamps + destination_lamps:
		var lamp: Node = get_node_or_null(path)
		if lamp == null:
			push_error("LightRoutePuzzleController missing lamp: %s" % [path])
			continue
		_lamps_by_id[lamp.lamp_id] = lamp
		if not lamp.interaction_requested.is_connected(_on_lamp_interaction):
			lamp.interaction_requested.connect(_on_lamp_interaction)
	for channel in range(channel_paths.size()):
		var path_ids: Array = channel_paths[channel]
		for lamp_id in path_ids:
			var lamp: Node = _lamps_by_id.get(StringName(lamp_id))
			if lamp != null:
				lamp.configure(self, _channel_color(channel))

func _reset_puzzle_state() -> void:
	_active_index_by_channel.resize(channel_paths.size())
	for channel in range(channel_paths.size()):
		_active_index_by_channel[channel] = 0
		var first_id := StringName(channel_paths[channel][0])
		var first: Node = _lamps_by_id.get(first_id)
		if first != null:
			_lamp_channels[first.lamp_id] = channel
			first.set_lamp_state(1)
	for id in _lamps_by_id.keys():
		var lamp: Node = _lamps_by_id[id]
		if not _lamp_channels.has(lamp.lamp_id):
			lamp.set_lamp_state(0)

func _create_beam(source: Node, target: Node, color: Color) -> void:
	var beam: Node = LightRouteBeamScene.new()
	_beam_root.add_child(beam)
	beam.configure_between(source, target, color)

func _channel_color(channel: int) -> Color:
	if channel >= 0 and channel < channel_colors.size():
		return channel_colors[channel]
	return Color(1.0, 0.72, 0.32, 1.0)

func _check_completion() -> void:
	if _completed_channels.size() < channel_paths.size():
		return
	_completed = true
	if _barrier != null and _barrier.has_method("open_gate"):
		_barrier.call("open_gate")
	puzzle_completed.emit()

extends Node3D
class_name LightRoutePuzzleController

signal selection_changed
signal puzzle_state_changed
signal puzzle_completed

const LightRouteBeamScene := preload("res://scripts/puzzles/light_route_beam.gd")
const STATE_INACTIVE := 0
const STATE_AVAILABLE := 1
const STATE_SELECTED := 2
const STATE_LOCKED := 3
const STATE_COMPLETED := 4
const STATE_INCORRECT := 5
const ROLE_SOURCE := 0
const ROLE_RELAY := 1
const ROLE_DESTINATION := 2

@export var source_lamps: Array[NodePath] = []
@export var relay_lamps: Array[NodePath] = []
@export var destination_lamps: Array[NodePath] = []
@export var channel_paths: Array = []
@export var channel_colors: Array[Color] = [Color(1.0, 0.64, 0.28, 1.0), Color(0.72, 0.88, 1.0, 1.0)]
@export var barrier_path: NodePath
@export var invalid_cooldown: float = 0.25

var _lamps_by_id: Dictionary = {}
var _lamp_channels: Dictionary = {}
var _actual_route_by_channel: Array[Array] = []
var _selected_lamp: Node
var _completed_channels: Dictionary = {}
var _incorrect_channels: Dictionary = {}
var _barrier: Node
var _beam_root: Node3D
var _beams_by_channel: Array[Array] = []
var _completed := false

func _ready() -> void:
	_beam_root = Node3D.new()
	_beam_root.name = "RuntimeBeams"
	add_child(_beam_root)
	_configure_lamps()
	_barrier = get_node_or_null(barrier_path)
	reset_all()

func has_selected_endpoint() -> bool:
	return _selected_lamp != null

func can_lamp_be_interacted(lamp: Node) -> bool:
	if _completed or lamp == null:
		return false
	if _selected_lamp == lamp and lamp.state == STATE_SELECTED:
		return true
	if _selected_lamp == null:
		if lamp.role == ROLE_SOURCE and _can_reset_channel(lamp.channel_id):
			return true
		return lamp.state == STATE_AVAILABLE
	return _is_valid_target_for_selected(lamp)

func get_prompt_text_for_lamp(lamp: Node) -> String:
	if lamp == _selected_lamp and lamp.state == STATE_SELECTED:
		return lamp.cancel_prompt_text
	if lamp.role == ROLE_SOURCE and _can_reset_channel(lamp.channel_id) and _selected_lamp == null:
		return lamp.reset_prompt_text
	if _selected_lamp != null and _is_valid_target_for_selected(lamp):
		return lamp.connect_prompt_text
	return lamp.idle_prompt_text

func refresh_all_prompts() -> void:
	for lamp in _lamps_by_id.values():
		if lamp != null and lamp.has_method("refresh_prompt"):
			lamp.call("refresh_prompt")

func reset_all() -> void:
	_selected_lamp = null
	_completed = false
	_clear_runtime_beam_root()
	_reset_all_lamp_runtime_state()
	_lamp_channels.clear()
	_actual_route_by_channel.clear()
	_completed_channels.clear()
	_incorrect_channels.clear()
	_beams_by_channel.clear()
	for channel in range(channel_paths.size()):
		_actual_route_by_channel.append([])
		_beams_by_channel.append([])
		_reset_channel(channel, true)
	if _barrier != null and _barrier.has_method("reset_gate"):
		_barrier.call("reset_gate")
	refresh_all_prompts()
	puzzle_state_changed.emit()

func _clear_runtime_beam_root() -> void:
	if _beam_root == null:
		_beam_root = Node3D.new()
		_beam_root.name = "RuntimeBeams"
		add_child(_beam_root)
		return
	for child in _beam_root.get_children():
		child.free()

func _reset_all_lamp_runtime_state() -> void:
	for lamp in _lamps_by_id.values():
		if lamp == null:
			continue
		if lamp.has_method("clear_runtime_channel"):
			lamp.call("clear_runtime_channel")
		lamp.set_lamp_state(STATE_INACTIVE)

func reset_channel(channel: int) -> void:
	_reset_channel(channel, false)
	refresh_all_prompts()
	puzzle_state_changed.emit()

func _on_lamp_interaction(lamp: Node, _player: Node) -> void:
	if lamp.role == ROLE_SOURCE and _selected_lamp == null and _can_reset_channel(lamp.channel_id):
		reset_channel(lamp.channel_id)
		return
	if _selected_lamp == lamp and lamp.state == STATE_SELECTED:
		_cancel_selection()
		return
	if _selected_lamp == null:
		if lamp.state != STATE_AVAILABLE:
			lamp.play_invalid_feedback()
			refresh_all_prompts()
			return
		_selected_lamp = lamp
		lamp.set_lamp_state(STATE_SELECTED)
		selection_changed.emit()
		refresh_all_prompts()
		return
	_try_connect_to(lamp)

func _try_connect_to(target: Node) -> void:
	var source: Node = _selected_lamp
	if source == null:
		return
	if not _is_valid_target_for_selected(target):
		target.play_invalid_feedback()
		refresh_all_prompts()
		return
	var channel := int(_lamp_channels.get(source.lamp_id, -1))
	_create_beam(source, target, _channel_color(channel), channel, false)
	source.set_lamp_state(STATE_LOCKED)
	_lamp_channels[target.lamp_id] = channel
	if target.has_method("assign_runtime_channel"):
		target.call("assign_runtime_channel", channel, _channel_color(channel))
	_actual_route_by_channel[channel].append(String(target.lamp_id))
	if target.role == ROLE_DESTINATION:
		if _route_matches_correct_path(channel):
			target.set_lamp_state(STATE_COMPLETED)
			_completed_channels[channel] = true
		else:
			target.set_lamp_state(STATE_INCORRECT)
			_incorrect_channels[channel] = true
	else:
		target.set_lamp_state(STATE_AVAILABLE)
	target.play_success_feedback()
	_selected_lamp = null
	selection_changed.emit()
	puzzle_state_changed.emit()
	refresh_all_prompts()
	_check_completion()

func _cancel_selection() -> void:
	if _selected_lamp == null:
		return
	_selected_lamp.set_lamp_state(STATE_AVAILABLE)
	_selected_lamp = null
	selection_changed.emit()
	refresh_all_prompts()

func _is_valid_target_for_selected(lamp: Node) -> bool:
	if _selected_lamp == null or lamp == null or lamp == _selected_lamp:
		return false
	if lamp.role == ROLE_SOURCE:
		return false
	if lamp.state != STATE_INACTIVE:
		return false
	if _lamp_channels.has(lamp.lamp_id):
		return false
	var channel := int(_lamp_channels.get(_selected_lamp.lamp_id, -1))
	if channel < 0:
		return false
	if lamp.role == ROLE_DESTINATION:
		return _destination_belongs_to_channel(lamp, channel)
	return lamp.role == ROLE_RELAY

func _destination_belongs_to_channel(lamp: Node, channel: int) -> bool:
	var path: Array = channel_paths[channel] if channel >= 0 and channel < channel_paths.size() else []
	return not path.is_empty() and StringName(path[path.size() - 1]) == lamp.lamp_id

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
				lamp.configure(self, _channel_color(channel), channel)
				if lamp.role == ROLE_SOURCE:
					lamp.channel_id = channel

func _reset_channel(channel: int, initial_setup: bool) -> void:
	if channel < 0 or channel >= channel_paths.size():
		return
	if _selected_lamp != null and int(_lamp_channels.get(_selected_lamp.lamp_id, -1)) == channel:
		_selected_lamp = null
	# remove non-initial runtime beams
	if channel < _beams_by_channel.size():
		var kept: Array = []
		for beam in _beams_by_channel[channel]:
			if beam != null and beam.is_initial:
				kept.append(beam)
			elif beam != null:
				beam.queue_free()
		_beams_by_channel[channel] = kept
	# release channel lamps except source and first relay
	var path: Array = channel_paths[channel]
	if path.size() < 2:
		return
	var source_id := StringName(path[0])
	var first_id := StringName(path[1])
	for lamp_id in _lamps_by_id.keys():
		var lamp: Node = _lamps_by_id[lamp_id]
		if int(_lamp_channels.get(lamp.lamp_id, -999)) == channel and lamp.lamp_id != source_id and lamp.lamp_id != first_id:
			_lamp_channels.erase(lamp.lamp_id)
			if lamp.has_method("clear_runtime_channel"):
				lamp.call("clear_runtime_channel")
			lamp.set_lamp_state(STATE_INACTIVE)
	var source: Node = _lamps_by_id.get(source_id)
	var first: Node = _lamps_by_id.get(first_id)
	if source != null:
		_lamp_channels[source.lamp_id] = channel
		source.channel_id = channel
		source.set_lamp_state(STATE_LOCKED)
		if source.has_method("assign_runtime_channel"):
			source.call("assign_runtime_channel", channel, _channel_color(channel))
	if first != null:
		_lamp_channels[first.lamp_id] = channel
		first.set_lamp_state(STATE_AVAILABLE)
		if first.has_method("assign_runtime_channel"):
			first.call("assign_runtime_channel", channel, _channel_color(channel))
	_actual_route_by_channel[channel] = [String(source_id), String(first_id)]
	_completed_channels.erase(channel)
	_incorrect_channels.erase(channel)
	_ensure_initial_beam(channel, source, first, initial_setup)

func _ensure_initial_beam(channel: int, source: Node, first: Node, _initial_setup: bool) -> void:
	if source == null or first == null:
		return
	for beam in _beams_by_channel[channel]:
		if beam != null and beam.is_initial:
			return
	_create_beam(source, first, _channel_color(channel), channel, true)

func _create_beam(source: Node, target: Node, color: Color, channel: int, initial: bool) -> Node:
	var beam: Node = LightRouteBeamScene.new()
	_beam_root.add_child(beam)
	beam.set_metadata(source.lamp_id, target.lamp_id, channel, initial)
	beam.configure_between(source, target, color)
	_beams_by_channel[channel].append(beam)
	return beam

func _route_matches_correct_path(channel: int) -> bool:
	var actual := _actual_route_by_channel[channel]
	var expected: Array = channel_paths[channel]
	if actual.size() != expected.size():
		return false
	for i in range(expected.size()):
		if String(actual[i]) != String(expected[i]):
			return false
	return true

func _can_reset_channel(channel: int) -> bool:
	if channel < 0 or channel >= _actual_route_by_channel.size():
		return false
	return _incorrect_channels.has(channel) or _actual_route_by_channel[channel].size() > 2

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

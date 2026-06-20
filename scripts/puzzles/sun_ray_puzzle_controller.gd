extends Node3D
class_name SunRayPuzzleController

signal sun_ray_completed

const LanternScript := preload("res://scripts/puzzles/sun_ray_lantern_node.gd")
const StreamScript := preload("res://scripts/puzzles/sun_ray_particle_stream.gd")


@export var ray_id: StringName = &"sun"
@export var lantern_paths: Array[NodePath] = []
@export var wrong_segment_hold: float = 0.28
@export var wrong_fade_duration: float = 0.82
@export var particle_count: int = 48

var _lanterns: Array[SunRayLanternNode] = []
var _streams: Array[SunRayParticleStream] = []
var _current_index := 1
var _selected: SunRayLanternNode
var _locked := false
var _completed := false
var _stream_root: Node3D

func _ready() -> void:
	_stream_root = Node3D.new()
	_stream_root.name = "SunRayRuntimeParticleStreams"
	add_child(_stream_root)
	_bind_lanterns()
	reset_to_initial()

func reset_to_initial() -> void:
	_locked = false
	_completed = false
	_selected = null
	_current_index = 1
	for stream in _streams:
		if is_instance_valid(stream):
			stream.queue_free()
	_streams.clear()
	for i in range(_lanterns.size()):
		if i == 0:
			_lanterns[i].set_lantern_state(SunRayLanternNode.LanternState.COMPLETED)
		elif i == 1:
			_lanterns[i].set_lantern_state(SunRayLanternNode.LanternState.ACTIVE_ENDPOINT)
		else:
			_lanterns[i].set_lantern_state(SunRayLanternNode.LanternState.INACTIVE)
	if _lanterns.size() != 6:
		push_error("BLOCKER: Sun Ray requires exactly six lantern nodes; found %d" % _lanterns.size())
		return
	_create_stream(0, 1, true)
	_refresh_prompts()

func can_lantern_be_interacted(lantern: SunRayLanternNode) -> bool:
	if _locked or _completed or lantern == null:
		return false
	var index := _lanterns.find(lantern)
	if index < 0 or index == 0:
		return false
	if _selected == lantern:
		return true
	if _selected == null:
		return index == _current_index and lantern.state == SunRayLanternNode.LanternState.ACTIVE_ENDPOINT
	return index != _current_index and lantern.state == SunRayLanternNode.LanternState.INACTIVE

func get_prompt_text_for_lantern(lantern: SunRayLanternNode) -> String:
	if _selected == lantern:
		return "Отменить выбор"
	if _selected != null and can_lantern_be_interacted(lantern):
		return "Соединить солнечный луч"
	return "Направить солнечный луч"

func debug_route_indices() -> Array[int]:
	var result: Array[int] = []
	for stream in _streams:
		result.append(_lantern_index_by_id(stream.target_id))
	return result

func debug_current_endpoint_index() -> int:
	return _current_index

func debug_lanterns() -> Array[SunRayLanternNode]:
	return _lanterns.duplicate()

func debug_streams() -> Array[SunRayParticleStream]:
	return _streams.duplicate()

func debug_interactions_locked() -> bool:
	return _locked

func debug_is_completed() -> bool:
	return _completed

func _bind_lanterns() -> void:
	_lanterns.clear()
	for path in lantern_paths:
		var visual := get_node_or_null(path) as Node3D
		if visual == null:
			push_error("BLOCKER: required Sun Ray lantern node is missing: %s" % [path])
			continue
		var wrapper := LanternScript.new() as SunRayLanternNode
		wrapper.name = "%s_interaction_anchor" % visual.name
		wrapper.bind_visual_target(visual)
		add_child(wrapper)
		wrapper.configure(self, StringName(visual.name))
		wrapper.interaction_requested.connect(_on_lantern_interaction)
		_lanterns.append(wrapper)
	if _lanterns.size() != 6:
		push_error("BLOCKER: Sun Ray requires exactly six lantern nodes; found %d" % _lanterns.size())

func _on_lantern_interaction(lantern: SunRayLanternNode, _player: Node) -> void:
	if _locked or _completed:
		return
	if not can_lantern_be_interacted(lantern):
		lantern.play_invalid_feedback()
		return
	if _selected == lantern:
		_selected = null
		lantern.set_lantern_state(SunRayLanternNode.LanternState.ACTIVE_ENDPOINT)
		_refresh_prompts()
		return
	if _selected == null:
		_selected = lantern
		lantern.set_lantern_state(SunRayLanternNode.LanternState.SELECTED)
		_refresh_prompts()
		return
	_try_connect(lantern)

func _try_connect(target: SunRayLanternNode) -> void:
	if target == null or target.state != SunRayLanternNode.LanternState.INACTIVE:
		if target != null:
			target.play_invalid_feedback()
		_refresh_prompts()
		return
	var target_index := _lanterns.find(target)
	if target_index < 0 or target_index == _current_index or target_index == 0:
		target.play_invalid_feedback()
		_refresh_prompts()
		return
	var source_index := _current_index
	if _selected == null:
		_selected = _lanterns[source_index]
	var stream := _create_stream(source_index, target_index, false)
	_selected.set_lantern_state(SunRayLanternNode.LanternState.COMPLETED)
	_selected = null
	if target_index == source_index + 1:
		target.play_success_feedback()
		_current_index = target_index
		if _current_index == _lanterns.size() - 1:
			target.set_lantern_state(SunRayLanternNode.LanternState.COMPLETED)
			_complete_puzzle()
		else:
			target.set_lantern_state(SunRayLanternNode.LanternState.ACTIVE_ENDPOINT)
		_refresh_prompts()
	else:
		target.set_lantern_state(SunRayLanternNode.LanternState.RESETTING)
		_start_wrong_reset(stream)

func _create_stream(source_index: int, target_index: int, initial: bool) -> SunRayParticleStream:
	var stream := StreamScript.new() as SunRayParticleStream
	stream.name = "sun_ray_particle_stream_%s_to_%s" % [_lanterns[source_index].lantern_id, _lanterns[target_index].lantern_id]
	stream.particle_count = particle_count
	_stream_root.add_child(stream)
	stream.configure_between(_lanterns[source_index], _lanterns[target_index], _lanterns[source_index].lantern_id, _lanterns[target_index].lantern_id, initial)
	_streams.append(stream)
	return stream

func _start_wrong_reset(_wrong_stream: SunRayParticleStream) -> void:
	_locked = true
	_refresh_prompts()
	await get_tree().create_timer(wrong_segment_hold).timeout
	for i in range(_streams.size() - 1, -1, -1):
		var stream := _streams[i]
		if not stream.is_initial:
			stream.fade_out_and_free(wrong_fade_duration)
			_streams.remove_at(i)
	for i in range(1, _lanterns.size()):
		_lanterns[i].set_lantern_state(SunRayLanternNode.LanternState.RESETTING)
	await get_tree().create_timer(wrong_fade_duration).timeout
	for i in range(_streams.size() - 1, -1, -1):
		if not is_instance_valid(_streams[i]):
			_streams.remove_at(i)
	_current_index = 1
	_selected = null
	for i in range(_lanterns.size()):
		if i == 0:
			_lanterns[i].set_lantern_state(SunRayLanternNode.LanternState.COMPLETED)
		elif i == 1:
			_lanterns[i].set_lantern_state(SunRayLanternNode.LanternState.ACTIVE_ENDPOINT)
		else:
			_lanterns[i].set_lantern_state(SunRayLanternNode.LanternState.INACTIVE)
	_locked = false
	_refresh_prompts()

func _complete_puzzle() -> void:
	if _completed:
		return
	_completed = true
	_locked = true
	sun_ray_completed.emit()

func _refresh_prompts() -> void:
	for lantern in _lanterns:
		lantern.refresh_prompt()

func _lantern_index_by_id(id: StringName) -> int:
	for i in range(_lanterns.size()):
		if _lanterns[i].lantern_id == id:
			return i
	return -1

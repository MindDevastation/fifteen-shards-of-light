extends Node
class_name FoxHeroineAnimationController

signal one_shot_finished(action_name: String)

const IDLE_SWITCH_INTERVAL := 15.0
const IDLE_BASE_WEIGHT := 0.6
const IDLE_PICKUP_WEIGHT := 0.4
const ONE_SHOT_PRIORITY := {
	"jump": 10,
	"cast_1": 20,
	"dance_test": 30,
}
const ONE_SHOT_UNLOCK_MARGIN_SECONDS := 0.2

@export var animation_player_path: NodePath

var _animation_player: AnimationPlayer = null
var _current_action: String = ""
var _idle_elapsed: float = 0.0
var _active_one_shot_action: String = ""
var _active_one_shot_started_at_seconds: float = 0.0
var _active_one_shot_max_duration_seconds: float = 0.0
var _is_dance_loop_active: bool = false


func _ready() -> void:
	_animation_player = get_node_or_null(animation_player_path) as AnimationPlayer
	if _animation_player == null:
		_animation_player = _find_animation_player(get_parent())
	if _animation_player != null and not _animation_player.animation_finished.is_connected(_on_animation_finished):
		_animation_player.animation_finished.connect(_on_animation_finished)


func update_locomotion(action_name: String) -> void:
	_update_one_shot_lock_state()
	if _is_dance_loop_active:
		return
	if _is_busy_with_one_shot():
		return
	play_action(action_name)
	_reset_idle_timer()


func update_idle(delta: float) -> void:
	_update_one_shot_lock_state()
	if _is_dance_loop_active:
		return
	if _is_busy_with_one_shot():
		return

	if _current_action == "" or (_current_action != "idle" and _current_action != "idle_and_pick_up"):
		play_action("idle")
		_idle_elapsed = 0.0
		return

	_idle_elapsed += delta
	if _idle_elapsed < IDLE_SWITCH_INTERVAL:
		return

	_idle_elapsed = 0.0
	if randf() < IDLE_BASE_WEIGHT / (IDLE_BASE_WEIGHT + IDLE_PICKUP_WEIGHT):
		play_action("idle")
	else:
		play_action("idle_and_pick_up")


func play_one_shot(action_name: String, playback_speed: float = 1.0) -> bool:
	if _animation_player == null:
		return false
	_update_one_shot_lock_state()
	if not _can_start_one_shot(action_name):
		return false

	var source_animation_name := FoxHeroineAnimationMap.get_source_for_action(action_name)
	if source_animation_name == "" or not _animation_player.has_animation(source_animation_name):
		return false

	var animation := _animation_player.get_animation(source_animation_name)
	if animation == null:
		return false

	_is_dance_loop_active = false
	_active_one_shot_action = action_name
	_current_action = action_name
	_idle_elapsed = 0.0
	_active_one_shot_started_at_seconds = Time.get_ticks_msec() / 1000.0
	_active_one_shot_max_duration_seconds = max(animation.length / max(playback_speed, 0.001), 0.0) + ONE_SHOT_UNLOCK_MARGIN_SECONDS
	_animation_player.speed_scale = playback_speed
	_animation_player.play(source_animation_name)
	return true


func start_dance_loop() -> bool:
	if _is_dance_loop_active:
		return false
	var started := play_one_shot("dance_test")
	if not started:
		return false
	_is_dance_loop_active = true
	return true


func stop_dance_loop() -> void:
	if not _is_dance_loop_active:
		return
	_is_dance_loop_active = false
	if _active_one_shot_action == "dance_test":
		_clear_active_one_shot()


func is_dancing() -> bool:
	_update_one_shot_lock_state()
	return _is_dance_loop_active


func play_action(action_name: String) -> void:
	if _animation_player == null:
		return
	_update_one_shot_lock_state()

	var source_animation_name := FoxHeroineAnimationMap.get_source_for_action(action_name)
	if source_animation_name == "" or not _animation_player.has_animation(source_animation_name):
		return

	if _current_action == action_name and _animation_player.current_animation == source_animation_name and _animation_player.is_playing():
		return

	_animation_player.speed_scale = 1.0
	_current_action = action_name
	_animation_player.play(source_animation_name)


func is_busy() -> bool:
	_update_one_shot_lock_state()
	return _is_busy_with_one_shot() or _is_dance_loop_active


func _on_animation_finished(animation_name: StringName) -> void:
	if _is_dance_loop_active and _active_one_shot_action == "dance_test":
		var dance_source := FoxHeroineAnimationMap.get_source_for_action("dance_test")
		if String(animation_name) == dance_source and _animation_player != null:
			_animation_player.speed_scale = 1.0
			_animation_player.play(dance_source)
			return

	if _active_one_shot_action == "":
		return

	var finished_action := _active_one_shot_action
	var expected := FoxHeroineAnimationMap.get_source_for_action(finished_action)
	if String(animation_name) != expected:
		return

	_clear_active_one_shot()
	one_shot_finished.emit(finished_action)


func _is_busy_with_one_shot() -> bool:
	return _active_one_shot_action == "dance_test" or _active_one_shot_action == "cast_1" or _active_one_shot_action == "jump"


func _can_start_one_shot(action_name: String) -> bool:
	if _active_one_shot_action == "":
		return true
	if _active_one_shot_action == action_name:
		return false
	return _get_one_shot_priority(action_name) > _get_one_shot_priority(_active_one_shot_action)


func _get_one_shot_priority(action_name: String) -> int:
	return ONE_SHOT_PRIORITY.get(action_name, 0)


func _update_one_shot_lock_state() -> void:
	if _active_one_shot_action == "":
		return

	var expected := FoxHeroineAnimationMap.get_source_for_action(_active_one_shot_action)
	if expected == "":
		_clear_active_one_shot()
		return

	if _animation_player == null:
		_clear_active_one_shot()
		return

	if _animation_player.current_animation != expected:
		_clear_active_one_shot()
		return

	var elapsed_seconds := (Time.get_ticks_msec() / 1000.0) - _active_one_shot_started_at_seconds
	if _active_one_shot_max_duration_seconds > 0.0 and elapsed_seconds > _active_one_shot_max_duration_seconds:
		_clear_active_one_shot()


func _clear_active_one_shot() -> void:
	_active_one_shot_action = ""
	_active_one_shot_started_at_seconds = 0.0
	_active_one_shot_max_duration_seconds = 0.0
	_current_action = ""
	_idle_elapsed = 0.0
	if _animation_player != null:
		_animation_player.speed_scale = 1.0


func _reset_idle_timer() -> void:
	_idle_elapsed = 0.0


func _find_animation_player(node: Node) -> AnimationPlayer:
	if node == null:
		return null
	if node is AnimationPlayer:
		return node as AnimationPlayer
	for child in node.get_children():
		var found := _find_animation_player(child)
		if found != null:
			return found
	return null

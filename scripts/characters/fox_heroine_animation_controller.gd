extends Node
class_name FoxHeroineAnimationController

const IDLE_SWITCH_INTERVAL := 15.0
const IDLE_BASE_WEIGHT := 0.6
const IDLE_PICKUP_WEIGHT := 0.4

@export var animation_player_path: NodePath

var _animation_player: AnimationPlayer = null
var _current_action: String = ""
var _idle_elapsed: float = 0.0
var _active_one_shot_action: String = ""


func _ready() -> void:
	_animation_player = get_node_or_null(animation_player_path) as AnimationPlayer
	if _animation_player == null:
		_animation_player = _find_animation_player(get_parent())
	if _animation_player != null and not _animation_player.animation_finished.is_connected(_on_animation_finished):
		_animation_player.animation_finished.connect(_on_animation_finished)


func update_locomotion(action_name: String) -> void:
	if _is_busy_with_one_shot():
		return
	play_action(action_name)
	_reset_idle_timer()


func update_idle(delta: float) -> void:
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


func play_one_shot(action_name: String) -> void:
	if _animation_player == null:
		return

	var source_animation_name := FoxHeroineAnimationMap.get_source_for_action(action_name)
	if source_animation_name == "" or not _animation_player.has_animation(source_animation_name):
		return

	_active_one_shot_action = action_name
	_current_action = action_name
	_idle_elapsed = 0.0
	_animation_player.play(source_animation_name)


func play_action(action_name: String) -> void:
	if _animation_player == null:
		return

	var source_animation_name := FoxHeroineAnimationMap.get_source_for_action(action_name)
	if source_animation_name == "" or not _animation_player.has_animation(source_animation_name):
		return

	if _current_action == action_name and _animation_player.current_animation == source_animation_name and _animation_player.is_playing():
		return

	_current_action = action_name
	_animation_player.play(source_animation_name)


func is_busy() -> bool:
	return _is_busy_with_one_shot()


func _on_animation_finished(animation_name: StringName) -> void:
	if _active_one_shot_action == "":
		return

	var expected := FoxHeroineAnimationMap.get_source_for_action(_active_one_shot_action)
	if String(animation_name) != expected:
		return

	_active_one_shot_action = ""
	_current_action = ""
	_idle_elapsed = 0.0


func _is_busy_with_one_shot() -> bool:
	return _active_one_shot_action == "dance_test" or _active_one_shot_action == "cast_1" or _active_one_shot_action == "jump"


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

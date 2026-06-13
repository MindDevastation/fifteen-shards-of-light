extends CanvasLayer

@export var target_node: Node3D
@export var world_position := Vector3.ZERO
@export var use_target_node := true
@export var screen_offset := Vector2(0.0, -18.0)
@export var follow_lerp_speed := 18.0

const SHOW_DURATION := 0.22
const HIDE_DURATION := 0.18
const CONFIRM_DURATION := 0.16
const IDLE_BREATHE_SCALE := 0.012
const IDLE_BREATHE_SPEED := 1.4

var _requested_visible := false
var _has_screen_position := false
var _idle_time := 0.0
var _animation_tween: Tween
var _confirm_tween: Tween

@onready var root: Control = $Root
@onready var tracking_root: Control = $Root/TrackingRoot
@onready var animation_root: Control = $Root/TrackingRoot/AnimationRoot
@onready var prompt_root: Control = $Root/TrackingRoot/AnimationRoot/PromptRoot
@onready var prompt_box: HBoxContainer = $Root/TrackingRoot/AnimationRoot/PromptRoot/PromptBox
@onready var keycap_panel: PanelContainer = $Root/TrackingRoot/AnimationRoot/PromptRoot/PromptBox/KeycapPanel
@onready var key_label: Label = $Root/TrackingRoot/AnimationRoot/PromptRoot/PromptBox/KeycapPanel/KeyLabel
@onready var action_label: Label = $Root/TrackingRoot/AnimationRoot/PromptRoot/PromptBox/ActionLabel
@onready var left_decor_line: ColorRect = $Root/TrackingRoot/AnimationRoot/PromptRoot/PromptBox/LeftDecorLine
@onready var right_decor_line: ColorRect = $Root/TrackingRoot/AnimationRoot/PromptRoot/PromptBox/RightDecorLine


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	tracking_root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	animation_root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	prompt_root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	prompt_box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	keycap_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	key_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	action_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	left_decor_line.mouse_filter = Control.MOUSE_FILTER_IGNORE
	right_decor_line.mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false
	animation_root.modulate.a = 0.0
	animation_root.position = Vector2.ZERO
	animation_root.scale = Vector2.ONE * 0.88


func _process(delta: float) -> void:
	_update_screen_position(delta)
	_update_idle_breathe(delta)


func set_target(node: Node3D) -> void:
	target_node = node
	use_target_node = target_node != null


func set_world_position(position: Vector3) -> void:
	world_position = position
	use_target_node = false


func show_prompt() -> void:
	if _requested_visible:
		return

	_requested_visible = true
	visible = _has_screen_position
	_kill_prompt_tweens()
	animation_root.modulate = Color(1.0, 1.0, 1.0, animation_root.modulate.a)
	_animation_tween = create_tween()
	_animation_tween.set_parallel(true)
	_animation_tween.tween_property(animation_root, "modulate:a", 1.0, SHOW_DURATION).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	_animation_tween.tween_property(animation_root, "scale", Vector2.ONE, SHOW_DURATION).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	_animation_tween.tween_property(animation_root, "position", Vector2(0.0, -4.0), SHOW_DURATION).from(Vector2(0.0, 6.0)).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func hide_prompt() -> void:
	if not _requested_visible and animation_root.modulate.a <= 0.0:
		return

	_requested_visible = false
	_kill_prompt_tweens()
	_animation_tween = create_tween()
	_animation_tween.set_parallel(true)
	_animation_tween.tween_property(animation_root, "modulate:a", 0.0, HIDE_DURATION).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	_animation_tween.tween_property(animation_root, "scale", Vector2.ONE * 0.92, HIDE_DURATION).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	_animation_tween.finished.connect(_hide_after_animation)


func play_confirm_and_hide() -> void:
	_requested_visible = false
	visible = _has_screen_position
	_kill_prompt_tweens()
	_confirm_tween = create_tween()
	_confirm_tween.set_parallel(true)
	_confirm_tween.tween_property(animation_root, "modulate", Color(1.18, 1.08, 0.82, 1.0), CONFIRM_DURATION * 0.45).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	_confirm_tween.tween_property(animation_root, "scale", Vector2.ONE * 0.94, CONFIRM_DURATION * 0.45).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	_confirm_tween.chain().tween_property(animation_root, "modulate:a", 0.0, CONFIRM_DURATION * 0.55).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	_confirm_tween.finished.connect(_hide_after_animation)


func _update_screen_position(delta: float) -> void:
	var camera := get_viewport().get_camera_3d()
	var anchor_position := _get_anchor_position()
	_has_screen_position = camera != null and not camera.is_position_behind(anchor_position)

	if not _has_screen_position:
		visible = false
		return

	var prompt_size := _get_prompt_size()
	var centered_position := camera.unproject_position(anchor_position) + screen_offset - prompt_size * 0.5

	if not visible and _requested_visible:
		tracking_root.position = centered_position
		visible = true
	elif _requested_visible:
		var weight := clampf(delta * follow_lerp_speed, 0.0, 1.0)
		tracking_root.position = tracking_root.position.lerp(centered_position, weight)

	visible = _requested_visible or animation_root.modulate.a > 0.0


func _update_idle_breathe(delta: float) -> void:
	if not visible or not _requested_visible:
		return

	_idle_time += delta
	var breathe := 1.0 + sin(_idle_time * IDLE_BREATHE_SPEED) * IDLE_BREATHE_SCALE
	if _animation_tween == null or not _animation_tween.is_running():
		animation_root.scale = Vector2.ONE * breathe


func _get_prompt_size() -> Vector2:
	var prompt_size := prompt_root.size
	var minimum_size := prompt_root.get_combined_minimum_size()
	return Vector2(maxf(prompt_size.x, minimum_size.x), maxf(prompt_size.y, minimum_size.y))


func _get_anchor_position() -> Vector3:
	if use_target_node and is_instance_valid(target_node):
		return target_node.global_position
	return world_position


func _hide_after_animation() -> void:
	if not _requested_visible:
		visible = false
		animation_root.modulate = Color.WHITE
		animation_root.position = Vector2.ZERO


func _kill_prompt_tweens() -> void:
	if _animation_tween != null:
		_animation_tween.kill()
	if _confirm_tween != null:
		_confirm_tween.kill()

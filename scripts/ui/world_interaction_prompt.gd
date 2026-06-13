extends CanvasLayer

@export var target_node: Node3D
@export var world_position := Vector3.ZERO
@export var use_target_node := true
@export var screen_offset := Vector2(0.0, -18.0)
@export var follow_lerp_speed := 18.0

const KEY_FONT_PATH := "res://assets/fonts/cormorant_garamond/CormorantGaramond-SemiBold.otf"
const ACTION_FONT_PATH := "res://assets/fonts/cormorant_garamond/CormorantGaramond-SemiBoldItalic.otf"
const SHOW_DURATION := 0.22
const HIDE_DURATION := 0.18
const CONFIRM_DURATION := 0.16
const IDLE_BREATHE_SCALE := 0.012
const IDLE_BREATHE_SPEED := 1.4

var _requested_visible := false
var _has_screen_position := false
var _idle_time := 0.0
var _base_prompt_position := Vector2.ZERO
var _animation_tween: Tween
var _confirm_tween: Tween

@onready var root: Control = $Root
@onready var prompt_root: Control = $Root/PromptRoot
@onready var prompt_box: HBoxContainer = $Root/PromptRoot/PromptBox
@onready var keycap_panel: PanelContainer = $Root/PromptRoot/PromptBox/KeycapPanel
@onready var key_label: Label = $Root/PromptRoot/PromptBox/KeycapPanel/KeyLabel
@onready var action_label: Label = $Root/PromptRoot/PromptBox/ActionLabel
@onready var left_decor_line: ColorRect = $Root/PromptRoot/PromptBox/LeftDecorLine
@onready var right_decor_line: ColorRect = $Root/PromptRoot/PromptBox/RightDecorLine


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	prompt_root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	prompt_box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	keycap_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	key_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	action_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	left_decor_line.mouse_filter = Control.MOUSE_FILTER_IGNORE
	right_decor_line.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_apply_fonts()
	visible = false
	root.modulate.a = 0.0
	prompt_root.scale = Vector2.ONE * 0.88


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
	_kill_animation_tween()
	_animation_tween = create_tween()
	_animation_tween.set_parallel(true)
	_animation_tween.tween_property(root, "modulate:a", 1.0, SHOW_DURATION).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	_animation_tween.tween_property(prompt_root, "scale", Vector2.ONE, SHOW_DURATION).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	_animation_tween.tween_property(prompt_root, "position", _base_prompt_position + Vector2(0.0, -4.0), SHOW_DURATION).from(_base_prompt_position + Vector2(0.0, 6.0)).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func hide_prompt() -> void:
	if not _requested_visible and root.modulate.a <= 0.0:
		return

	_requested_visible = false
	_kill_animation_tween()
	_animation_tween = create_tween()
	_animation_tween.set_parallel(true)
	_animation_tween.tween_property(root, "modulate:a", 0.0, HIDE_DURATION).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	_animation_tween.tween_property(prompt_root, "scale", Vector2.ONE * 0.92, HIDE_DURATION).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	_animation_tween.finished.connect(_hide_after_animation)


func play_confirm_and_hide() -> void:
	_requested_visible = false
	visible = _has_screen_position
	_kill_animation_tween()
	if _confirm_tween != null:
		_confirm_tween.kill()

	_confirm_tween = create_tween()
	_confirm_tween.set_parallel(true)
	_confirm_tween.tween_property(root, "modulate", Color(1.18, 1.08, 0.82, 1.0), CONFIRM_DURATION * 0.45).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	_confirm_tween.tween_property(prompt_root, "scale", Vector2.ONE * 0.94, CONFIRM_DURATION * 0.45).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	_confirm_tween.chain().tween_property(root, "modulate:a", 0.0, CONFIRM_DURATION * 0.55).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	_confirm_tween.finished.connect(_hide_after_animation)


func _update_screen_position(delta: float) -> void:
	var camera := get_viewport().get_camera_3d()
	var anchor_position := _get_anchor_position()
	_has_screen_position = camera != null and not camera.is_position_behind(anchor_position)

	if not _has_screen_position:
		visible = false
		return

	var viewport_position := camera.unproject_position(anchor_position) + screen_offset
	var prompt_size := prompt_root.size
	if prompt_size == Vector2.ZERO:
		prompt_size = prompt_root.get_combined_minimum_size()
	var centered_position := viewport_position - prompt_size * 0.5

	if not visible and _requested_visible:
		prompt_root.position = centered_position
		visible = true
	elif _requested_visible:
		var weight := clampf(delta * follow_lerp_speed, 0.0, 1.0)
		prompt_root.position = prompt_root.position.lerp(centered_position, weight)

	_base_prompt_position = centered_position
	visible = _requested_visible or root.modulate.a > 0.0


func _update_idle_breathe(delta: float) -> void:
	if not visible or not _requested_visible:
		return

	_idle_time += delta
	var breathe := 1.0 + sin(_idle_time * IDLE_BREATHE_SPEED) * IDLE_BREATHE_SCALE
	if _animation_tween == null or not _animation_tween.is_running():
		prompt_root.scale = Vector2.ONE * breathe


func _get_anchor_position() -> Vector3:
	if use_target_node and is_instance_valid(target_node):
		return target_node.global_position
	return world_position


func _hide_after_animation() -> void:
	if not _requested_visible:
		visible = false
		root.modulate = Color.WHITE


func _kill_animation_tween() -> void:
	if _animation_tween != null:
		_animation_tween.kill()


func _apply_fonts() -> void:
	var key_font := FontFile.new()
	if key_font.load_dynamic_font(KEY_FONT_PATH) == OK:
		key_label.label_settings.font = key_font

	var action_font := FontFile.new()
	if action_font.load_dynamic_font(ACTION_FONT_PATH) == OK:
		action_label.label_settings.font = action_font

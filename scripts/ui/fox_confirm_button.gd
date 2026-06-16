extends TextureButton
class_name FoxConfirmButton

signal fox_confirmed

enum VisualState { DISABLED, IDLE, HOVER, PRESSED, KEYBOARD_FOCUS }

const IDLE_TEXTURE := preload("res://assets/ui/shard_reward_overlay/button_idle.png")
const HOVER_TEXTURE := preload("res://assets/ui/shard_reward_overlay/button_hovered.png")
const PRESSED_TEXTURE := preload("res://assets/ui/shard_reward_overlay/button_pressed.png")
const DISABLED_ALPHA := 0.58
const PRESS_OFFSET := Vector2(0.0, 4.0)

var _mouse_inside := false
var _keyboard_focus := false
var _base_position := Vector2.ZERO
var _visual_state := VisualState.DISABLED

func _ready() -> void:
	texture_normal = IDLE_TEXTURE
	texture_hover = HOVER_TEXTURE
	texture_pressed = PRESSED_TEXTURE
	texture_disabled = IDLE_TEXTURE
	ignore_texture_size = true
	stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
	pivot_offset = size * 0.5
	_base_position = position
	pressed.connect(func(): fox_confirmed.emit())
	mouse_entered.connect(func(): _mouse_inside = true; _sync_visual_state())
	mouse_exited.connect(func(): _mouse_inside = false; _sync_visual_state())
	button_down.connect(func(): _sync_visual_state(true))
	button_up.connect(func(): _sync_visual_state(false))
	focus_entered.connect(func(): _keyboard_focus = true; _sync_visual_state())
	focus_exited.connect(func(): _keyboard_focus = false; _sync_visual_state())
	_sync_visual_state()

func set_enabled(enabled: bool) -> void:
	disabled = not enabled
	if enabled:
		_update_mouse_inside()
	_sync_visual_state()

func reset_visuals() -> void:
	button_pressed = false
	position = _base_position
	scale = Vector2.ONE
	modulate = Color.WHITE
	_update_mouse_inside()
	_sync_visual_state()

func set_base_position(value: Vector2) -> void:
	_base_position = value
	position = value

func get_visual_state() -> VisualState:
	return _visual_state

func _sync_visual_state(force_pressed := false) -> void:
	if disabled:
		_apply_state(VisualState.DISABLED)
	elif force_pressed or button_pressed:
		_apply_state(VisualState.PRESSED)
	elif _mouse_inside:
		_apply_state(VisualState.HOVER)
	elif _keyboard_focus:
		_apply_state(VisualState.KEYBOARD_FOCUS)
	else:
		_apply_state(VisualState.IDLE)

func _apply_state(state: VisualState) -> void:
	_visual_state = state
	texture_normal = HOVER_TEXTURE if state == VisualState.HOVER else IDLE_TEXTURE
	texture_focused = HOVER_TEXTURE if state == VisualState.KEYBOARD_FOCUS else IDLE_TEXTURE
	match state:
		VisualState.DISABLED:
			texture_normal = IDLE_TEXTURE; modulate = Color(1, 1, 1, DISABLED_ALPHA); scale = Vector2.ONE; position = _base_position
		VisualState.IDLE:
			modulate = Color.WHITE; scale = Vector2.ONE; position = _base_position
		VisualState.HOVER:
			modulate = Color.WHITE; scale = Vector2.ONE * 1.03; position = _base_position
		VisualState.PRESSED:
			texture_normal = PRESSED_TEXTURE; modulate = Color.WHITE; scale = Vector2.ONE * 0.95; position = _base_position + PRESS_OFFSET
		VisualState.KEYBOARD_FOCUS:
			modulate = Color(1.0, 0.96, 0.88, 1.0); scale = Vector2.ONE * 1.025; position = _base_position

func _update_mouse_inside() -> void:
	_mouse_inside = Rect2(Vector2.ZERO, size).has_point(get_local_mouse_position())

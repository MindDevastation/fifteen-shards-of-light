extends TextureButton
class_name FoxConfirmButton

signal fox_confirmed

enum VisualState { DISABLED, IDLE, HOVER, PRESSED, KEYBOARD_FOCUS }

const IDLE_TEXTURE: Texture2D = preload("res://assets/ui/shard_reward_overlay/button_idle.png")
const HOVER_TEXTURE: Texture2D = preload("res://assets/ui/shard_reward_overlay/button_hovered.png")
const PRESSED_TEXTURE: Texture2D = preload("res://assets/ui/shard_reward_overlay/button_pressed.png")
const DISABLED_ALPHA := 0.58
const PRESS_OFFSET := Vector2(0.0, 4.0)

var _mouse_inside := false
var _keyboard_focus := false
var _base_position := Vector2.ZERO
var _visual_state := VisualState.DISABLED

func _ready() -> void:
	_apply_display_texture(IDLE_TEXTURE)
	ignore_texture_size = true
	stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
	pivot_offset = size * 0.5
	_base_position = position
	pressed.connect(func(): fox_confirmed.emit())
	mouse_entered.connect(func(): _update_mouse_inside(); _sync_visual_state())
	mouse_exited.connect(func(): _mouse_inside = false; _sync_visual_state())
	button_down.connect(func(): _sync_visual_state(true))
	button_up.connect(func(): _sync_visual_state(false))
	focus_entered.connect(func(): _keyboard_focus = true; _sync_visual_state())
	focus_exited.connect(func(): _keyboard_focus = false; _sync_visual_state())
	_configure_click_mask()
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
	match state:
		VisualState.DISABLED:
			_apply_display_texture(IDLE_TEXTURE)
			modulate = Color(1, 1, 1, DISABLED_ALPHA)
			scale = Vector2.ONE
			position = _base_position
		VisualState.IDLE:
			_apply_display_texture(IDLE_TEXTURE)
			modulate = Color.WHITE
			scale = Vector2.ONE
			position = _base_position
		VisualState.HOVER:
			_apply_display_texture(HOVER_TEXTURE)
			modulate = Color.WHITE
			scale = Vector2.ONE * 1.03
			position = _base_position
		VisualState.PRESSED:
			_apply_display_texture(PRESSED_TEXTURE)
			modulate = Color.WHITE
			scale = Vector2.ONE * 0.95
			position = _base_position + PRESS_OFFSET
		VisualState.KEYBOARD_FOCUS:
			_apply_display_texture(IDLE_TEXTURE)
			modulate = Color(1.0, 0.96, 0.88, 1.0)
			scale = Vector2.ONE * 1.025
			position = _base_position

func _apply_display_texture(texture: Texture2D) -> void:
	texture_normal = texture
	texture_hover = texture
	texture_pressed = texture
	texture_focused = texture
	texture_disabled = IDLE_TEXTURE

func _configure_click_mask() -> void:
	if IDLE_TEXTURE == null:
		return
	var image: Image = IDLE_TEXTURE.get_image()
	if image == null:
		return
	var click_mask := BitMap.new()
	click_mask.create_from_image_alpha(image, 0.12)
	texture_click_mask = click_mask

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_update_mouse_inside()
		_sync_visual_state()

func _update_mouse_inside() -> void:
	_mouse_inside = _is_mouse_over_visible_texture()

func _is_mouse_over_visible_texture() -> bool:
	var local_pos := get_local_mouse_position()
	if not Rect2(Vector2.ZERO, size).has_point(local_pos):
		return false
	if texture_click_mask == null or IDLE_TEXTURE == null:
		return true
	var texture_size := Vector2(IDLE_TEXTURE.get_width(), IDLE_TEXTURE.get_height())
	if texture_size.x <= 0.0 or texture_size.y <= 0.0 or size.x <= 0.0 or size.y <= 0.0:
		return false
	var draw_scale := minf(size.x / texture_size.x, size.y / texture_size.y)
	var drawn_size := texture_size * draw_scale
	var draw_origin := (size - drawn_size) * 0.5
	var texture_pos := (local_pos - draw_origin) / draw_scale
	if texture_pos.x < 0.0 or texture_pos.y < 0.0 or texture_pos.x >= texture_size.x or texture_pos.y >= texture_size.y:
		return false
	return texture_click_mask.get_bitv(Vector2i(int(texture_pos.x), int(texture_pos.y)))

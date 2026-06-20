extends Control
class_name LevelFinaleOverlay

const FoxConfirmButtonType = preload(
	"res://scripts/ui/fox_confirm_button.gd"
)

signal closed

enum TextRevealState {
	HIDDEN,
	REVEALING,
	REVEALED,
}

const MATTE_VEIL_COLOR := Color(0.032, 0.021, 0.018, 0.62)
const WARM_WASH_COLOR := Color(0.34, 0.15, 0.075, 0.14)
const TEXT_COLOR := Color(1.0, 0.92, 0.72, 1.0)
const TEXT_OUTLINE_COLOR := Color(0.10, 0.035, 0.015, 0.96)
const VINE_OUTER_COLOR := Color(1.0, 0.62, 0.18, 0.24)
const VINE_MAIN_COLOR := Color(1.0, 0.67, 0.26, 0.90)
const VINE_INNER_COLOR := Color(1.0, 0.92, 0.70, 0.98)
const BRANCH_WIDTHS := Vector3(9.0, 4.2, 1.4)
const REWARD_FONT: FontFile = preload("res://assets/fonts/cormorant_garamond/CormorantGaramond-SemiBoldItalic.otf")
const VINE_LEAF_TEXTURE: Texture2D = preload("res://assets/ui/shard_reward_overlay/vine_leaf.png")
const LEAF_STEM_ANCHOR_UV := Vector2(0.235, 0.855)
const MAX_TEXT_LINES := 6
const BASE_VIEWPORT_HEIGHT := 1080.0
const BASE_MAX_FONT_SIZE := 72.0
const ABSOLUTE_MIN_FONT_SIZE := 24
const ABSOLUTE_MAX_FONT_SIZE := 96
const FRAME_WIDTH_RATIO := 0.84
const FRAME_HEIGHT_RATIO := 0.84
const TEXT_AREA_WIDTH_RATIO := 0.84
const TEXT_AREA_HEIGHT_RATIO := 0.82
const TEXT_AREA_VERTICAL_BIAS_RATIO := -0.025
const FINALE_LAYOUT_DIAGNOSTICS := false

@export var text_start_delay: float = 0.72
@export var line_reveal_duration: float = 4.6
@export var line_reveal_stagger: float = 0.55
@export var vine_duration: float = 3.7
@export var atmosphere_open_duration: float = 0.42
@export var text_close_duration: float = 1.00
@export var vine_close_duration: float = 1.55
@export var atmosphere_close_duration: float = 1.45

var _full_text := ""
var _can_confirm := false
var _closed_emitted := false
var _left_complete := false
var _right_complete := false
var _text_complete := false
var _left_progress := 0.0
var _right_progress := 0.0
var _left_points := PackedVector2Array()
var _right_points := PackedVector2Array()
var _branch_data: Array[Dictionary] = []
var _leaf_data: Array[Dictionary] = []
var _line_masks: Array[Control] = []
var _line_labels: Array[RichTextLabel] = []
var _frame_rect := Rect2()
var _text_safe_rect := Rect2()
var _emblem_reserved_rect := Rect2()
var _text_block_rect := Rect2()
var _selected_font_size := 0
var _text_reveal_state := TextRevealState.HIDDEN
var _text_reveal_generation := 0
var _resize_relayout_pending := false
var _active_tweens: Array[Tween] = []
var _text_reveal_tweens: Array[Tween] = []

@onready var atmosphere: Control = $Atmosphere
@onready var matte_veil: ColorRect = $Atmosphere/MatteVeil
@onready var warm_wash: ColorRect = $Atmosphere/WarmWash
@onready var vine_canvas: Node2D = $VineCanvas
@onready var left_lines: Array[Line2D] = [$VineCanvas/LeftVine/OuterGlow, $VineCanvas/LeftVine/MainGold, $VineCanvas/LeftVine/InnerIvory]
@onready var right_lines: Array[Line2D] = [$VineCanvas/RightVine/OuterGlow, $VineCanvas/RightVine/MainGold, $VineCanvas/RightVine/InnerIvory]
@onready var branch_layer: Node2D = $VineCanvas/BranchLayer
@onready var leaf_layer: Node2D = $VineCanvas/LeafLayer
@onready var left_tip_glow: Polygon2D = $VineCanvas/LeftTipGlow
@onready var right_tip_glow: Polygon2D = $VineCanvas/RightTipGlow
@onready var text_root: Control = $TextRoot
@onready var fox_button: FoxConfirmButtonType = (
	$FoxConfirmButton as FoxConfirmButtonType
)

func _ready() -> void:
	add_to_group(&"mouse_blocking_ui")
	hide()
	mouse_filter = Control.MOUSE_FILTER_STOP
	matte_veil.color = MATTE_VEIL_COLOR
	warm_wash.color = WARM_WASH_COLOR
	_configure_lines()
	_create_text_lines()
	_configure_tip_glows()
	fox_button.fox_confirmed.connect(_close_once)
	if not get_viewport().size_changed.is_connected(_on_viewport_size_changed):
		get_viewport().size_changed.connect(_on_viewport_size_changed)
	_reset_visuals()

func show_finale_text(text: String) -> bool:
	if visible and not _closed_emitted:
		return false
	_full_text = text
	_closed_emitted = false
	_can_confirm = false
	_left_complete = false
	_right_complete = false
	_text_complete = false
	_text_reveal_state = TextRevealState.HIDDEN
	_kill_tweens()
	_reset_visuals()
	show()
	mouse_filter = Control.MOUSE_FILTER_STOP
	_apply_responsive_geometry()
	if not _full_text.is_empty():
		_layout_text_lines(_responsive_scale(), true)
	_build_vines()
	_start_opening_animation()
	_start_text_reveal_sequence()
	return true

func _unhandled_input(event: InputEvent) -> void:
	if visible and _can_confirm and (event.is_action_pressed("ui_accept")):
		accept_event()
		_close_once()

func _start_opening_animation() -> void:
	var tween := _track_tween(create_tween())
	tween.set_parallel(true)
	tween.tween_property(atmosphere, "modulate:a", 1.0, atmosphere_open_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_method(_set_left_progress, 0.0, 1.0, vine_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_method(_set_right_progress, 0.0, 1.0, vine_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(func(): _left_complete = true; _right_complete = true; _try_enable_button())

func _start_text_reveal_sequence(delay_before_start: float = text_start_delay) -> void:
	_text_reveal_generation += 1
	var generation := _text_reveal_generation
	_text_reveal_state = TextRevealState.REVEALING
	_text_complete = false
	_can_confirm = false
	fox_button.set_enabled(false)
	_reveal_text_async(generation, delay_before_start)

func _reveal_text_async(generation: int, delay_before_start: float) -> void:
	if delay_before_start > 0.0:
		await get_tree().create_timer(delay_before_start).timeout
		if generation != _text_reveal_generation:
			return
	if not visible or _closed_emitted:
		return
	text_root.modulate.a = 1.0
	var tween := _track_text_reveal_tween(create_tween())
	tween.set_parallel(true)
	for i in range(_line_masks.size()):
		if generation != _text_reveal_generation:
			return
		var mask := _line_masks[i]
		if not mask.visible:
			continue
		var label := _line_labels[i]
		var visible_line_count := _visible_line_mask_count()
		var effective_stagger := minf(line_reveal_stagger, 2.4 / maxf(float(visible_line_count - 1), 1.0))
		var delay := float(i) * effective_stagger
		var final_x := mask.size.x
		mask.clip_contents = true
		mask.size.x = 0.0
		tween.tween_property(mask, "size:x", final_x, line_reveal_duration).set_delay(delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.tween_property(label, "position:y", float(label.get_meta("settled_y", label.position.y)), line_reveal_duration * 0.72).set_delay(delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.tween_property(label, "modulate:a", 1.0, line_reveal_duration * 0.86).set_delay(delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	if generation != _text_reveal_generation:
		return
	_text_reveal_tweens.erase(tween)
	_text_complete = true
	_apply_fully_revealed_text_state()
	_try_enable_button()

func _try_enable_button() -> void:
	if _left_complete and _right_complete and _text_complete and not _closed_emitted:
		_can_confirm = true
		fox_button.set_enabled(true)
		fox_button.grab_focus()

func _close_once() -> void:
	if _closed_emitted or not _can_confirm:
		return
	_closed_emitted = true
	_can_confirm = false
	fox_button.set_enabled(false)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	var tween := _track_tween(create_tween())
	tween.set_parallel(true)
	tween.tween_property(fox_button, "scale", Vector2.ONE * 0.95, 0.14).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(fox_button, "modulate:a", 0.0, 0.18).set_delay(0.08)
	tween.tween_property(text_root, "modulate:a", 0.0, text_close_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_method(_set_left_progress, _left_progress, 0.0, vine_close_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_method(_set_right_progress, _right_progress, 0.0, vine_close_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(vine_canvas, "modulate:a", 0.0, vine_close_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(atmosphere, "modulate:a", 0.0, atmosphere_close_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(func():
		text_root.modulate.a = 0.0
		vine_canvas.modulate.a = 0.0
		atmosphere.modulate.a = 0.0
		fox_button.modulate.a = 0.0
		mouse_filter = Control.MOUSE_FILTER_IGNORE
		hide()
		closed.emit()
	)

func _reset_visuals() -> void:
	_cancel_text_reveal_tweens()
	_text_reveal_state = TextRevealState.HIDDEN
	_selected_font_size = 0
	_text_block_rect = Rect2()
	atmosphere.modulate.a = 0.0
	vine_canvas.modulate.a = 1.0
	text_root.modulate.a = 0.0
	fox_button.modulate.a = 1.0
	fox_button.scale = Vector2.ONE
	fox_button.set_enabled(false)
	_set_left_progress(0.0)
	_set_right_progress(0.0)
	_reset_line_masks()
	_clear_branches_and_leaves()

func _apply_responsive_geometry() -> void:
	_update_frame_and_text_safe_rect()
	_update_button_layout()
	_update_emblem_reserved_rect()

func _update_button_layout() -> void:
	var vp := _viewport_size()
	var button_size := clampf(vp.y * 0.152, 96.0, 164.0)
	fox_button.size = Vector2.ONE * button_size
	fox_button.position = Vector2((vp.x - button_size) * 0.5, vp.y * 0.795)
	fox_button.set_base_position(fox_button.position)
	fox_button.pivot_offset = fox_button.size * 0.5

func _apply_responsive_layout_for_resize(previous_state: int) -> void:
	_apply_responsive_geometry()
	if _full_text.is_empty():
		_reset_line_masks()
		_text_reveal_state = TextRevealState.HIDDEN
		return
	match previous_state:
		TextRevealState.REVEALED:
			if _layout_text_lines(_responsive_scale(), false):
				_apply_fully_revealed_text_state()
		TextRevealState.REVEALING:
			if _layout_text_lines(_responsive_scale(), true):
				_restart_text_reveal_after_resize()
		TextRevealState.HIDDEN:
			_layout_text_lines(_responsive_scale(), true)

func _on_viewport_size_changed() -> void:
	if _resize_relayout_pending:
		return
	_resize_relayout_pending = true
	call_deferred("_apply_deferred_viewport_relayout")

func _apply_deferred_viewport_relayout() -> void:
	_resize_relayout_pending = false
	var previous_state := _text_reveal_state
	var had_text := not _full_text.is_empty()
	if previous_state == TextRevealState.REVEALING:
		_cancel_text_reveal_tweens()
	_apply_responsive_layout_for_resize(previous_state)
	if visible and had_text:
		_build_vines()
		queue_redraw()

func _restart_text_reveal_after_resize() -> void:
	_start_text_reveal_sequence(0.0)

func _apply_fully_revealed_text_state() -> void:
	for i in range(_line_labels.size()):
		var label := _line_labels[i]
		var mask := _line_masks[i]
		if not mask.visible:
			continue
		label.visible = true
		label.modulate.a = 1.0
		label.position.y = float(label.get_meta("settled_y", label.position.y))
	_text_reveal_state = TextRevealState.REVEALED

func _responsive_scale() -> float:
	return clampf(_viewport_size().y / BASE_VIEWPORT_HEIGHT, 0.5, 1.5)

func _layout_text_lines(scale_factor: float, initially_hidden: bool = true) -> bool:
	var layout := _layout_finale_text(_full_text, scale_factor)
	var lines := layout["lines"] as Array[String]
	var font_size := int(layout["font_size"])
	if not bool(layout.get("valid", true)) or font_size < 0:
		push_error("LevelFinaleOverlay: text cannot fit inside the responsive text area.")
		_selected_font_size = 0
		_text_block_rect = Rect2()
		_reset_line_masks()
		return false
	var glyph_height := _glyph_visual_height(font_size)
	var reveal_offset := _reveal_start_offset(font_size)
	var mask_height := glyph_height + reveal_offset
	var line_gap := _line_gap(font_size)
	var line_advance := mask_height + line_gap
	var total_height := mask_height * float(lines.size()) + line_gap * float(maxi(0, lines.size() - 1))
	var start_y := _text_safe_rect.position.y + (_text_safe_rect.size.y - total_height) * 0.5
	_selected_font_size = font_size
	_text_block_rect = Rect2(Vector2(_text_safe_rect.position.x, start_y), Vector2(_text_safe_rect.size.x, total_height))
	_reset_line_masks()
	for i in range(lines.size()):
		var label := _line_labels[i]
		_configure_label(label, font_size)
		label.text = "[center][i]%s[/i][/center]" % _bbcode_escape(lines[i])
		var measured_width := REWARD_FONT.get_string_size(lines[i], HORIZONTAL_ALIGNMENT_LEFT, -1.0, font_size).x
		var horizontal_padding := _horizontal_text_padding(font_size)
		var vertical_padding := _vertical_text_padding(font_size)
		var mask_width := measured_width + horizontal_padding * 2.0
		label.position = Vector2(horizontal_padding, vertical_padding + reveal_offset if initially_hidden else vertical_padding)
		label.scale = Vector2.ONE
		label.set_meta("settled_y", vertical_padding)
		label.size = Vector2(maxf(1.0, measured_width), glyph_height)
		label.visible = true
		label.modulate.a = 0.0 if initially_hidden else 1.0
		var mask := _line_masks[i]
		mask.visible = true
		mask.clip_contents = true
		mask.position = Vector2(
			_text_safe_rect.position.x + (_text_safe_rect.size.x - mask_width) * 0.5,
			start_y + line_advance * float(i)
		)
		mask.size = Vector2(mask_width, mask_height)
	return true

func _layout_finale_text(text: String, scale_factor: float) -> Dictionary:
	var normalized := _normalize_text(text)
	var lines: Array[String] = []
	if normalized.contains("\n"):
		for part in normalized.split("\n", false):
			lines.append(part)
	else:
		var wrap_size := _responsive_max_font_size(_viewport_size())
		lines = _word_wrap(normalized.replace("\n", " "), wrap_size, MAX_TEXT_LINES, scale_factor)
	if lines.is_empty() or lines.size() > MAX_TEXT_LINES:
		_log_finale_layout_diagnostics(normalized.length(), -1, lines.size(), false, false, -1)
		return {"lines": [], "font_size": -1, "valid": false}
	var selected_size := _find_largest_fitting_font_size(lines, _viewport_size(), scale_factor)
	_log_finale_layout_diagnostics(
		normalized.length(),
		_responsive_max_font_size(_viewport_size()),
		lines.size(),
		selected_size >= 0 and _lines_fit_width(lines, selected_size, scale_factor),
		selected_size >= 0 and _lines_fit_height(lines, selected_size, scale_factor),
		selected_size
	)
	if selected_size < 0:
		return {"lines": [], "font_size": -1, "valid": false}
	return {"lines": lines, "font_size": selected_size, "valid": true}

func _word_wrap(text: String, font_size: int, max_lines: int, scale_factor: float) -> Array[String]:
	var words: PackedStringArray = text.split(" ", false)
	if words.is_empty():
		return []
	var lines: Array[String] = []
	var current := ""
	for word in words:
		var candidate := word if current.is_empty() else current + " " + word
		if _line_visual_width(candidate, font_size) <= _text_safe_rect.size.x or current.is_empty():
			current = candidate
		else:
			lines.append(current)
			current = word
	if not current.is_empty():
		lines.append(current)
	if lines.size() <= max_lines:
		return lines
	var compact: Array[String] = []
	var per_line := int(ceil(float(words.size()) / float(max_lines)))
	for i in range(0, words.size(), per_line):
		compact.append(" ".join(words.slice(i, mini(i + per_line, words.size()))))
	return compact

func _find_largest_fitting_font_size(lines: Array[String], viewport_size: Vector2, scale_factor: float) -> int:
	var maximum_size := _responsive_max_font_size(viewport_size)
	for font_size in range(maximum_size, ABSOLUTE_MIN_FONT_SIZE - 1, -1):
		if _lines_fit(lines, font_size, scale_factor):
			return font_size
	return -1

func _responsive_max_font_size(viewport_size: Vector2) -> int:
	var resolution_scale := minf(viewport_size.x / 1920.0, viewport_size.y / BASE_VIEWPORT_HEIGHT)
	return clampi(int(round(BASE_MAX_FONT_SIZE * resolution_scale)), ABSOLUTE_MIN_FONT_SIZE, ABSOLUTE_MAX_FONT_SIZE)

func _lines_fit(lines: Array[String], font_size: int, scale_factor: float) -> bool:
	return _lines_fit_width(lines, font_size, scale_factor) and _lines_fit_height(lines, font_size, scale_factor)

func _lines_fit_width(lines: Array[String], font_size: int, _scale_factor: float) -> bool:
	if lines.is_empty() or lines.size() > MAX_TEXT_LINES:
		return false
	for line in lines:
		if _line_visual_width(line, font_size) > _text_safe_rect.size.x:
			return false
	return true

func _lines_fit_height(lines: Array[String], font_size: int, _scale_factor: float) -> bool:
	if lines.is_empty() or lines.size() > MAX_TEXT_LINES:
		return false
	var glyph_height := _glyph_visual_height(font_size)
	var reveal_offset := _reveal_start_offset(font_size)
	var mask_height := glyph_height + reveal_offset
	var line_gap := _line_gap(font_size)
	var total_height := mask_height * float(lines.size()) + line_gap * float(maxi(0, lines.size() - 1))
	return total_height <= _text_safe_rect.size.y

func _log_finale_layout_diagnostics(text_length: int, candidate_font_size: int, line_count: int, fit_by_width: bool, fit_by_height: bool, selected_font_size: int) -> void:
	if not FINALE_LAYOUT_DIAGNOSTICS:
		return
	print("finale text length=%d candidate font size=%d line count=%d fit by width=%s fit by height=%s selected font size=%d" % [text_length, candidate_font_size, line_count, fit_by_width, fit_by_height, selected_font_size])

func _line_visual_width(line: String, font_size: int) -> float:
	var measured := REWARD_FONT.get_string_size(line, HORIZONTAL_ALIGNMENT_LEFT, -1.0, font_size).x
	return measured + _horizontal_text_padding(font_size) * 2.0

func _glyph_visual_height(font_size: int) -> float:
	return (
		REWARD_FONT.get_height(font_size)
		+ float(_outline_size(font_size)) * 2.0
		+ absf(float(_shadow_offset_y(font_size)))
		+ _vertical_text_padding(font_size) * 2.0
	)

func _horizontal_text_padding(font_size: int) -> float:
	var italic_margin := clampf(float(font_size) * 0.22, 10.0, 20.0)
	return italic_margin + float(_outline_size(font_size)) + absf(float(_shadow_offset_x(font_size)))

func _vertical_text_padding(font_size: int) -> float:
	return clampf(float(font_size) * 0.025, 1.0, 3.0)

func _reveal_start_offset(font_size: int) -> float:
	return clampf(float(font_size) * 0.025, 1.0, 3.0)

func _line_gap(font_size: int) -> float:
	return clampf(float(font_size) * 0.035, 1.0, 3.0)

func _outline_size(font_size: int) -> int:
	return clampi(int(round(float(font_size) * 0.075)), 2, 6)

func _shadow_offset_x(font_size: int) -> int:
	return clampi(int(round(float(font_size) * 0.035)), 1, 3)

func _shadow_offset_y(font_size: int) -> int:
	return clampi(int(round(float(font_size) * 0.035)), 1, 3)

func _visible_line_mask_count() -> int:
	var count := 0
	for mask in _line_masks:
		if mask.visible:
			count += 1
	return count

func _calculate_frame_rect(viewport_size: Vector2) -> Rect2:
	var frame_size := Vector2(viewport_size.x * FRAME_WIDTH_RATIO, viewport_size.y * FRAME_HEIGHT_RATIO)
	return Rect2((viewport_size - frame_size) * 0.5, frame_size)

func _calculate_text_safe_rect(frame_rect: Rect2) -> Rect2:
	var text_area_size := Vector2(
		frame_rect.size.x * TEXT_AREA_WIDTH_RATIO,
		frame_rect.size.y * TEXT_AREA_HEIGHT_RATIO
	)
	var centered_position := frame_rect.position + (frame_rect.size - text_area_size) * 0.5
	centered_position.y += frame_rect.size.y * TEXT_AREA_VERTICAL_BIAS_RATIO
	return Rect2(centered_position, text_area_size)

func _update_frame_and_text_safe_rect() -> void:
	_frame_rect = _calculate_frame_rect(_viewport_size())
	_text_safe_rect = _calculate_text_safe_rect(_frame_rect)
	_update_emblem_reserved_rect()

func _update_emblem_reserved_rect() -> void:
	var emblem_size := Vector2(_frame_rect.size.x * 0.28, _frame_rect.size.y * 0.16)
	_emblem_reserved_rect = Rect2(
		Vector2(_frame_rect.position.x + (_frame_rect.size.x - emblem_size.x) * 0.5, _frame_rect.end.y - emblem_size.y),
		emblem_size
	)

func debug_frame_rect() -> Rect2:
	return _frame_rect

func debug_text_safe_rect() -> Rect2:
	return _text_safe_rect

func debug_line_masks() -> Array[Control]:
	return _line_masks

func debug_selected_font_size() -> int:
	return _selected_font_size

func debug_text_block_rect() -> Rect2:
	return _text_block_rect

func debug_emblem_reserved_rect() -> Rect2:
	return _emblem_reserved_rect

func debug_text_reveal_state() -> int:
	return _text_reveal_state

func debug_text_reveal_generation() -> int:
	return _text_reveal_generation

func debug_text_reveal_tween_count() -> int:
	return _text_reveal_tweens.size()

func debug_resize_relayout_pending() -> bool:
	return _resize_relayout_pending

func _build_vines() -> void:
	_clear_branches_and_leaves()
	var vp := _viewport_size()
	_update_frame_and_text_safe_rect()
	var center_x := vp.x * 0.5
	var fox_top := Vector2(center_x, fox_button.position.y + 12.0)
	var overlap := Vector2(0, 12.0)
	var left := _frame_rect.position.x
	var right := _frame_rect.position.x + _frame_rect.size.x
	var top := _frame_rect.position.y
	var bottom := _frame_rect.position.y + _frame_rect.size.y
	var radius := vp.y * 0.065
	_left_points = _build_side_curve(fox_top + overlap, Vector2(center_x - vp.x * 0.16, bottom), Vector2(left, bottom - radius), Vector2(left, top + radius), Vector2(center_x, top), -1)
	_right_points = _build_side_curve(fox_top + overlap, Vector2(center_x + vp.x * 0.16, bottom), Vector2(right, bottom - radius), Vector2(right, top + radius), Vector2(center_x, top), 1)
	_build_branch_geometry()
	_build_leaf_geometry()
	_set_left_progress(0.0)
	_set_right_progress(0.0)

func _build_side_curve(start: Vector2, lower_center: Vector2, lower_corner: Vector2, upper_corner: Vector2, top_center: Vector2, side: int) -> PackedVector2Array:
	var curve := Curve2D.new()
	curve.bake_interval = 7.0
	curve.add_point(start, Vector2.ZERO, Vector2(side * 70.0, -20.0))
	curve.add_point(lower_center, Vector2(-side * 90.0, 35.0), Vector2(-side * 95.0, 15.0))
	curve.add_point(lower_corner, Vector2(side * 55.0, 60.0), Vector2(-side * 25.0, -85.0))
	curve.add_point(upper_corner, Vector2(0.0, 120.0), Vector2(side * 32.0, -55.0))
	curve.add_point(top_center, Vector2(-side * 125.0, -8.0), Vector2.ZERO)
	return curve.get_baked_points()

func _set_left_progress(value: float) -> void:
	_left_progress = clampf(value, 0.0, 1.0)
	_set_line_points(left_lines, _truncate_points(_left_points, _left_progress))
	_update_tip(left_tip_glow, _left_points, _left_progress)
	_update_decorations()

func _set_right_progress(value: float) -> void:
	_right_progress = clampf(value, 0.0, 1.0)
	_set_line_points(right_lines, _truncate_points(_right_points, _right_progress))
	_update_tip(right_tip_glow, _right_points, _right_progress)
	_update_decorations()

func _set_line_points(lines: Array[Line2D], points: PackedVector2Array) -> void:
	for line in lines:
		line.points = points

func _truncate_points(points: PackedVector2Array, progress: float) -> PackedVector2Array:
	if points.is_empty() or progress <= 0.0:
		return PackedVector2Array()
	return points.slice(0, clampi(int(ceil(float(points.size()) * progress)), 1, points.size()))

func _build_branch_geometry() -> void:
	for side in [-1, 1]:
		for i in range(12):
			var progress := 0.13 + float(i) * 0.068
			var data := _make_branch(side, progress, i)
			_branch_data.append(data)
			if i % 2 == 0:
				_branch_data.append(_make_curl(side, progress + 0.018, i))

func _make_branch(side: int, progress: float, index: int) -> Dictionary:
	var path: PackedVector2Array = _left_points if side < 0 else _right_points
	var sample: Dictionary = _sample_path(path, progress, 0.0)
	var length := _viewport_size().y * lerpf(0.04, 0.09, _hash_01(index, 17))
	var sample_angle: float = float(sample["angle"])
	var sample_position: Vector2 = sample["position"] as Vector2
	var normal: Vector2 = Vector2(-sin(sample_angle), cos(sample_angle)) * float(side)
	var tangent := Vector2(cos(sample_angle), sin(sample_angle))
	var end: Vector2 = sample_position + normal * length + tangent * length * 0.18 - Vector2(0, length * 0.18)
	var curve := Curve2D.new()
	curve.bake_interval = 4.0
	curve.add_point(sample_position, Vector2.ZERO, normal * 22.0)
	curve.add_point(sample_position + normal * length * 0.46 - tangent * length * 0.20, -normal * 9.0, normal * 18.0)
	curve.add_point(end, -normal * 20.0 + tangent * 12.0, Vector2.ZERO)
	var lines: Array[Line2D] = [_create_branch_line(BRANCH_WIDTHS.x, VINE_OUTER_COLOR), _create_branch_line(BRANCH_WIDTHS.y, VINE_MAIN_COLOR), _create_branch_line(BRANCH_WIDTHS.z, VINE_INNER_COLOR)]
	for branch_line: Line2D in lines:
		branch_layer.add_child(branch_line)
	return {"side": side, "progress": progress, "points": curve.get_baked_points(), "lines": lines}

func _make_curl(side: int, progress: float, index: int) -> Dictionary:
	var path: PackedVector2Array = _left_points if side < 0 else _right_points
	var sample: Dictionary = _sample_path(path, clampf(progress, 0.05, 0.93), 0.0)
	var sample_angle: float = float(sample["angle"])
	var center: Vector2 = sample["position"] as Vector2
	var normal: Vector2 = Vector2(-sin(sample_angle), cos(sample_angle)) * float(side)
	var radius := _viewport_size().y * lerpf(0.012, 0.024, _hash_01(index, 91))
	var points := PackedVector2Array()
	for step in range(24):
		var t := float(step) / 23.0
		var angle := t * TAU * 0.82 * float(side) + float(index) * 0.21
		var outward := normal * radius * (1.0 + t * 1.5)
		points.append(center + outward + Vector2(cos(angle), sin(angle)) * radius * t)
	var lines: Array[Line2D] = [_create_branch_line(BRANCH_WIDTHS.x * 0.62, VINE_OUTER_COLOR), _create_branch_line(BRANCH_WIDTHS.y * 0.62, VINE_MAIN_COLOR), _create_branch_line(BRANCH_WIDTHS.z, VINE_INNER_COLOR)]
	for branch_line: Line2D in lines:
		branch_layer.add_child(branch_line)
	return {"side": side, "progress": progress, "points": points, "lines": lines}

func _build_leaf_geometry() -> void:
	for side in [-1, 1]:
		var side_branches: Array[Dictionary] = []
		for branch_data in _branch_data:
			var branch := branch_data as Dictionary
			if int(branch.get("side", side)) == side:
				side_branches.append(branch)
		for i in range(24):
			if side_branches.is_empty():
				continue
			var branch_index := clampi(int(i / 2), 0, side_branches.size() - 1)
			var branch := side_branches[branch_index]
			var branch_points := branch.get("points", PackedVector2Array()) as PackedVector2Array
			var leaf_progress := 0.48 + 0.36 * _hash_01(i, side + 43)
			var sample: Dictionary = _sample_path(branch_points, leaf_progress, 0.0)
			var leaf := Sprite2D.new()
			leaf.texture = VINE_LEAF_TEXTURE
			leaf.centered = true
			var leaf_angle := float(sample["angle"]) + (0.55 if i % 2 == 0 else -0.55) * float(side)
			var branch_position := sample["position"] as Vector2
			var texture_size := leaf.texture.get_size()
			var local_texture_anchor := (LEAF_STEM_ANCHOR_UV - Vector2(0.5, 0.5)) * texture_size
			leaf.position = branch_position
			leaf.rotation = leaf_angle
			leaf.scale = Vector2.ZERO
			leaf.modulate = Color(1.0, 0.84, 0.52, 0.0)
			leaf_layer.add_child(leaf)
			_leaf_data.append({
				"node": leaf,
				"side": side,
				"progress": float(branch.get("progress", 0.0)) + 0.035,
				"scale": lerpf(0.64, 1.08, _hash_01(i, side + 31)),
				"branch_position": branch_position,
				"local_texture_anchor": local_texture_anchor,
			})

func _update_decorations() -> void:
	for data in _branch_data:
		var progress := _left_progress if int(data["side"]) < 0 else _right_progress
		var local := clampf((progress - float(data["progress"])) / 0.14, 0.0, 1.0)
		var points: PackedVector2Array = _truncate_points(data["points"] as PackedVector2Array, local)
		for line in data["lines"]:
			(line as Line2D).points = points
	for data in _leaf_data:
		var progress := _left_progress if int(data["side"]) < 0 else _right_progress
		var local := clampf((progress - float(data["progress"])) / 0.10, 0.0, 1.0)
		var eased := sin(local * PI * 0.5)
		var leaf := data["node"] as Sprite2D
		var final_scale := Vector2.ONE * eased * float(data["scale"]) * 0.048 * _viewport_size().y / 1024.0
		var local_texture_anchor := data["local_texture_anchor"] as Vector2
		var scaled_anchor := Vector2(local_texture_anchor.x * final_scale.x, local_texture_anchor.y * final_scale.y)
		leaf.scale = final_scale
		leaf.position = (data["branch_position"] as Vector2) - scaled_anchor.rotated(leaf.rotation)
		leaf.modulate.a = eased * 0.92

func _sample_path(points: PackedVector2Array, progress: float, offset: float) -> Dictionary:
	if points.size() < 2:
		return {"position": Vector2.ZERO, "angle": 0.0}
	var index := clampi(int(round(float(points.size() - 1) * progress)), 1, points.size() - 2)
	var prev := points[index - 1]
	var next := points[index + 1]
	var direction := (next - prev).normalized()
	var normal := Vector2(-direction.y, direction.x)
	return {"position": points[index] + normal * offset, "angle": direction.angle()}

func _update_tip(tip: Polygon2D, points: PackedVector2Array, progress: float) -> void:
	if points.is_empty() or progress <= 0.0 or progress >= 0.96:
		tip.modulate.a = 0.0
		return
	var visible: PackedVector2Array = _truncate_points(points, progress)
	tip.position = visible[visible.size() - 1]
	tip.modulate.a = 0.55

func _configure_lines() -> void:
	var widths: Array[float] = [20.0, 9.0, 3.0]
	var colors: Array[Color] = [
		VINE_OUTER_COLOR,
		VINE_MAIN_COLOR,
		VINE_INNER_COLOR,
	]

	_configure_line_group(left_lines, widths, colors)
	_configure_line_group(right_lines, widths, colors)

func _configure_line_group(lines: Array[Line2D], widths: Array[float], colors: Array[Color]) -> void:
	for i: int in range(lines.size()):
		var line: Line2D = lines[i]
		line.width = widths[i]
		line.default_color = colors[i]
		line.antialiased = true
		line.joint_mode = Line2D.LINE_JOINT_ROUND
		line.begin_cap_mode = Line2D.LINE_CAP_ROUND
		line.end_cap_mode = Line2D.LINE_CAP_ROUND

func _create_branch_line(width: float, color: Color) -> Line2D:
	var line := Line2D.new()
	line.width = width
	line.default_color = color
	line.antialiased = true
	line.joint_mode = Line2D.LINE_JOINT_ROUND
	line.begin_cap_mode = Line2D.LINE_CAP_ROUND
	line.end_cap_mode = Line2D.LINE_CAP_ROUND
	return line

func _create_text_lines() -> void:
	for i in range(MAX_TEXT_LINES):
		var mask := Control.new()
		mask.name = "LineMask%d" % (i + 1)
		mask.clip_contents = false
		mask.mouse_filter = Control.MOUSE_FILTER_IGNORE
		text_root.add_child(mask)
		var label := RichTextLabel.new()
		label.name = "LineText%d" % (i + 1)
		label.bbcode_enabled = true
		label.fit_content = true
		label.scroll_active = false
		label.autowrap_mode = TextServer.AUTOWRAP_OFF
		label.mouse_filter = Control.MOUSE_FILTER_IGNORE
		mask.add_child(label)
		_line_masks.append(mask)
		_line_labels.append(label)

func _reset_line_masks() -> void:
	for i in range(_line_masks.size()):
		_line_masks[i].visible = false
		_line_masks[i].size.x = 0.0
		_line_labels[i].text = ""
		_line_labels[i].visible = false
		_line_labels[i].position.y = _reveal_start_offset(ABSOLUTE_MIN_FONT_SIZE)
		_line_labels[i].modulate.a = 0.0

func _configure_label(label: RichTextLabel, font_size: int) -> void:
	label.add_theme_font_override("normal_font", REWARD_FONT)
	label.add_theme_font_override("italics_font", REWARD_FONT)
	label.add_theme_font_override("bold_italics_font", REWARD_FONT)
	label.add_theme_font_size_override("normal_font_size", font_size)
	label.add_theme_font_size_override("italics_font_size", font_size)
	label.add_theme_font_size_override("bold_italics_font_size", font_size)
	label.add_theme_color_override("default_color", TEXT_COLOR)
	label.add_theme_color_override("font_outline_color", TEXT_OUTLINE_COLOR)
	label.add_theme_constant_override("outline_size", _outline_size(font_size))
	label.add_theme_color_override("font_shadow_color", Color(0.55, 0.24, 0.08, 0.42))
	label.add_theme_constant_override("shadow_offset_x", _shadow_offset_x(font_size))
	label.add_theme_constant_override("shadow_offset_y", _shadow_offset_y(font_size))

func _configure_tip_glows() -> void:
	var poly := PackedVector2Array([Vector2(0, -10), Vector2(10, 0), Vector2(0, 10), Vector2(-10, 0)])
	for tip in [left_tip_glow, right_tip_glow]:
		tip.polygon = poly
		tip.modulate.a = 0.0

func _clear_branches_and_leaves() -> void:
	for child in branch_layer.get_children():
		child.queue_free()
	for child in leaf_layer.get_children():
		child.queue_free()
	_branch_data.clear()
	_leaf_data.clear()

func _track_tween(tween: Tween) -> Tween:
	_active_tweens.append(tween)
	return tween

func _track_text_reveal_tween(tween: Tween) -> Tween:
	_text_reveal_tweens.append(tween)
	return _track_tween(tween)

func _cancel_text_reveal_tweens() -> void:
	for tween in _text_reveal_tweens:
		if tween != null and tween.is_valid():
			tween.kill()
	_text_reveal_tweens.clear()
	_text_reveal_generation += 1

func _kill_tweens() -> void:
	for tween in _active_tweens:
		if tween != null and tween.is_valid():
			tween.kill()
	_active_tweens.clear()
	_text_reveal_tweens.clear()

func _normalize_text(value: String) -> String:
	var result := ""
	var previous_space := false
	for i in range(value.length()):
		var c := value.substr(i, 1)
		if c == "\n":
			if not result.ends_with("\n"):
				result += "\n"
			previous_space = true
		elif c == " " or c == "\t":
			if not previous_space:
				result += " "
			previous_space = true
		else:
			result += c
			previous_space = false
	return result.strip_edges()

func _bbcode_escape(value: String) -> String:
	return value.replace("[", "[lb]").replace("]", "[rb]")

func _viewport_size() -> Vector2:
	if size.x >= 320.0 and size.y >= 240.0:
		return size
	var viewport_size := get_viewport_rect().size
	if viewport_size.x >= 320.0 and viewport_size.y >= 240.0:
		return viewport_size
	return Vector2(1920, 1080)

func _hash_01(index: int, salt: int) -> float:
	var v := int(index * 92821 + salt * 68917 + 1337)
	v = int((v ^ (v >> 13)) * 1274126177)
	v = v ^ (v >> 16)
	return float(abs(v % 10000)) / 10000.0

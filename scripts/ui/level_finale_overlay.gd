extends Control
class_name LevelFinaleOverlay

signal closed

const MATTE_VEIL_COLOR := Color(0.032, 0.021, 0.018, 0.62)
const WARM_WASH_COLOR := Color(0.34, 0.15, 0.075, 0.14)
const TEXT_COLOR := Color(1.0, 0.92, 0.72, 1.0)
const TEXT_OUTLINE_COLOR := Color(0.10, 0.035, 0.015, 0.96)
const VINE_OUTER_COLOR := Color(1.0, 0.62, 0.18, 0.24)
const VINE_MAIN_COLOR := Color(1.0, 0.67, 0.26, 0.90)
const VINE_INNER_COLOR := Color(1.0, 0.92, 0.70, 0.98)
const REWARD_FONT := preload("res://assets/fonts/cormorant_garamond/CormorantGaramond-SemiBoldItalic.otf")
const VINE_LEAF_TEXTURE := preload("res://assets/ui/shard_reward_overlay/vine_leaf.png")
const FOX_BUTTON_SCENE := preload("res://scenes/ui/components/FoxConfirmButton.tscn")

@export var text_start_delay: float = 0.72
@export var line_reveal_duration: float = 1.48
@export var line_reveal_stagger: float = 0.46
@export var vine_duration: float = 1.45
@export var close_duration: float = 0.24

var _full_text := ""
var _can_confirm := false
var _closed_emitted := false
var _vine_complete := false
var _text_complete := false
var _vine_progress := 0.0
var _frame_points := PackedVector2Array()
var _line_masks: Array[Control] = []
var _line_labels: Array[RichTextLabel] = []
var _leaves: Array[Sprite2D] = []

@onready var atmosphere: Control = $Atmosphere
@onready var matte_veil: ColorRect = $Atmosphere/MatteVeil
@onready var warm_wash: ColorRect = $Atmosphere/WarmWash
@onready var vine_canvas: Node2D = $VineCanvas
@onready var outer_line: Line2D = $VineCanvas/OuterGlow
@onready var main_line: Line2D = $VineCanvas/MainGold
@onready var inner_line: Line2D = $VineCanvas/InnerIvory
@onready var branch_layer: Node2D = $VineCanvas/Branches
@onready var leaf_layer: Node2D = $VineCanvas/Leaves
@onready var text_root: Control = $TextRoot
@onready var fox_button: FoxConfirmButton = $FoxConfirmButton

func _ready() -> void:
	hide()
	mouse_filter = Control.MOUSE_FILTER_STOP
	matte_veil.color = MATTE_VEIL_COLOR
	warm_wash.color = WARM_WASH_COLOR
	_configure_lines()
	_create_text_lines()
	fox_button.fox_confirmed.connect(_close_once)
	_reset_visuals()

func show_finale_text(text: String) -> void:
	_full_text = text
	_closed_emitted = false
	_can_confirm = false
	_vine_complete = false
	_text_complete = false
	_reset_visuals()
	show()
	_apply_responsive_layout()
	_build_frame()
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(atmosphere, "modulate:a", 1.0, 0.10)
	tween.tween_method(_set_vine_progress, 0.0, 1.0, vine_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(func(): _vine_complete = true; _try_enable_button())
	_reveal_text_async()

func _unhandled_input(event: InputEvent) -> void:
	if visible and _can_confirm and (event.is_action_pressed("ui_accept") or event.is_action_pressed("interact")):
		accept_event()
		_close_once()

func _reveal_text_async() -> void:
	await get_tree().create_timer(text_start_delay).timeout
	if not visible:
		return
	text_root.modulate.a = 1.0
	var tween := create_tween()
	tween.set_parallel(true)
	for i in range(_line_masks.size()):
		var mask := _line_masks[i]
		if not mask.visible:
			continue
		var label := _line_labels[i]
		var delay := float(i) * line_reveal_stagger
		tween.tween_property(mask, "size:x", label.size.x + 18.0, line_reveal_duration).set_delay(delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(label, "modulate:a", 1.0, 0.22).set_delay(delay)
	await tween.finished
	_text_complete = true
	_try_enable_button()

func _try_enable_button() -> void:
	if _vine_complete and _text_complete:
		_can_confirm = true
		fox_button.set_enabled(true)
		fox_button.grab_focus()

func _close_once() -> void:
	if _closed_emitted or not _can_confirm:
		return
	_closed_emitted = true
	_can_confirm = false
	fox_button.set_enabled(false)
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(atmosphere, "modulate:a", 0.0, close_duration)
	tween.tween_property(vine_canvas, "modulate:a", 0.0, close_duration)
	tween.tween_property(text_root, "modulate:a", 0.0, close_duration)
	tween.tween_property(fox_button, "modulate:a", 0.0, close_duration)
	tween.finished.connect(func(): hide(); closed.emit())

func _reset_visuals() -> void:
	atmosphere.modulate.a = 0.0
	vine_canvas.modulate.a = 1.0
	text_root.modulate.a = 0.0
	fox_button.modulate.a = 1.0
	fox_button.set_enabled(false)
	_set_vine_progress(0.0)
	for mask in _line_masks:
		mask.visible = false
		mask.size.x = 0.0
	for label in _line_labels:
		label.text = ""
		label.modulate.a = 0.0
	for leaf in _leaves:
		leaf.queue_free()
	_leaves.clear()

func _apply_responsive_layout() -> void:
	var vp := get_viewport_rect().size
	if vp == Vector2.ZERO:
		vp = Vector2(1920, 1080)
	var scale_factor := clampf(vp.y / 1080.0, 0.72, 1.08)
	fox_button.size = Vector2.ONE * clampf(vp.y * 0.152, 120.0, 164.0)
	fox_button.position = Vector2((vp.x - fox_button.size.x) * 0.5, vp.y * 0.78)
	fox_button.set_base_position(fox_button.position)
	fox_button.pivot_offset = fox_button.size * 0.5
	var lines := _full_text.split("\n", false)
	var line_height := 58.0 * scale_factor
	var total_height := line_height * float(lines.size())
	var top := vp.y * 0.44 - total_height * 0.5
	for i in range(_line_masks.size()):
		if i >= lines.size():
			continue
		var label := _line_labels[i]
		_configure_label(label, int(round(42.0 * scale_factor)))
		label.text = "[center][i]%s[/i][/center]" % lines[i].replace("[", "[lb]").replace("]", "[rb]")
		var width := min(vp.x * 0.62, REWARD_FONT.get_string_size(lines[i], HORIZONTAL_ALIGNMENT_LEFT, -1, int(round(42.0 * scale_factor))).x + 26.0)
		label.size = Vector2(width, line_height)
		_line_masks[i].position = Vector2((vp.x - width) * 0.5, top + line_height * i)
		_line_masks[i].size = Vector2(0.0, line_height)
		_line_masks[i].visible = true

func _build_frame() -> void:
	var vp := get_viewport_rect().size
	var left := vp.x * 0.18
	var right := vp.x * 0.82
	var top := vp.y * 0.16
	var bottom := vp.y * 0.74
	var radius := vp.y * 0.07
	var curve := Curve2D.new()
	curve.bake_interval = 8.0
	curve.add_point(Vector2(vp.x * 0.5, bottom), Vector2.ZERO, Vector2(-vp.x * 0.16, 0))
	curve.add_point(Vector2(left, bottom - radius), Vector2(vp.x * 0.08, vp.y * 0.03), Vector2(-vp.x * 0.04, -vp.y * 0.10))
	curve.add_point(Vector2(left, top + radius), Vector2(0, vp.y * 0.14), Vector2(0, -vp.y * 0.07))
	curve.add_point(Vector2(left + radius, top), Vector2(-vp.x * 0.05, 0), Vector2(vp.x * 0.12, 0))
	curve.add_point(Vector2(right - radius, top), Vector2(-vp.x * 0.12, 0), Vector2(vp.x * 0.05, 0))
	curve.add_point(Vector2(right, top + radius), Vector2(0, -vp.y * 0.07), Vector2(0, vp.y * 0.14))
	curve.add_point(Vector2(right, bottom - radius), Vector2(0, -vp.y * 0.14), Vector2(-vp.x * 0.08, vp.y * 0.03))
	curve.add_point(Vector2(vp.x * 0.5, bottom), Vector2(vp.x * 0.16, 0), Vector2.ZERO)
	_frame_points = curve.get_baked_points()
	_build_branches_and_leaves()

func _set_vine_progress(value: float) -> void:
	_vine_progress = clampf(value, 0.0, 1.0)
	var count := clampi(int(ceil(_frame_points.size() * _vine_progress)), 0, _frame_points.size())
	var pts := _frame_points.slice(0, count) if count > 0 else PackedVector2Array()
	outer_line.points = pts
	main_line.points = pts
	inner_line.points = pts
	for i in range(_leaves.size()):
		var threshold := float(i + 1) / float(_leaves.size() + 1)
		var a := clampf((_vine_progress - threshold) / 0.10, 0.0, 1.0)
		_leaves[i].scale = Vector2.ONE * a * 0.055 * get_viewport_rect().size.y / 1024.0
		_leaves[i].modulate.a = a * 0.92

func _build_branches_and_leaves() -> void:
	for child in branch_layer.get_children(): child.queue_free()
	for child in leaf_layer.get_children(): child.queue_free()
	_leaves.clear()
	if _frame_points.is_empty(): return
	for i in range(10):
		var t := float(i + 1) / 11.0
		var index := clampi(int(_frame_points.size() * t), 0, _frame_points.size() - 1)
		var leaf := Sprite2D.new()
		leaf.texture = VINE_LEAF_TEXTURE
		leaf.centered = true
		leaf.position = _frame_points[index]
		leaf.rotation = (-0.7 if i % 2 == 0 else 0.7)
		leaf.modulate = Color(1.0, 0.84, 0.52, 0.0)
		leaf_layer.add_child(leaf)
		_leaves.append(leaf)

func _configure_lines() -> void:
	for line in [outer_line, main_line, inner_line]:
		line.antialiased = true
		line.joint_mode = Line2D.LINE_JOINT_ROUND
		line.begin_cap_mode = Line2D.LINE_CAP_ROUND
		line.end_cap_mode = Line2D.LINE_CAP_ROUND
	outer_line.width = 20; main_line.width = 9; inner_line.width = 3
	outer_line.default_color = VINE_OUTER_COLOR
	main_line.default_color = VINE_MAIN_COLOR
	inner_line.default_color = VINE_INNER_COLOR

func _create_text_lines() -> void:
	for i in range(3):
		var mask := Control.new(); mask.clip_contents = true; mask.mouse_filter = Control.MOUSE_FILTER_IGNORE; text_root.add_child(mask)
		var label := RichTextLabel.new(); label.bbcode_enabled = true; label.fit_content = true; label.scroll_active = false; label.mouse_filter = Control.MOUSE_FILTER_IGNORE; mask.add_child(label)
		_line_masks.append(mask); _line_labels.append(label)

func _configure_label(label: RichTextLabel, font_size: int) -> void:
	label.add_theme_font_override("normal_font", REWARD_FONT)
	label.add_theme_font_override("italics_font", REWARD_FONT)
	label.add_theme_font_size_override("normal_font_size", font_size)
	label.add_theme_font_size_override("italics_font_size", font_size)
	label.add_theme_color_override("default_color", TEXT_COLOR)
	label.add_theme_color_override("font_outline_color", TEXT_OUTLINE_COLOR)
	label.add_theme_constant_override("outline_size", 5)

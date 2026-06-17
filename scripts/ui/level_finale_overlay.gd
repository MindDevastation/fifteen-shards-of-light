extends Control
class_name LevelFinaleOverlay

const FoxConfirmButtonType = preload(
	"res://scripts/ui/fox_confirm_button.gd"
)

signal closed

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

@export var text_start_delay: float = 0.72
@export var line_reveal_duration: float = 1.48
@export var line_reveal_stagger: float = 0.46
@export var vine_duration: float = 1.55
@export var atmosphere_open_duration: float = 0.42
@export var text_close_duration: float = 0.40
@export var vine_close_duration: float = 0.62
@export var atmosphere_close_duration: float = 0.58

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
var _active_tweens: Array[Tween] = []

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
	_kill_tweens()
	_reset_visuals()
	show()
	mouse_filter = Control.MOUSE_FILTER_STOP
	_apply_responsive_layout()
	_build_vines()
	_start_opening_animation()
	_reveal_text_async()
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

func _reveal_text_async() -> void:
	await get_tree().create_timer(text_start_delay).timeout
	if not visible or _closed_emitted:
		return
	text_root.modulate.a = 1.0
	var tween := _track_tween(create_tween())
	tween.set_parallel(true)
	for i in range(_line_masks.size()):
		var mask := _line_masks[i]
		if not mask.visible:
			continue
		var label := _line_labels[i]
		var delay := float(i) * line_reveal_stagger
		tween.tween_property(mask, "size:x", label.size.x + 18.0, line_reveal_duration).set_delay(delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(label, "modulate:a", 1.0, 0.24).set_delay(delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await tween.finished
	_text_complete = true
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
	atmosphere.modulate.a = 0.0
	vine_canvas.modulate.a = 1.0
	text_root.modulate.a = 0.0
	fox_button.modulate.a = 1.0
	fox_button.scale = Vector2.ONE
	fox_button.set_enabled(false)
	_set_left_progress(0.0)
	_set_right_progress(0.0)
	for mask in _line_masks:
		mask.visible = false
		mask.size.x = 0.0
	for label in _line_labels:
		label.text = ""
		label.modulate.a = 0.0
	_clear_branches_and_leaves()

func _apply_responsive_layout() -> void:
	var vp := _viewport_size()
	var scale_factor := clampf(vp.y / 1080.0, 0.72, 1.08)
	var button_size := clampf(vp.y * 0.152, 120.0, 164.0)
	fox_button.size = Vector2.ONE * button_size
	fox_button.position = Vector2((vp.x - button_size) * 0.5, vp.y * 0.775)
	fox_button.set_base_position(fox_button.position)
	fox_button.pivot_offset = fox_button.size * 0.5
	_layout_text_lines(scale_factor)

func _layout_text_lines(scale_factor: float) -> void:
	var layout := _layout_finale_text(_full_text, scale_factor)
	var lines := layout["lines"] as Array[String]
	var font_size := int(layout["font_size"])
	var vp := _viewport_size()
	var line_height := 58.0 * scale_factor
	var total_height := line_height * float(lines.size())
	var start_y := vp.y * 0.42 - total_height * 0.5
	_reset_line_masks()
	for i in range(lines.size()):
		var label := _line_labels[i]
		_configure_label(label, font_size)
		label.text = "[center][i]%s[/i][/center]" % _bbcode_escape(lines[i])
		var measured: Vector2 = REWARD_FONT.get_string_size(lines[i], HORIZONTAL_ALIGNMENT_LEFT, -1.0, font_size)
		var width := minf(measured.x + 26.0 * scale_factor, _safe_text_width(scale_factor))
		label.position = Vector2.ZERO
		label.size = Vector2(width, line_height)
		label.modulate.a = 0.0
		var mask := _line_masks[i]
		mask.visible = true
		mask.position = Vector2((vp.x - width) * 0.5, start_y + line_height * float(i))
		mask.size = Vector2(0.0, line_height)

func _layout_finale_text(text: String, scale_factor: float) -> Dictionary:
	var normalized := _normalize_text(text)
	for base_size in [48, 44, 40]:
		var font_size := int(round(float(base_size) * scale_factor))
		var explicit := normalized.split("\n", false)
		var result: Array[String] = []
		if explicit.size() > 1:
			for part in explicit:
				result.append_array(_word_wrap(part, font_size, maxi(1, 3 - result.size()), scale_factor))
		else:
			result = _word_wrap(normalized.replace("\n", " "), font_size, 3, scale_factor)
		if result.size() <= 3 and _lines_fit(result, font_size, scale_factor):
			return {"lines": result, "font_size": font_size}
	var fallback := _word_wrap(normalized.replace("\n", " "), int(round(40.0 * scale_factor)), 3, scale_factor)
	while fallback.size() > 3:
		fallback[2] = "%s %s" % [fallback[2], fallback.pop_back()]
	for i in range(fallback.size()):
		fallback[i] = fallback[i].strip_edges()
	return {"lines": fallback, "font_size": int(round(40.0 * scale_factor))}

func _word_wrap(text: String, font_size: int, max_lines: int, scale_factor: float) -> Array[String]:
	var words: PackedStringArray = text.split(" ", false)
	if words.is_empty():
		return []
	var lines: Array[String] = []
	var current := ""
	for word in words:
		var candidate := word if current.is_empty() else current + " " + word
		if REWARD_FONT.get_string_size(candidate, HORIZONTAL_ALIGNMENT_LEFT, -1.0, font_size).x <= _safe_text_width(scale_factor) or current.is_empty():
			current = candidate
		else:
			lines.append(current)
			current = word
	if not current.is_empty():
		lines.append(current)
	if lines.size() > max_lines:
		var compact: Array[String] = []
		var per_line := int(ceil(float(words.size()) / float(max_lines)))
		for i in range(0, words.size(), per_line):
			compact.append(" ".join(words.slice(i, mini(i + per_line, words.size()))))
		return compact
	return lines

func _lines_fit(lines: Array[String], font_size: int, scale_factor: float) -> bool:
	if lines.size() > 3:
		return false
	for line in lines:
		if REWARD_FONT.get_string_size(line, HORIZONTAL_ALIGNMENT_LEFT, -1.0, font_size).x > _safe_text_width(scale_factor):
			return false
	return true

func _safe_text_width(scale_factor: float) -> float:
	return clampf(_viewport_size().x * 0.48, 720.0 * scale_factor, 860.0 * scale_factor)

func _build_vines() -> void:
	_clear_branches_and_leaves()
	var vp := _viewport_size()
	var center_x := vp.x * 0.5
	var fox_top := Vector2(center_x, fox_button.position.y + 12.0)
	var overlap := Vector2(0, 12.0)
	var left := vp.x * 0.17
	var right := vp.x * 0.83
	var top := vp.y * 0.16
	var bottom := vp.y * 0.72
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
		for i in range(4):
			var progress := 0.22 + float(i) * 0.17
			var data := _make_branch(side, progress, i)
			_branch_data.append(data)

func _make_branch(side: int, progress: float, index: int) -> Dictionary:
	var path: PackedVector2Array = _left_points if side < 0 else _right_points
	var sample: Dictionary = _sample_path(path, progress, 0.0)
	var length := _viewport_size().y * lerpf(0.045, 0.072, _hash_01(index, 17))
	var sample_angle: float = float(sample["angle"])
	var sample_position: Vector2 = sample["position"] as Vector2
	var normal: Vector2 = Vector2(-sin(sample_angle), cos(sample_angle)) * float(side)
	var end: Vector2 = sample_position + normal * length + Vector2(0, -length * 0.35)
	var curve := Curve2D.new()
	curve.bake_interval = 6.0
	curve.add_point(sample_position, Vector2.ZERO, normal * 18.0)
	curve.add_point((sample_position + end) * 0.5 + Vector2(0, -8.0), -normal * 12.0, normal * 12.0)
	curve.add_point(end, -normal * 16.0, Vector2.ZERO)
	var lines: Array[Line2D] = [_create_branch_line(BRANCH_WIDTHS.x, VINE_OUTER_COLOR), _create_branch_line(BRANCH_WIDTHS.y, VINE_MAIN_COLOR), _create_branch_line(BRANCH_WIDTHS.z, VINE_INNER_COLOR)]
	for branch_line: Line2D in lines:
		branch_layer.add_child(branch_line)
	return {"side": side, "progress": progress, "points": curve.get_baked_points(), "lines": lines}

func _build_leaf_geometry() -> void:
	for side in [-1, 1]:
		for i in range(8):
			var progress := 0.14 + float(i) * 0.095
			var side_offset := (10.0 if i % 2 == 0 else -10.0) * float(side)
			var path: PackedVector2Array = _left_points if side < 0 else _right_points
			var sample: Dictionary = _sample_path(path, progress, side_offset)
			var leaf := Sprite2D.new()
			leaf.texture = VINE_LEAF_TEXTURE
			leaf.centered = true
			leaf.position = sample["position"] as Vector2
			leaf.rotation = float(sample["angle"]) + (0.45 if i % 2 == 0 else -0.45) * float(side)
			leaf.scale = Vector2.ZERO
			leaf.modulate = Color(1.0, 0.84, 0.52, 0.0)
			leaf_layer.add_child(leaf)
			_leaf_data.append({"node": leaf, "side": side, "progress": progress, "scale": lerpf(0.82, 1.12, _hash_01(i, side + 31))})

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
		leaf.scale = Vector2.ONE * eased * float(data["scale"]) * 0.048 * _viewport_size().y / 1024.0
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
	for i in range(3):
		var mask := Control.new()
		mask.name = "LineMask%d" % (i + 1)
		mask.clip_contents = true
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
	label.add_theme_constant_override("outline_size", int(round(5.0 * _viewport_size().y / 1080.0)))

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

func _kill_tweens() -> void:
	for tween in _active_tweens:
		if tween != null and tween.is_valid():
			tween.kill()
	_active_tweens.clear()

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
	var size := get_viewport_rect().size
	return Vector2(1920, 1080) if size == Vector2.ZERO else size

func _hash_01(index: int, salt: int) -> float:
	var v := int(index * 92821 + salt * 68917 + 1337)
	v = int((v ^ (v >> 13)) * 1274126177)
	v = v ^ (v >> 16)
	return float(abs(v % 10000)) / 10000.0

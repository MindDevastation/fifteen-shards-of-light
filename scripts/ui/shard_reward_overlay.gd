extends Control
class_name ShardRewardOverlay

signal confirmation_requested
signal return_completed

const DEFAULT_REWARD_TEXT := "..."
const BUTTON_DISABLED_ALPHA := 0.58
const BUTTON_ENABLED_ALPHA := 1.0
const MATTE_VEIL_COLOR := Color(0.032, 0.021, 0.018, 0.62)
const WARM_WASH_COLOR := Color(0.34, 0.15, 0.075, 0.14)
const TEXT_COLOR := Color(1.0, 0.92, 0.72, 1.0)
const TEXT_OUTLINE_COLOR := Color(0.10, 0.035, 0.015, 0.96)
const BUTTON_PRESS_SCALE := Vector2(0.945, 0.945)
const BUTTON_PRESS_OFFSET := Vector2(0.0, 5.0)
const BUTTON_PRESS_ALPHA := 0.82
const FRAME_PARTICLE_COUNT := 72
const FRAME_TOP_COUNT := 22
const FRAME_BOTTOM_COUNT := 22
const FRAME_LEFT_COUNT := 14
const FRAME_RIGHT_COUNT := 14
const FRAME_FORMATION_DURATION := 0.86
const FRAME_COLORS := [
	Color(1.0, 0.82, 0.38, 0.92),
	Color(1.0, 0.94, 0.72, 0.88),
	Color(1.0, 0.58, 0.34, 0.78),
	Color(0.96, 0.72, 0.28, 0.86),
]
const VINE_LEAF_TEXTURE := preload("res://assets/ui/shard_reward_overlay/vine_leaf.png")
const VINE_GROWTH_DURATION := 2.3
const REWARD_FONT := preload("res://assets/fonts/cormorant_garamond/CormorantGaramond-SemiBoldItalic.otf")
const FRAME_LIVING_UPDATE_INTERVAL := 0.033
const TEXT_REVEAL_LINE_DURATION := 1.25
const TEXT_REVEAL_LINE_STAGGER := 0.55
const TEXT_REVEAL_DEFAULT_FONT_SIZE := 48
const TEXT_REVEAL_FALLBACK_FONT_SIZE := 44
const TEXT_LINE_WIDTHS := [720.0, 650.0, 560.0]
const RETURN_TEXT_FADE_DURATION := 1.55
const RETURN_BUTTON_FADE_DURATION := 0.65
const RETURN_ATMOSPHERE_FADE_DURATION := 2.20
const RETURN_CRYSTAL_DURATION := 2.15
const LEAF_THRESHOLDS := [0.20, 0.34, 0.50, 0.66, 0.80]
const VINE_OUTER_COLOR := Color(1.0, 0.62, 0.18, 0.24)
const VINE_MAIN_COLOR := Color(1.0, 0.67, 0.26, 0.90)
const VINE_INNER_COLOR := Color(1.0, 0.92, 0.70, 0.98)
const MAIN_VINE_WIDTHS := Vector3(20.0, 9.0, 3.0)
const BRANCH_VINE_WIDTHS := Vector3(10.0, 4.5, 1.5)
const TIP_ACTIVE_ALPHA := 0.72
const TIP_FADE_START := 0.92

var _confirmation_emitted := false
var _return_emitted := false
var _sequence_generation := 0
var _text_complete := false
var _vine_complete := false
var _owned_tweens: Array[Tween] = []
var _button_base_position := Vector2.ZERO
var _frame_particles: Array[Dictionary] = []
var _living_time := 0.0
var _living_update_accumulator := 0.0
var _vine_progress := 0.0
var _left_main_points := PackedVector2Array()
var _right_main_points := PackedVector2Array()
var _branch_data: Array[Dictionary] = []
var _leaf_data: Array[Dictionary] = []
var _text_line_masks: Array[Control] = []
var _text_line_labels: Array[RichTextLabel] = []
var _text_line_glints: Array[ColorRect] = []
var _current_text_font_size := TEXT_REVEAL_DEFAULT_FONT_SIZE
var _button_mouse_inside := false
var _button_has_focus := false
var _last_geometry_viewport_size := Vector2.ZERO
var _frame_targets_cache: Array[Vector2] = []

@onready var atmosphere: Control = $Atmosphere
@onready var matte_veil: ColorRect = $Atmosphere/MatteVeil
@onready var warm_wash: ColorRect = $Atmosphere/WarmWash
@onready var light_frame_layer: Node2D = $LightFrameLayer
@onready var vine_canvas: Node2D = $VineCanvas
@onready var left_outer_glow: Line2D = $VineCanvas/LeftVine/OuterGlow
@onready var left_main_gold: Line2D = $VineCanvas/LeftVine/MainGold
@onready var left_inner_ivory: Line2D = $VineCanvas/LeftVine/InnerIvory
@onready var right_outer_glow: Line2D = $VineCanvas/RightVine/OuterGlow
@onready var right_main_gold: Line2D = $VineCanvas/RightVine/MainGold
@onready var right_inner_ivory: Line2D = $VineCanvas/RightVine/InnerIvory
@onready var branch_layer: Node2D = $VineCanvas/BranchLayer
@onready var leaf_layer: Node2D = $VineCanvas/LeafLayer
@onready var left_tip_glow: Polygon2D = $VineCanvas/LeftTipGlow
@onready var right_tip_glow: Polygon2D = $VineCanvas/RightTipGlow
@onready var text_root: Control = $TextRoot
@onready var reward_text_label: RichTextLabel = $TextRoot/RewardText
@onready var button_root: Control = $ButtonRoot
@onready var confirm_button: TextureButton = $ButtonRoot/ConfirmButton


func _ready() -> void:
	visible = false
	mouse_filter = Control.MOUSE_FILTER_STOP
	set_process(false)
	confirm_button.pressed.connect(_on_confirm_button_pressed)
	confirm_button.mouse_entered.connect(_on_confirm_button_mouse_entered)
	confirm_button.mouse_exited.connect(_on_confirm_button_mouse_exited)
	confirm_button.button_down.connect(_on_confirm_button_down)
	confirm_button.button_up.connect(_on_confirm_button_up)
	confirm_button.focus_entered.connect(_on_confirm_button_focus_entered)
	confirm_button.focus_exited.connect(_on_confirm_button_focus_exited)
	_create_text_reveal_nodes()
	_create_frame_particle_pool()
	_configure_vine_line_styles()
	_apply_responsive_layout()
	_button_base_position = confirm_button.position
	_reset_visual_state(false)


func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED and is_node_ready():
		_apply_responsive_layout()
		button_root.pivot_offset = button_root.size * 0.5


func _process(delta: float) -> void:
	_living_time += delta
	_living_update_accumulator += delta
	if _living_update_accumulator >= FRAME_LIVING_UPDATE_INTERVAL:
		_living_update_accumulator = 0.0
		_update_frame_living_state()


func play_reward(display_text: String, origin_screen_position: Vector2) -> void:
	_sequence_generation += 1
	_play_reward_async(display_text, origin_screen_position, _sequence_generation)


func play_return_to(target_screen_position: Vector2) -> void:
	_sequence_generation += 1
	_play_return_to_async(target_screen_position, _sequence_generation)


func reset_overlay() -> void:
	_sequence_generation += 1
	_reset_visual_state(true)
	visible = false


func _play_reward_async(display_text: String, origin_screen_position: Vector2, generation: int) -> void:
	_reset_visual_state(false)
	_confirmation_emitted = false
	_return_emitted = false
	_text_complete = false
	_vine_complete = false
	visible = true
	var text_to_show := display_text
	if text_to_show.strip_edges().is_empty():
		text_to_show = DEFAULT_REWARD_TEXT
	_prepare_reward_text(text_to_show)
	matte_veil.color = MATTE_VEIL_COLOR
	warm_wash.color = WARM_WASH_COLOR
	button_root.modulate.a = BUTTON_DISABLED_ALPHA
	confirm_button.disabled = true
	_build_vine_geometry()
	_build_frame_particles(origin_screen_position)
	_animate_atmosphere_in()
	_start_frame_after_delay(generation)
	_start_vine_after_delay(generation)
	_start_text_after_delay(text_to_show, generation)


func _play_return_to_async(target_screen_position: Vector2, generation: int) -> void:
	if not visible:
		_emit_return_completed_once()
		return
	confirm_button.disabled = true
	set_process(false)
	await get_tree().create_timer(0.10).timeout
	if generation != _sequence_generation:
		return
	await _animate_return_sequence(target_screen_position, generation)
	if generation != _sequence_generation:
		return
	_reset_visual_state(false)
	visible = false
	_emit_return_completed_once()


func _reset_visual_state(reset_signals: bool = true) -> void:
	_kill_owned_tweens()
	if reset_signals:
		_confirmation_emitted = false
		_return_emitted = false
	_text_complete = false
	_vine_complete = false
	set_process(false)
	matte_veil.color = MATTE_VEIL_COLOR
	warm_wash.color = WARM_WASH_COLOR
	atmosphere.modulate.a = 0.0
	light_frame_layer.modulate.a = 1.0
	vine_canvas.modulate.a = 1.0
	text_root.modulate.a = 0.0
	button_root.modulate.a = BUTTON_DISABLED_ALPHA
	reward_text_label.text = ""
	reward_text_label.visible_ratio = 1.0
	_reset_text_reveal_nodes()
	confirm_button.disabled = true
	confirm_button.scale = Vector2.ONE
	confirm_button.position = _button_base_position
	confirm_button.modulate = Color(1.0, 1.0, 1.0, 1.0)
	_button_mouse_inside = false
	_button_has_focus = false
	confirm_button.button_pressed = false
	confirm_button.release_focus()
	_apply_button_visual_state()
	_vine_progress = 0.0
	_clear_line_points()
	_reset_frame_particles()
	_reset_branch_and_leaf_nodes()
	_set_tip_glow(left_tip_glow, Vector2.ZERO, 0.0)
	_set_tip_glow(right_tip_glow, Vector2.ZERO, 0.0)


func _clear_line_points() -> void:
	for line in [left_outer_glow, left_main_gold, left_inner_ivory, right_outer_glow, right_main_gold, right_inner_ivory]:
		line.clear_points()



func _animate_atmosphere_in() -> void:
	atmosphere.modulate.a = 0.0
	var tween := _track_tween(create_tween())
	tween.set_parallel(true)
	tween.tween_property(atmosphere, "modulate:a", 1.0, 0.42).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _start_frame_after_delay(generation: int) -> void:
	await get_tree().create_timer(0.05).timeout
	if generation != _sequence_generation:
		return
	await _animate_frame_formation()
	if generation != _sequence_generation:
		return
	set_process(true)


func _start_vine_after_delay(generation: int) -> void:
	await get_tree().create_timer(0.12).timeout
	if generation != _sequence_generation:
		return
	await _animate_vine_progress(1.0, VINE_GROWTH_DURATION)
	if generation != _sequence_generation:
		return
	_vine_complete = true
	_try_enable_button(generation)


func _start_text_after_delay(text_to_show: String, generation: int) -> void:
	await get_tree().create_timer(0.50).timeout
	if generation != _sequence_generation:
		return
	await _reveal_text()
	if generation != _sequence_generation:
		return
	_text_complete = true
	_try_enable_button(generation)


func _reveal_text() -> void:
	text_root.modulate.a = 1.0
	var tween := _track_tween(create_tween())
	tween.set_parallel(true)
	for i in range(_text_line_masks.size()):
		var mask := _text_line_masks[i]
		if not mask.visible:
			continue
		var label := _text_line_labels[i]
		var glint := _text_line_glints[i]
		var target_width := label.size.x + 18.0
		var delay := float(i) * TEXT_REVEAL_LINE_STAGGER
		tween.tween_property(mask, "size:x", target_width, TEXT_REVEAL_LINE_DURATION).set_delay(delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(label, "modulate:a", 1.0, 0.25).set_delay(delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.tween_property(glint, "position:x", target_width - glint.size.x * 0.5, TEXT_REVEAL_LINE_DURATION).set_delay(delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(glint, "modulate:a", 0.62, 0.18).set_delay(delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.tween_property(glint, "modulate:a", 0.0, 0.28).set_delay(delay + TEXT_REVEAL_LINE_DURATION - 0.18).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(text_root, "modulate:a", 1.0, 0.22).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await tween.finished


func _try_enable_button(generation: int) -> void:
	if generation != _sequence_generation:
		return
	if not _text_complete or not _vine_complete:
		return
	button_root.modulate.a = BUTTON_ENABLED_ALPHA
	confirm_button.disabled = false
	_update_button_mouse_inside()
	_apply_button_visual_state()
	confirm_button.grab_focus()
	_apply_button_visual_state()


func _animate_return_sequence(target_screen_position: Vector2, generation: int) -> void:
	var viewport_size := _get_viewport_size()
	var target := target_screen_position.clamp(Vector2.ZERO, viewport_size)
	var tween := _track_tween(create_tween())
	tween.set_parallel(true)
	tween.tween_property(text_root, "modulate:a", 0.0, RETURN_TEXT_FADE_DURATION).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(button_root, "modulate:a", 0.0, RETURN_BUTTON_FADE_DURATION).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(atmosphere, "modulate:a", 0.0, RETURN_ATMOSPHERE_FADE_DURATION).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_method(_update_vine_visuals, _vine_progress, 0.0, VINE_GROWTH_DURATION).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	for i in range(_frame_particles.size()):
		var data := _frame_particles[i]
		var particle := data["node"] as Polygon2D
		if particle == null:
			continue
		var delay := float(i % 10) * 0.022 + _hash_01(i, 211) * 0.06
		var duration := RETURN_CRYSTAL_DURATION - 0.18 + _hash_01(i, 223) * 0.18
		tween.tween_property(particle, "position", target + _hash_vector(i, 227) * 7.0, duration).set_delay(delay).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		tween.tween_property(particle, "scale", Vector2.ZERO, duration * 0.82).set_delay(delay + duration * 0.12).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		tween.tween_property(particle, "modulate:a", 0.0, duration * 0.6).set_delay(delay + duration * 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	await tween.finished
	if generation != _sequence_generation:
		return


func _create_text_reveal_nodes() -> void:
	reward_text_label.visible = false
	for i in range(3):
		var mask := Control.new()
		mask.name = "LineRevealMask%d" % (i + 1)
		mask.clip_contents = true
		mask.mouse_filter = Control.MOUSE_FILTER_IGNORE
		mask.visible = false
		text_root.add_child(mask)
		var label := RichTextLabel.new()
		label.name = "RewardTextCopy%d" % (i + 1)
		label.bbcode_enabled = true
		label.fit_content = true
		label.scroll_active = false
		label.autowrap_mode = TextServer.AUTOWRAP_OFF
		label.mouse_filter = Control.MOUSE_FILTER_IGNORE
		mask.add_child(label)
		var glint := ColorRect.new()
		glint.name = "LineRevealGlint%d" % (i + 1)
		glint.color = Color(1.0, 0.86, 0.38, 0.72)
		glint.mouse_filter = Control.MOUSE_FILTER_IGNORE
		mask.add_child(glint)
		_text_line_masks.append(mask)
		_text_line_labels.append(label)
		_text_line_glints.append(glint)


func _prepare_reward_text(display_text: String) -> void:
	var layout := _layout_reward_text(display_text)
	var lines := layout["lines"] as Array[String]
	_current_text_font_size = int(layout["font_size"])
	var scale_factor := _get_text_scale_factor()
	var line_height := 58.0 * scale_factor
	var total_height := line_height * float(lines.size())
	var start_y := _get_viewport_size().y * 0.425 - total_height * 0.5
	_reset_text_reveal_nodes()
	for i in range(lines.size()):
		var line := lines[i]
		var measured := _measure_text_line(line, _current_text_font_size)
		var mask := _text_line_masks[i]
		var label := _text_line_labels[i]
		var glint := _text_line_glints[i]
		_configure_reveal_label(label, _current_text_font_size)
		label.text = "[center][i]%s[/i][/center]" % _bbcode_escape(line)
		label.position = Vector2.ZERO
		label.size = Vector2(measured.x + 18.0 * scale_factor, line_height)
		label.modulate.a = 0.0
		mask.visible = true
		mask.position = Vector2((_get_viewport_size().x - label.size.x) * 0.5, start_y + line_height * float(i))
		mask.size = Vector2(0.0, line_height)
		glint.size = Vector2(10.0 * scale_factor, line_height * 0.82)
		glint.position = Vector2(-glint.size.x, line_height * 0.09)
		glint.modulate.a = 0.0
	# Keep escaped complete text in the hidden legacy label for BBCode/static inspection only.
	reward_text_label.text = "[center][i]%s[/i][/center]" % _bbcode_escape("\n".join(lines))
	reward_text_label.visible_ratio = 1.0


func _reset_text_reveal_nodes() -> void:
	for i in range(_text_line_masks.size()):
		_text_line_masks[i].visible = false
		_text_line_masks[i].size.x = 0.0
		_text_line_labels[i].text = ""
		_text_line_labels[i].modulate.a = 0.0
		_text_line_glints[i].modulate.a = 0.0
		_text_line_glints[i].position.x = -20.0


func _configure_reveal_label(label: RichTextLabel, font_size: int) -> void:
	label.add_theme_font_override("normal_font", REWARD_FONT)
	label.add_theme_font_override("italics_font", REWARD_FONT)
	label.add_theme_font_override("bold_italics_font", REWARD_FONT)
	label.add_theme_font_size_override("normal_font_size", font_size)
	label.add_theme_font_size_override("italics_font_size", font_size)
	label.add_theme_font_size_override("bold_italics_font_size", font_size)
	label.add_theme_color_override("default_color", TEXT_COLOR)
	label.add_theme_color_override("font_outline_color", TEXT_OUTLINE_COLOR)
	label.add_theme_constant_override("outline_size", int(round(6.0 * _get_text_scale_factor())))


func _layout_reward_text(display_text: String) -> Dictionary:
	var normalized := _normalize_reward_text(display_text)
	for font_size in [int(round(TEXT_REVEAL_DEFAULT_FONT_SIZE * _get_text_scale_factor())), int(round(TEXT_REVEAL_FALLBACK_FONT_SIZE * _get_text_scale_factor()))]:
		var explicit_lines := normalized.split("\n", false)
		if explicit_lines.size() > 1:
			var explicit_result: Array[String] = []
			for part in explicit_lines:
				explicit_result.append_array(_best_word_layout(part, font_size, max(1, 3 - explicit_result.size())))
			if explicit_result.size() <= 3 and _lines_fit(explicit_result, font_size):
				return {"lines": explicit_result, "font_size": font_size}
		var lines := _best_word_layout(normalized.replace("\n", " "), font_size, 3)
		if _lines_fit(lines, font_size):
			return {"lines": lines, "font_size": font_size}
	return {"lines": _best_word_layout(normalized.replace("\n", " "), int(round(TEXT_REVEAL_FALLBACK_FONT_SIZE * _get_text_scale_factor())), 3), "font_size": int(round(TEXT_REVEAL_FALLBACK_FONT_SIZE * _get_text_scale_factor()))}


func _normalize_reward_text(value: String) -> String:
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


func _best_word_layout(text: String, font_size: int, max_lines: int) -> Array[String]:
	var words := text.split(" ", false)
	if words.size() <= 1:
		return [text]
	var best: Array[String] = []
	var best_score := INF
	for line_count in range(1, max_lines + 1):
		var splits := _candidate_splits(words.size(), line_count)
		for split in splits:
			var lines: Array[String] = []
			var start := 0
			for end in split:
				lines.append(" ".join(words.slice(start, end)))
				start = end
			if not _lines_fit(lines, font_size):
				continue
			var score := _layout_score(lines, font_size)
			if score < best_score:
				best_score = score
				best = lines
	if best.is_empty():
		return _greedy_three_line_layout(words)
	return best


func _candidate_splits(word_count: int, line_count: int) -> Array:
	var result: Array = []
	if line_count == 1:
		result.append([word_count])
	elif line_count == 2:
		for a in range(1, word_count):
			result.append([a, word_count])
	else:
		for a in range(1, word_count - 1):
			for b in range(a + 1, word_count):
				result.append([a, b, word_count])
	return result


func _lines_fit(lines: Array[String], font_size: int) -> bool:
	if lines.size() > 3:
		return false
	var scale_factor := _get_text_scale_factor()
	for i in range(lines.size()):
		if _measure_text_line(lines[i], font_size).x > TEXT_LINE_WIDTHS[i] * scale_factor:
			return false
	return true


func _layout_score(lines: Array[String], font_size: int) -> float:
	var score := float(lines.size()) * 22.0
	var widths: Array[float] = []
	for line in lines:
		widths.append(_measure_text_line(line, font_size).x)
	var average := 0.0
	for width in widths:
		average += width
	average /= max(1.0, float(widths.size()))
	for width in widths:
		score += absf(width - average) * 0.16
	for line in lines:
		if line.split(" ", false).size() == 1 and lines.size() > 1:
			score += 120.0
	return score


func _greedy_three_line_layout(words: PackedStringArray) -> Array[String]:
	var result: Array[String] = []
	var per_line := int(ceil(float(words.size()) / 3.0))
	for i in range(0, words.size(), per_line):
		result.append(" ".join(words.slice(i, min(i + per_line, words.size()))))
	return result


func _measure_text_line(line: String, font_size: int) -> Vector2:
	return REWARD_FONT.get_string_size(line, HORIZONTAL_ALIGNMENT_LEFT, -1.0, font_size)


func _get_text_scale_factor() -> float:
	return clampf(_get_viewport_size().y / 1080.0, 0.72, 1.08)


func _create_frame_particle_pool() -> void:
	if not _frame_particles.is_empty():
		return
	for i in range(FRAME_PARTICLE_COUNT):
		var particle := Polygon2D.new()
		particle.name = "LightFrameParticle_%02d" % i
		particle.polygon = _build_frame_particle_polygon(i)
		particle.color = FRAME_COLORS[i % FRAME_COLORS.size()]
		particle.scale = Vector2.ZERO
		particle.modulate.a = 0.0
		light_frame_layer.add_child(particle)
		_frame_particles.append({
			"node": particle,
			"target": Vector2.ZERO,
			"base_rotation": _hash_signed(i, 83) * 0.24,
			"phase_x": _hash_01(i, 97) * TAU,
			"phase_y": _hash_01(i, 101) * TAU,
			"speed_x": lerpf(0.48, 0.92, _hash_01(i, 109)),
			"speed_y": lerpf(0.45, 0.88, _hash_01(i, 113)),
			"amp_x": lerpf(0.5, 2.2, _hash_01(i, 117)),
			"amp_y": lerpf(0.5, 2.5, _hash_01(i, 121)),
			"alpha_amp": lerpf(0.05, 0.13, _hash_01(i, 125)),
		})


func _reset_frame_particles() -> void:
	for data in _frame_particles:
		var particle := data["node"] as Polygon2D
		if particle != null:
			particle.scale = Vector2.ZERO
			particle.modulate.a = 0.0


func _build_frame_particles(origin_screen_position: Vector2) -> void:
	_create_frame_particle_pool()
	var viewport_size := _get_viewport_size()
	var origin := origin_screen_position.clamp(Vector2.ZERO, viewport_size)
	_frame_targets_cache = _build_frame_targets(viewport_size)
	for i in range(FRAME_PARTICLE_COUNT):
		var data := _frame_particles[i]
		var particle := data["node"] as Polygon2D
		data["target"] = _frame_targets_cache[i]
		particle.position = origin + _hash_vector(i, 31) * 18.0
		particle.rotation = _hash_signed(i, 47) * 0.35
		particle.scale = Vector2.ZERO
		particle.modulate.a = 0.0


func _build_frame_targets(viewport_size: Vector2) -> Array[Vector2]:
	var rect := Rect2(viewport_size * Vector2(0.09, 0.08), viewport_size * Vector2(0.82, 0.80))
	var targets: Array[Vector2] = []
	_append_clustered_edge_targets(targets, rect.position, Vector2(rect.end.x, rect.position.y), FRAME_TOP_COUNT, 3)
	_append_clustered_edge_targets(targets, Vector2(rect.end.x, rect.end.y), Vector2(rect.position.x, rect.end.y), FRAME_BOTTOM_COUNT, 5)
	_append_clustered_edge_targets(targets, Vector2(rect.position.x, rect.position.y), Vector2(rect.position.x, rect.end.y), FRAME_LEFT_COUNT, 7, true)
	_append_clustered_edge_targets(targets, Vector2(rect.end.x, rect.end.y), Vector2(rect.end.x, rect.position.y), FRAME_RIGHT_COUNT, 11, true)
	return targets


func _append_clustered_edge_targets(targets: Array[Vector2], start: Vector2, end: Vector2, count: int, salt: int, skip_corners: bool = false) -> void:
	for i in range(count):
		var base_t := float(i) / float(max(1, count - 1))
		if skip_corners:
			base_t = float(i + 1) / float(count + 1)
		var cluster_wave := sin(base_t * PI * 6.0 + float(salt)) * 0.018
		var t := clampf(base_t + cluster_wave + _hash_signed(i, salt) * 0.010, 0.0, 1.0)
		var jitter := _hash_vector(i, salt + 17) * 4.2
		targets.append(start.lerp(end, t) + jitter)


func _build_frame_particle_polygon(index: int) -> PackedVector2Array:
	var width := lerpf(4.0, 7.8, _hash_01(index, 131))
	var height := lerpf(9.0, 18.0, _hash_01(index, 137))
	return PackedVector2Array([Vector2(0.0, -height), Vector2(width, 0.0), Vector2(0.0, height), Vector2(-width, 0.0)])

func _animate_frame_formation() -> void:
	var tween := _track_tween(create_tween())
	tween.set_parallel(true)
	for i in range(_frame_particles.size()):
		var data := _frame_particles[i]
		var particle := data["node"] as Polygon2D
		var delay := _hash_01(i, 151) * 0.18
		tween.tween_property(particle, "position", data["target"], FRAME_FORMATION_DURATION).set_delay(delay).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		tween.tween_property(particle, "rotation", data["base_rotation"], FRAME_FORMATION_DURATION).set_delay(delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.tween_property(particle, "scale", Vector2.ONE, FRAME_FORMATION_DURATION * 0.68).set_delay(delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.tween_property(particle, "modulate:a", 1.0, FRAME_FORMATION_DURATION * 0.55).set_delay(delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await tween.finished


func _update_frame_living_state() -> void:
	for data in _frame_particles:
		var particle := data["node"] as Polygon2D
		if particle == null:
			continue
		var target := data["target"] as Vector2
		var phase_x := float(data["phase_x"])
		var phase_y := float(data["phase_y"])
		var speed_x := float(data["speed_x"])
		var speed_y := float(data["speed_y"])
		var offset := Vector2(
			sin(_living_time * speed_x + phase_x) * float(data["amp_x"]),
			cos(_living_time * speed_y + phase_y) * float(data["amp_y"])
		)
		particle.position = target + offset
		particle.rotation = float(data["base_rotation"]) + sin(_living_time * speed_x + phase_x) * 0.016
		particle.modulate.a = 0.88 + sin(_living_time * (speed_x + speed_y) + phase_x) * float(data["alpha_amp"])


func _build_vine_geometry() -> void:
	_clear_line_points()
	_reset_branch_and_leaf_nodes()
	var viewport_size := _get_viewport_size()
	var center_x := viewport_size.x * 0.5
	var origin := Vector2(center_x, viewport_size.y * 0.785)
	var left_curve := Curve2D.new()
	left_curve.bake_interval = 8.0
	_add_curve_point(left_curve, origin, Vector2.ZERO, Vector2(-viewport_size.x * 0.035, -viewport_size.y * 0.055))
	_add_curve_point(left_curve, Vector2(viewport_size.x * 0.42, viewport_size.y * 0.665), Vector2(viewport_size.x * 0.035, viewport_size.y * 0.04), Vector2(-viewport_size.x * 0.07, -viewport_size.y * 0.07))
	_add_curve_point(left_curve, Vector2(viewport_size.x * 0.335, viewport_size.y * 0.535), Vector2(viewport_size.x * 0.08, viewport_size.y * 0.06), Vector2(-viewport_size.x * 0.095, -viewport_size.y * 0.085))
	_add_curve_point(left_curve, Vector2(viewport_size.x * 0.255, viewport_size.y * 0.37), Vector2(viewport_size.x * 0.11, viewport_size.y * 0.08), Vector2(-viewport_size.x * 0.035, -viewport_size.y * 0.16))
	_add_curve_point(left_curve, Vector2(viewport_size.x * 0.36, viewport_size.y * 0.165), Vector2(-viewport_size.x * 0.13, viewport_size.y * 0.02), Vector2(viewport_size.x * 0.075, -viewport_size.y * 0.025))
	_add_curve_point(left_curve, Vector2(center_x, viewport_size.y * 0.275), Vector2(-viewport_size.x * 0.065, -viewport_size.y * 0.085), Vector2.ZERO)
	_left_main_points = left_curve.get_baked_points()
	_right_main_points = _mirror_points(_left_main_points, center_x)
	if _branch_data.is_empty() or _last_geometry_viewport_size != viewport_size:
		_clear_branch_and_leaf_pool()
		_build_branch_geometry(viewport_size, center_x)
		_build_leaf_geometry(viewport_size, center_x)
	_last_geometry_viewport_size = viewport_size
	_update_vine_visuals(0.0)



func _reset_branch_and_leaf_nodes() -> void:
	for data in _branch_data:
		for line in data["lines"]:
			(line as Line2D).clear_points()
	for data in _leaf_data:
		var sprite := data["node"] as Sprite2D
		if sprite != null:
			sprite.scale = Vector2.ZERO
			sprite.modulate.a = 0.0


func _clear_branch_and_leaf_pool() -> void:
	for child in branch_layer.get_children():
		child.queue_free()
	for child in leaf_layer.get_children():
		child.queue_free()
	_branch_data.clear()
	_leaf_data.clear()

func _add_curve_point(curve: Curve2D, point: Vector2, in_handle: Vector2, out_handle: Vector2) -> void:
	curve.add_point(point, in_handle, out_handle)


func _mirror_points(points: PackedVector2Array, center_x: float) -> PackedVector2Array:
	var mirrored := PackedVector2Array()
	for point in points:
		mirrored.append(Vector2(center_x + (center_x - point.x), point.y))
	return mirrored


func _build_branch_geometry(viewport_size: Vector2, center_x: float) -> void:
	var branches := [
		{"side": -1, "threshold": 0.12, "anchor": Vector2(0.49, 0.755), "curl": Vector2(-0.045, -0.055)},
		{"side": -1, "threshold": 0.22, "anchor": Vector2(0.405, 0.635), "curl": Vector2(-0.065, -0.055)},
		{"side": -1, "threshold": 0.36, "anchor": Vector2(0.34, 0.515), "curl": Vector2(-0.075, 0.035)},
		{"side": -1, "threshold": 0.50, "anchor": Vector2(0.285, 0.39), "curl": Vector2(-0.055, -0.045)},
		{"side": -1, "threshold": 0.64, "anchor": Vector2(0.305, 0.285), "curl": Vector2(0.052, -0.050)},
		{"side": -1, "threshold": 0.78, "anchor": Vector2(0.39, 0.205), "curl": Vector2(-0.048, -0.020)},
	]
	for branch in branches:
		_add_branch_pair(branch, viewport_size, center_x)


func _add_branch_pair(branch: Dictionary, viewport_size: Vector2, center_x: float) -> void:
	for side in [-1, 1]:
		var anchor_ratio := branch["anchor"] as Vector2
		var curl_ratio := branch["curl"] as Vector2
		var anchor_x: float = anchor_ratio.x if side < 0 else 1.0 - anchor_ratio.x
		var curl_x: float = curl_ratio.x if side < 0 else -curl_ratio.x
		var start := Vector2(viewport_size.x * anchor_x, viewport_size.y * anchor_ratio.y)
		var path_points := _left_main_points if side < 0 else _right_main_points
		var tangent_angle := _sample_main_tangent_rotation(path_points, float(branch["threshold"]))
		var overlap := Vector2(cos(tangent_angle), sin(tangent_angle)) * -10.0
		var end := start + Vector2(viewport_size.x * curl_x, viewport_size.y * curl_ratio.y)
		start += overlap
		var curve := Curve2D.new()
		curve.bake_interval = 8.0
		curve.add_point(start, Vector2.ZERO, Vector2(viewport_size.x * 0.035 * side, -viewport_size.y * 0.035))
		curve.add_point((start + end) * 0.5 + Vector2(viewport_size.x * 0.035 * side, viewport_size.y * 0.025), Vector2(-viewport_size.x * 0.035 * side, 0.0), Vector2(viewport_size.x * 0.045 * side, 0.0))
		curve.add_point(end, Vector2(-viewport_size.x * 0.035 * side, viewport_size.y * 0.025), Vector2.ZERO)
		var branch_index := _branch_data.size()
		var outer_line := _create_branch_line("BranchOuter_%s_%02d" % ["Left" if side < 0 else "Right", branch_index], BRANCH_VINE_WIDTHS.x, VINE_OUTER_COLOR)
		var main_line := _create_branch_line("BranchMain_%s_%02d" % ["Left" if side < 0 else "Right", branch_index], BRANCH_VINE_WIDTHS.y, VINE_MAIN_COLOR)
		var inner_line := _create_branch_line("BranchInner_%s_%02d" % ["Left" if side < 0 else "Right", branch_index], BRANCH_VINE_WIDTHS.z, VINE_INNER_COLOR)
		branch_layer.add_child(outer_line)
		branch_layer.add_child(main_line)
		branch_layer.add_child(inner_line)
		_branch_data.append({
			"points": curve.get_baked_points(),
			"threshold": float(branch["threshold"]),
			"outer_line": outer_line,
			"main_line": main_line,
			"inner_line": inner_line,
			"lines": [outer_line, main_line, inner_line],
		})


func _create_branch_line(line_name: String, width: float, color: Color) -> Line2D:
	var line := Line2D.new()
	line.name = line_name
	line.width = width
	line.default_color = color
	line.antialiased = true
	line.joint_mode = Line2D.LINE_JOINT_ROUND
	line.begin_cap_mode = Line2D.LINE_CAP_ROUND
	line.end_cap_mode = Line2D.LINE_CAP_ROUND
	return line


func _build_leaf_geometry(viewport_size: Vector2, center_x: float) -> void:
	var leaf_specs := [
		{"threshold": LEAF_THRESHOLDS[0], "offset": -7.0, "rotation": -0.82, "scale": 0.052},
		{"threshold": LEAF_THRESHOLDS[1], "offset": 8.0, "rotation": -0.38, "scale": 0.048},
		{"threshold": LEAF_THRESHOLDS[2], "offset": -8.0, "rotation": 0.22, "scale": 0.050},
		{"threshold": LEAF_THRESHOLDS[3], "offset": 7.0, "rotation": 0.50, "scale": 0.044},
		{"threshold": LEAF_THRESHOLDS[4], "offset": -6.0, "rotation": -0.30, "scale": 0.050},
	]
	for leaf in leaf_specs:
		for side in [-1, 1]:
			var points := _left_main_points if side < 0 else _right_main_points
			var sample := _sample_path_attachment(points, float(leaf["threshold"]), float(leaf["offset"]) * side)
			var sprite := Sprite2D.new()
			sprite.name = "VineLeaf_%s_%02d" % ["Left" if side < 0 else "Right", _leaf_data.size()]
			sprite.texture = VINE_LEAF_TEXTURE
			sprite.centered = true
			sprite.position = sample["position"]
			var target_scale := float(leaf["scale"]) * viewport_size.y / 1024.0
			var signed_scale := Vector2(target_scale * side, target_scale)
			sprite.scale = Vector2.ZERO
			sprite.rotation = float(sample["angle"]) + float(leaf["rotation"]) * side
			sprite.modulate = Color(1.0, 0.84 + 0.04 * float(_leaf_data.size() % 2), 0.52, 0.0)
			leaf_layer.add_child(sprite)
			_leaf_data.append({"node": sprite, "threshold": float(leaf["threshold"]), "scale": signed_scale, "rotation": sprite.rotation, "source_path": "main", "progress": float(leaf["threshold"]), "side_offset": float(leaf["offset"]) * side})


func _sample_path_attachment(points: PackedVector2Array, progress: float, side_offset: float) -> Dictionary:
	if points.size() < 2:
		return {"position": Vector2.ZERO, "angle": 0.0}
	var index := clampi(int(round(float(points.size() - 1) * progress)), 1, points.size() - 2)
	var previous := points[index - 1]
	var current := points[index]
	var next := points[index + 1]
	var direction := next - previous
	if direction.length_squared() <= 0.001:
		direction = current - previous
	var angle := direction.angle()
	var normal := Vector2(-direction.y, direction.x).normalized()
	return {"position": current + normal * side_offset, "angle": angle}


func _animate_vine_progress(target_progress: float, duration: float) -> void:
	var tween := _track_tween(create_tween())
	tween.tween_method(_update_vine_visuals, _vine_progress, target_progress, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished


func _update_vine_visuals(progress: float) -> void:
	_vine_progress = clampf(progress, 0.0, 1.0)
	var left_visible := _truncate_points(_left_main_points, _vine_progress)
	var right_visible := _truncate_points(_right_main_points, _vine_progress)
	for line in [left_outer_glow, left_main_gold, left_inner_ivory]:
		line.points = left_visible
	for line in [right_outer_glow, right_main_gold, right_inner_ivory]:
		line.points = right_visible
	_update_tip_from_points(left_tip_glow, left_visible, _vine_progress)
	_update_tip_from_points(right_tip_glow, right_visible, _vine_progress)
	_update_branches(_vine_progress)
	_update_leaves(_vine_progress)


func _truncate_points(points: PackedVector2Array, progress: float) -> PackedVector2Array:
	if points.is_empty() or progress <= 0.0:
		return PackedVector2Array()
	var count := clampi(int(ceil(float(points.size()) * progress)), 1, points.size())
	return points.slice(0, count)


func _update_tip_from_points(tip: Polygon2D, points: PackedVector2Array, progress: float) -> void:
	var tip_alpha := _get_tip_alpha(progress)
	if points.is_empty() or tip_alpha <= 0.0:
		_set_tip_glow(tip, Vector2.ZERO, 0.0)
	else:
		_set_tip_glow(tip, points[points.size() - 1], tip_alpha)


func _get_tip_alpha(progress: float) -> float:
	if progress <= 0.0:
		return 0.0
	var completion_fade := clampf(inverse_lerp(TIP_FADE_START, 1.0, progress), 0.0, 1.0)
	return lerpf(TIP_ACTIVE_ALPHA, 0.0, completion_fade)


func _update_branches(progress: float) -> void:
	for data in _branch_data:
		var threshold := float(data["threshold"])
		var local_progress := clampf((progress - threshold) / 0.16, 0.0, 1.0)
		var visible_points := _truncate_points(data["points"], local_progress)
		for line in data["lines"]:
			(line as Line2D).points = visible_points


func _update_leaves(progress: float) -> void:
	for data in _leaf_data:
		var sprite := data["node"] as Sprite2D
		var threshold := float(data["threshold"])
		var local_progress := clampf((progress - threshold) / 0.12, 0.0, 1.0)
		var eased := sin(local_progress * PI * 0.5)
		sprite.scale = (data["scale"] as Vector2) * eased
		sprite.modulate.a = eased * 0.92
		sprite.rotation = float(data["rotation"]) + (1.0 - eased) * 0.18


func _set_tip_glow(tip: Polygon2D, position_value: Vector2, alpha: float) -> void:
	tip.position = position_value
	tip.modulate.a = alpha


func _track_tween(tween: Tween) -> Tween:
	_owned_tweens.append(tween)
	return tween


func _kill_owned_tweens() -> void:
	for tween in _owned_tweens:
		if tween != null and tween.is_valid():
			tween.kill()
	_owned_tweens.clear()


func _emit_return_completed_once() -> void:
	if _return_emitted:
		return
	_return_emitted = true
	return_completed.emit()


func _on_confirm_button_mouse_entered() -> void:
	_button_mouse_inside = true
	_apply_button_visual_state()


func _on_confirm_button_mouse_exited() -> void:
	_button_mouse_inside = false
	_apply_button_visual_state()


func _on_confirm_button_down() -> void:
	_apply_button_visual_state()


func _on_confirm_button_up() -> void:
	_update_button_mouse_inside()
	_apply_button_visual_state()


func _on_confirm_button_focus_entered() -> void:
	_button_has_focus = true
	_apply_button_visual_state()


func _on_confirm_button_focus_exited() -> void:
	_button_has_focus = false
	_apply_button_visual_state()


func _update_button_mouse_inside() -> void:
	var mouse_pos := confirm_button.get_local_mouse_position()
	_button_mouse_inside = Rect2(Vector2.ZERO, confirm_button.size).has_point(mouse_pos)


func _apply_button_visual_state() -> void:
	confirm_button.texture_focused = confirm_button.texture_normal
	if confirm_button.disabled:
		confirm_button.modulate = Color(1.0, 1.0, 1.0, BUTTON_DISABLED_ALPHA)
		return
	var focus_boost := 1.04 if _button_has_focus and not _button_mouse_inside else 1.0
	confirm_button.scale = Vector2.ONE * focus_boost
	confirm_button.modulate = Color(1.0, 0.96 if _button_has_focus and not _button_mouse_inside else 1.0, 0.88 if _button_has_focus and not _button_mouse_inside else 1.0, BUTTON_ENABLED_ALPHA)


func _on_confirm_button_pressed() -> void:
	if _confirmation_emitted or confirm_button.disabled:
		return
	_confirmation_emitted = true
	confirm_button.disabled = true
	_play_button_press_feedback()
	confirmation_requested.emit()


func _play_button_press_feedback() -> void:
	var tween := _track_tween(create_tween())
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(confirm_button, "scale", BUTTON_PRESS_SCALE, 0.07)
	tween.parallel().tween_property(confirm_button, "position", _button_base_position + BUTTON_PRESS_OFFSET, 0.07)
	tween.parallel().tween_property(confirm_button, "modulate:a", BUTTON_PRESS_ALPHA, 0.07)
	tween.tween_property(confirm_button, "scale", Vector2.ONE, 0.14).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(confirm_button, "position", _button_base_position, 0.14).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(confirm_button, "modulate:a", 1.0, 0.14).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _configure_vine_line_styles() -> void:
	for line in [left_outer_glow, left_main_gold, left_inner_ivory, right_outer_glow, right_main_gold, right_inner_ivory]:
		line.joint_mode = Line2D.LINE_JOINT_ROUND
		line.begin_cap_mode = Line2D.LINE_CAP_ROUND
		line.end_cap_mode = Line2D.LINE_CAP_ROUND
	left_outer_glow.width = MAIN_VINE_WIDTHS.x
	left_main_gold.width = MAIN_VINE_WIDTHS.y
	left_inner_ivory.width = MAIN_VINE_WIDTHS.z
	right_outer_glow.width = MAIN_VINE_WIDTHS.x
	right_main_gold.width = MAIN_VINE_WIDTHS.y
	right_inner_ivory.width = MAIN_VINE_WIDTHS.z
	for line in [left_outer_glow, right_outer_glow]:
		line.default_color = VINE_OUTER_COLOR
	for line in [left_main_gold, right_main_gold]:
		line.default_color = VINE_MAIN_COLOR
	for line in [left_inner_ivory, right_inner_ivory]:
		line.default_color = VINE_INNER_COLOR


func _apply_responsive_layout() -> void:
	var viewport_size := _get_viewport_size()
	var scale_factor: float = clampf(viewport_size.y / 1080.0, 0.72, 1.08)
	var text_width: float = clampf(viewport_size.x * 0.49, 620.0, 940.0)
	var text_height: float = clampf(viewport_size.y * 0.235, 210.0, 270.0)
	reward_text_label.offset_left = -text_width * 0.5
	reward_text_label.offset_right = text_width * 0.5
	reward_text_label.offset_top = -text_height * 0.72
	reward_text_label.offset_bottom = text_height * 0.28
	reward_text_label.add_theme_font_override("normal_font", REWARD_FONT)
	reward_text_label.add_theme_font_override("italics_font", REWARD_FONT)
	reward_text_label.add_theme_font_override("bold_italics_font", REWARD_FONT)
	var reward_font_size := int(round(48.0 * scale_factor))
	reward_text_label.add_theme_font_size_override("normal_font_size", reward_font_size)
	reward_text_label.add_theme_font_size_override("italics_font_size", reward_font_size)
	reward_text_label.add_theme_font_size_override("bold_italics_font_size", reward_font_size)
	reward_text_label.add_theme_color_override("default_color", TEXT_COLOR)
	reward_text_label.add_theme_color_override("font_outline_color", TEXT_OUTLINE_COLOR)
	reward_text_label.add_theme_constant_override("outline_size", int(round(5.0 * scale_factor)))
	var button_size: float = clampf(viewport_size.y * 0.152, 120.0, 164.0)
	confirm_button.offset_left = -button_size * 0.5
	confirm_button.offset_right = button_size * 0.5
	confirm_button.offset_top = -button_size - 44.0 * scale_factor
	confirm_button.offset_bottom = -44.0 * scale_factor
	_button_base_position = confirm_button.position
	confirm_button.pivot_offset = Vector2(button_size, button_size) * 0.5
	_configure_button_hit_area()


func _configure_button_hit_area() -> void:
	confirm_button.mouse_filter = Control.MOUSE_FILTER_STOP
	confirm_button.ignore_texture_size = true
	if confirm_button.texture_normal != null and confirm_button.texture_normal is Texture2D:
		var image := confirm_button.texture_normal.get_image()
		if image != null:
			var click_mask := BitMap.new()
			click_mask.create_from_image_alpha(image, 0.12)
			confirm_button.texture_click_mask = click_mask


func _sample_main_tangent_rotation(points: PackedVector2Array, progress: float) -> float:
	if points.size() < 2:
		return 0.0
	var index := clampi(int(round(float(points.size() - 1) * progress)), 1, points.size() - 1)
	var tangent := points[index] - points[index - 1]
	if tangent.length_squared() <= 0.001:
		return 0.0
	return tangent.angle()


func _get_viewport_size() -> Vector2:
	var viewport_rect := get_viewport_rect()
	if viewport_rect.size.x <= 0.0 or viewport_rect.size.y <= 0.0:
		return Vector2(1920.0, 1080.0)
	return viewport_rect.size


func _bbcode_escape(value: String) -> String:
	return value.replace("[", "[lb]").replace("]", "[rb]")


func _hash_01(index: int, salt: int) -> float:
	var v: int = int(index * 92821 + salt * 68917 + 1337)
	v = int((v ^ (v >> 13)) * 1274126177)
	v = v ^ (v >> 16)
	var positive: int = v % 10000
	if positive < 0:
		positive = -positive
	return float(positive) / 10000.0


func _hash_signed(index: int, salt: int) -> float:
	return _hash_01(index, salt) * 2.0 - 1.0


func _hash_vector(index: int, salt: int) -> Vector2:
	return Vector2(_hash_signed(index, salt), _hash_signed(index, salt + 2))

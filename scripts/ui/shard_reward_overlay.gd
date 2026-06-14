extends Control
class_name ShardRewardOverlay

signal confirmation_requested
signal return_completed

const DEFAULT_REWARD_TEXT := "..."
const BUTTON_DISABLED_ALPHA := 0.58
const BUTTON_ENABLED_ALPHA := 1.0
const MATTE_VEIL_COLOR := Color(0.045, 0.028, 0.020, 0.38)
const WARM_WASH_COLOR := Color(0.46, 0.22, 0.10, 0.10)
const TEXT_HAZE_ALPHA := 0.82
const TEXT_COLOR := Color(1.0, 0.91, 0.72, 1.0)
const TEXT_OUTLINE_COLOR := Color(0.16, 0.07, 0.035, 1.0)
const BUTTON_PRESS_SCALE := Vector2(0.945, 0.945)
const BUTTON_PRESS_OFFSET := Vector2(0.0, 5.0)
const BUTTON_PRESS_ALPHA := 0.82
const FRAME_PARTICLE_COUNT := 40
const FRAME_TOP_COUNT := 12
const FRAME_BOTTOM_COUNT := 12
const FRAME_LEFT_COUNT := 8
const FRAME_RIGHT_COUNT := 8
const FRAME_FORMATION_DURATION := 0.86
const FRAME_COLORS := [
	Color(1.0, 0.82, 0.38, 0.92),
	Color(1.0, 0.94, 0.72, 0.88),
	Color(1.0, 0.58, 0.34, 0.78),
	Color(0.96, 0.72, 0.28, 0.86),
]
const VINE_LEAF_TEXTURE := preload("res://assets/ui/shard_reward_overlay/vine_leaf.png")
const VINE_GROWTH_DURATION := 2.3
const LEAF_THRESHOLDS := [0.28, 0.52, 0.74]
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
var _vine_progress := 0.0
var _left_main_points := PackedVector2Array()
var _right_main_points := PackedVector2Array()
var _branch_data: Array[Dictionary] = []
var _leaf_data: Array[Dictionary] = []

@onready var atmosphere: Control = $Atmosphere
@onready var matte_veil: ColorRect = $Atmosphere/MatteVeil
@onready var warm_wash: ColorRect = $Atmosphere/WarmWash
@onready var text_haze: Panel = $Atmosphere/TextHaze
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
	_configure_vine_line_styles()
	_apply_responsive_layout()
	_button_base_position = confirm_button.position
	_reset_visual_state(false)


func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED and is_node_ready():
		_apply_responsive_layout()
		_button_root.pivot_offset = button_root.size * 0.5


func _process(delta: float) -> void:
	_living_time += delta
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
	reward_text_label.text = "[center][i]%s[/i][/center]" % _bbcode_escape(text_to_show)
	reward_text_label.visible_ratio = 0.0
	matte_veil.color = MATTE_VEIL_COLOR
	warm_wash.color = WARM_WASH_COLOR
	button_root.modulate.a = BUTTON_DISABLED_ALPHA
	confirm_button.disabled = true
	_build_vine_geometry()
	_build_frame_particles(origin_screen_position)
	_animate_atmosphere_in()
	_start_frame_after_delay(generation)
	_start_vine_after_delay(generation)
	_start_haze_after_delay(generation)
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
	text_haze.modulate.a = 0.0
	light_frame_layer.modulate.a = 1.0
	vine_canvas.modulate.a = 1.0
	text_root.modulate.a = 0.0
	button_root.modulate.a = BUTTON_DISABLED_ALPHA
	reward_text_label.text = ""
	reward_text_label.visible_ratio = 0.0
	confirm_button.disabled = true
	confirm_button.scale = Vector2.ONE
	confirm_button.position = _button_base_position
	confirm_button.modulate = Color(1.0, 1.0, 1.0, 1.0)
	_vine_progress = 0.0
	_clear_line_points()
	_frame_particles.clear()
	_branch_data.clear()
	_leaf_data.clear()
	_clear_dynamic_children()
	_set_tip_glow(left_tip_glow, Vector2.ZERO, 0.0)
	_set_tip_glow(right_tip_glow, Vector2.ZERO, 0.0)


func _clear_line_points() -> void:
	for line in [left_outer_glow, left_main_gold, left_inner_ivory, right_outer_glow, right_main_gold, right_inner_ivory]:
		line.clear_points()


func _clear_dynamic_children() -> void:
	for layer in [light_frame_layer, branch_layer, leaf_layer]:
		for child in layer.get_children():
			child.queue_free()


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


func _start_haze_after_delay(generation: int) -> void:
	await get_tree().create_timer(0.25).timeout
	if generation != _sequence_generation:
		return
	var tween := _track_tween(create_tween())
	tween.tween_property(text_haze, "modulate:a", TEXT_HAZE_ALPHA, 0.42).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _start_text_after_delay(text_to_show: String, generation: int) -> void:
	await get_tree().create_timer(0.50).timeout
	if generation != _sequence_generation:
		return
	await _reveal_text(text_to_show)
	if generation != _sequence_generation:
		return
	_text_complete = true
	_try_enable_button(generation)


func _reveal_text(text_to_show: String) -> void:
	text_root.modulate.a = 1.0
	reward_text_label.visible_ratio = 0.0
	var reveal_duration: float = clampf(float(text_to_show.length()) * 0.035, 1.2, 2.5)
	var tween := _track_tween(create_tween())
	tween.set_parallel(true)
	tween.tween_property(reward_text_label, "visible_ratio", 1.0, reveal_duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(text_root, "modulate:a", 1.0, 0.22).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await tween.finished


func _try_enable_button(generation: int) -> void:
	if generation != _sequence_generation:
		return
	if not _text_complete or not _vine_complete:
		return
	button_root.modulate.a = BUTTON_ENABLED_ALPHA
	confirm_button.disabled = false
	confirm_button.grab_focus()


func _animate_return_sequence(target_screen_position: Vector2, generation: int) -> void:
	var viewport_size := _get_viewport_size()
	var target := target_screen_position.clamp(Vector2.ZERO, viewport_size)
	var tween := _track_tween(create_tween())
	tween.set_parallel(true)
	tween.tween_property(text_root, "modulate:a", 0.0, 0.22).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(text_haze, "modulate:a", 0.0, 0.26).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(button_root, "modulate:a", 0.0, 0.18).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(atmosphere, "modulate:a", 0.0, 0.42).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_method(_update_vine_visuals, _vine_progress, 0.0, 0.58).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	for i in range(_frame_particles.size()):
		var data := _frame_particles[i]
		var particle := data["node"] as Polygon2D
		if particle == null:
			continue
		var delay := float(i % 8) * 0.018 + _hash_01(i, 211) * 0.05
		var duration := 0.52 + _hash_01(i, 223) * 0.18
		tween.tween_property(particle, "position", target + _hash_vector(i, 227) * 7.0, duration).set_delay(delay).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		tween.tween_property(particle, "scale", Vector2.ZERO, duration * 0.82).set_delay(delay + duration * 0.12).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		tween.tween_property(particle, "modulate:a", 0.0, duration * 0.6).set_delay(delay + duration * 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	await tween.finished
	if generation != _sequence_generation:
		return


func _build_frame_particles(origin_screen_position: Vector2) -> void:
	for child in light_frame_layer.get_children():
		child.queue_free()
	_frame_particles.clear()
	var viewport_size := _get_viewport_size()
	var origin := origin_screen_position.clamp(Vector2.ZERO, viewport_size)
	var targets := _build_frame_targets(viewport_size)
	for i in range(FRAME_PARTICLE_COUNT):
		var particle := Polygon2D.new()
		particle.name = "LightFrameParticle_%02d" % i
		particle.polygon = _build_frame_particle_polygon(i)
		particle.color = FRAME_COLORS[i % FRAME_COLORS.size()]
		particle.position = origin + _hash_vector(i, 31) * 18.0
		particle.rotation = _hash_signed(i, 47) * 0.35
		particle.scale = Vector2.ZERO
		particle.modulate.a = 0.0
		light_frame_layer.add_child(particle)
		_frame_particles.append({
			"node": particle,
			"target": targets[i],
			"base_rotation": _hash_signed(i, 83) * 0.18,
			"phase": _hash_01(i, 97) * TAU,
			"speed": lerpf(0.55, 0.9, _hash_01(i, 109)),
		})


func _build_frame_targets(viewport_size: Vector2) -> Array[Vector2]:
	var rect := Rect2(viewport_size * Vector2(0.09, 0.08), viewport_size * Vector2(0.82, 0.80))
	var targets: Array[Vector2] = []
	for i in range(FRAME_TOP_COUNT):
		var t := float(i) / float(FRAME_TOP_COUNT - 1)
		targets.append(Vector2(lerpf(rect.position.x, rect.end.x, t), rect.position.y) + _hash_vector(i, 3) * 5.0)
	for i in range(FRAME_BOTTOM_COUNT):
		var t := float(i) / float(FRAME_BOTTOM_COUNT - 1)
		targets.append(Vector2(lerpf(rect.end.x, rect.position.x, t), rect.end.y) + _hash_vector(i, 5) * 5.0)
	for i in range(FRAME_LEFT_COUNT):
		var t := float(i + 1) / float(FRAME_LEFT_COUNT + 1)
		targets.append(Vector2(rect.position.x, lerpf(rect.position.y, rect.end.y, t)) + _hash_vector(i, 7) * 5.0)
	for i in range(FRAME_RIGHT_COUNT):
		var t := float(i + 1) / float(FRAME_RIGHT_COUNT + 1)
		targets.append(Vector2(rect.end.x, lerpf(rect.end.y, rect.position.y, t)) + _hash_vector(i, 11) * 5.0)
	return targets


func _build_frame_particle_polygon(index: int) -> PackedVector2Array:
	var width := lerpf(4.0, 7.0, _hash_01(index, 131))
	var height := lerpf(10.0, 17.0, _hash_01(index, 137))
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
		var phase := float(data["phase"])
		var speed := float(data["speed"])
		var offset := Vector2(sin(_living_time * speed + phase), cos(_living_time * speed * 0.79 + phase)) * 1.35
		particle.position = target + offset
		particle.rotation = float(data["base_rotation"]) + sin(_living_time * speed + phase) * 0.012
		particle.modulate.a = 0.88 + sin(_living_time * speed * 1.7 + phase) * 0.10


func _build_vine_geometry() -> void:
	_clear_line_points()
	for child in branch_layer.get_children():
		child.queue_free()
	for child in leaf_layer.get_children():
		child.queue_free()
	_branch_data.clear()
	_leaf_data.clear()
	var viewport_size := _get_viewport_size()
	var center_x := viewport_size.x * 0.5
	var origin := Vector2(center_x, viewport_size.y * 0.78)
	var left_curve := Curve2D.new()
	left_curve.bake_interval = 12.0
	_add_curve_point(left_curve, origin, Vector2.ZERO, Vector2(-viewport_size.x * 0.055, -viewport_size.y * 0.09))
	_add_curve_point(left_curve, Vector2(viewport_size.x * 0.38, viewport_size.y * 0.62), Vector2(viewport_size.x * 0.055, viewport_size.y * 0.05), Vector2(-viewport_size.x * 0.13, -viewport_size.y * 0.13))
	_add_curve_point(left_curve, Vector2(viewport_size.x * 0.25, viewport_size.y * 0.38), Vector2(viewport_size.x * 0.13, viewport_size.y * 0.10), Vector2(-viewport_size.x * 0.02, -viewport_size.y * 0.18))
	_add_curve_point(left_curve, Vector2(viewport_size.x * 0.37, viewport_size.y * 0.17), Vector2(-viewport_size.x * 0.13, viewport_size.y * 0.03), Vector2(viewport_size.x * 0.08, -viewport_size.y * 0.03))
	_add_curve_point(left_curve, Vector2(center_x, viewport_size.y * 0.29), Vector2(-viewport_size.x * 0.07, -viewport_size.y * 0.09), Vector2.ZERO)
	_left_main_points = left_curve.get_baked_points()
	_right_main_points = _mirror_points(_left_main_points, center_x)
	_build_branch_geometry(viewport_size, center_x)
	_build_leaf_geometry(viewport_size, center_x)
	_update_vine_visuals(0.0)


func _add_curve_point(curve: Curve2D, point: Vector2, in_handle: Vector2, out_handle: Vector2) -> void:
	curve.add_point(point, in_handle, out_handle)


func _mirror_points(points: PackedVector2Array, center_x: float) -> PackedVector2Array:
	var mirrored := PackedVector2Array()
	for point in points:
		mirrored.append(Vector2(center_x + (center_x - point.x), point.y))
	return mirrored


func _build_branch_geometry(viewport_size: Vector2, center_x: float) -> void:
	var branches := [
		{"side": -1, "threshold": 0.24, "anchor": Vector2(0.40, 0.60), "curl": Vector2(-0.08, -0.07)},
		{"side": -1, "threshold": 0.44, "anchor": Vector2(0.31, 0.44), "curl": Vector2(-0.08, 0.03)},
		{"side": -1, "threshold": 0.62, "anchor": Vector2(0.29, 0.29), "curl": Vector2(0.055, -0.055)},
		{"side": -1, "threshold": 0.78, "anchor": Vector2(0.39, 0.21), "curl": Vector2(-0.055, -0.02)},
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
		var end := start + Vector2(viewport_size.x * curl_x, viewport_size.y * curl_ratio.y)
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
	return line


func _build_leaf_geometry(viewport_size: Vector2, center_x: float) -> void:
	var leaf_ratios := [
		{"threshold": LEAF_THRESHOLDS[0], "left": Vector2(0.39, 0.58), "rotation": -0.55, "scale": 0.080},
		{"threshold": LEAF_THRESHOLDS[1], "left": Vector2(0.29, 0.38), "rotation": 0.28, "scale": 0.068},
		{"threshold": LEAF_THRESHOLDS[2], "left": Vector2(0.36, 0.22), "rotation": -0.18, "scale": 0.092},
	]
	for leaf in leaf_ratios:
		for side in [-1, 1]:
			var left_pos := leaf["left"] as Vector2
			var x_ratio: float = left_pos.x if side < 0 else 1.0 - left_pos.x
			var sprite := Sprite2D.new()
			sprite.name = "VineLeaf_%s_%02d" % ["Left" if side < 0 else "Right", _leaf_data.size()]
			sprite.texture = VINE_LEAF_TEXTURE
			sprite.centered = true
			sprite.position = Vector2(viewport_size.x * x_ratio, viewport_size.y * left_pos.y)
			var target_scale := float(leaf["scale"]) * viewport_size.y / 1024.0
			sprite.scale = Vector2.ZERO
			sprite.rotation = float(leaf["rotation"]) * side
			sprite.modulate = Color(1.0, 0.84 + 0.04 * float(_leaf_data.size() % 2), 0.52, 0.0)
			leaf_layer.add_child(sprite)
			_leaf_data.append({"node": sprite, "threshold": float(leaf["threshold"]), "scale": Vector2(target_scale * side, target_scale), "rotation": sprite.rotation})


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
	var visible := PackedVector2Array()
	if points.is_empty() or progress <= 0.0:
		return visible
	var count := clampi(int(ceil(float(points.size()) * progress)), 1, points.size())
	for i in range(count):
		visible.append(points[i])
	return visible


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
	var haze_width: float = clampf(viewport_size.x * 0.58, 760.0, 1120.0)
	var haze_height: float = clampf(viewport_size.y * 0.32, 250.0, 350.0)
	text_haze.offset_left = -haze_width * 0.5
	text_haze.offset_right = haze_width * 0.5
	text_haze.offset_top = -haze_height * 0.5
	text_haze.offset_bottom = haze_height * 0.5
	var text_width: float = haze_width - 120.0 * scale_factor
	var text_height: float = haze_height - 90.0 * scale_factor
	reward_text_label.offset_left = -text_width * 0.5
	reward_text_label.offset_right = text_width * 0.5
	reward_text_label.offset_top = -text_height * 0.5
	reward_text_label.offset_bottom = text_height * 0.5
	reward_text_label.add_theme_font_size_override("normal_font_size", int(round(52.0 * scale_factor)))
	reward_text_label.add_theme_color_override("default_color", TEXT_COLOR)
	reward_text_label.add_theme_color_override("font_outline_color", TEXT_OUTLINE_COLOR)
	reward_text_label.add_theme_constant_override("outline_size", int(round(6.0 * scale_factor)))
	var button_size: float = clampf(viewport_size.y * 0.17, 132.0, 184.0)
	confirm_button.offset_left = -button_size * 0.5
	confirm_button.offset_right = button_size * 0.5
	confirm_button.offset_top = -button_size - 52.0 * scale_factor
	confirm_button.offset_bottom = -52.0 * scale_factor
	_button_base_position = confirm_button.position
	confirm_button.pivot_offset = Vector2(button_size, button_size) * 0.5


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

extends Control
class_name ShardRewardOverlay

signal confirmation_requested
signal return_completed

const DEFAULT_REWARD_TEXT := "..."
const MINT := Color(0.68, 1.0, 0.86, 0.24)
const PINK := Color(1.0, 0.66, 0.82, 0.18)
const ORANGE := Color(1.0, 0.72, 0.42, 0.16)
const FRAGMENT_COLORS := [
	Color(0.78, 1.0, 0.92, 0.92),
	Color(1.0, 0.76, 0.88, 0.84),
	Color(1.0, 0.78, 0.48, 0.78),
	Color(0.9, 0.84, 1.0, 0.82),
]

@export_range(24, 40, 1) var fragment_count: int = 34
@export var frame_margin: float = 84.0
@export var formation_duration: float = 1.15
@export var text_reveal_seconds_per_character: float = 0.035
@export var min_text_reveal_duration: float = 1.2
@export var max_text_reveal_duration: float = 2.5
@export var living_motion_amplitude: float = 3.0
@export var living_rotation_amplitude: float = 0.035

var _fragments: Array[Dictionary] = []
var _living_time := 0.0
var _is_alive := false
var _confirmation_emitted := false
var _active_tween: Tween = null

@onready var background: Control = $Background
@onready var mint_wash: ColorRect = $Background/MintWash
@onready var pink_wash: ColorRect = $Background/PinkWash
@onready var orange_wash: ColorRect = $Background/OrangeWash
@onready var fragment_layer: Node2D = $FragmentLayer
@onready var content: Control = $Content
@onready var reward_text_label: RichTextLabel = $Content/RewardText
@onready var confirm_button: Button = $Content/ConfirmButton


func _ready() -> void:
	visible = false
	mouse_filter = Control.MOUSE_FILTER_STOP
	set_process(false)
	confirm_button.pressed.connect(_on_confirm_button_pressed)
	_reset_visual_state()


func _process(delta: float) -> void:
	if not _is_alive:
		return

	_living_time += delta
	for data in _fragments:
		var fragment := data["node"] as Polygon2D
		if fragment == null:
			continue
		var target := data["target"] as Vector2
		var phase := float(data["phase"])
		var speed := float(data["speed"])
		var base_rotation := float(data["base_rotation"])
		var offset := Vector2(
			sin(_living_time * speed + phase),
			cos(_living_time * (speed * 0.83) + phase * 1.7)
		) * living_motion_amplitude
		fragment.position = target + offset
		fragment.rotation = base_rotation + sin(_living_time * speed + phase) * living_rotation_amplitude


func play_reward(display_text: String, origin_screen_position: Vector2) -> void:
	_play_reward_async(display_text, origin_screen_position)


func play_return_to(target_screen_position: Vector2) -> void:
	_play_return_to_async(target_screen_position)


func reset_overlay() -> void:
	_reset_visual_state()
	visible = false


func _play_reward_async(display_text: String, origin_screen_position: Vector2) -> void:
	_reset_visual_state()
	visible = true
	_is_alive = false
	_confirmation_emitted = false
	var viewport_size := _get_viewport_size()
	var origin := origin_screen_position.clamp(Vector2.ZERO, viewport_size)
	var text_to_show := display_text
	if text_to_show.strip_edges().is_empty():
		text_to_show = DEFAULT_REWARD_TEXT

	_build_fragments(origin, viewport_size)
	_animate_background()
	await _animate_fragments()
	_is_alive = true
	set_process(true)
	await _reveal_text(text_to_show)
	confirm_button.visible = true
	confirm_button.disabled = false
	confirm_button.grab_focus()


func _play_return_to_async(target_screen_position: Vector2) -> void:
	if not visible:
		return_completed.emit()
		return

	if _active_tween != null and _active_tween.is_valid():
		_active_tween.kill()
	_is_alive = false
	set_process(false)
	confirm_button.disabled = true
	confirm_button.visible = false

	var viewport_size := _get_viewport_size()
	var target := target_screen_position.clamp(Vector2.ZERO, viewport_size)
	_active_tween = create_tween()
	_active_tween.set_parallel(true)
	_active_tween.tween_property(content, "modulate:a", 0.0, 0.22).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	_active_tween.tween_property(background, "modulate:a", 0.0, 0.55).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	for i in range(_fragments.size()):
		var data := _fragments[i]
		var fragment := data["node"] as Polygon2D
		if fragment == null:
			continue
		var delay := float(i % 7) * 0.035 + _hash_01(i, 211) * 0.08
		var duration := 0.58 + _hash_01(i, 223) * 0.22
		_active_tween.tween_property(fragment, "position", target + _hash_vector(i, 227) * 8.0, duration).set_delay(delay).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		_active_tween.tween_property(fragment, "scale", Vector2.ZERO, duration * 0.82).set_delay(delay + duration * 0.18).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		_active_tween.tween_property(fragment, "modulate:a", 0.0, duration * 0.55).set_delay(delay + duration * 0.38).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	await _active_tween.finished
	visible = false
	return_completed.emit()


func _reset_visual_state() -> void:
	if _active_tween != null and _active_tween.is_valid():
		_active_tween.kill()
	for child in fragment_layer.get_children():
		child.queue_free()
	_fragments.clear()
	_living_time = 0.0
	_is_alive = false
	set_process(false)
	background.modulate.a = 0.0
	content.modulate.a = 0.0
	reward_text_label.text = ""
	reward_text_label.visible_ratio = 0.0
	confirm_button.visible = false
	confirm_button.disabled = true
	mint_wash.color = MINT
	pink_wash.color = PINK
	orange_wash.color = ORANGE


func _build_fragments(origin: Vector2, viewport_size: Vector2) -> void:
	var targets := _build_frame_targets(viewport_size)
	for i in range(fragment_count):
		var fragment := Polygon2D.new()
		fragment.name = "FrameFragment_%02d" % i
		fragment.polygon = _build_fragment_polygon(i)
		fragment.color = FRAGMENT_COLORS[i % FRAGMENT_COLORS.size()]
		fragment.position = origin + _hash_vector(i, 31) * 18.0
		fragment.rotation = _hash_signed(i, 47) * PI
		fragment.scale = Vector2.ONE * lerpf(0.65, 1.35, _hash_01(i, 59))
		fragment.modulate.a = 0.0
		fragment_layer.add_child(fragment)

		var target := targets[i % targets.size()] + _hash_vector(i, 71) * 16.0
		var target_rotation := _hash_signed(i, 83) * 0.45
		_fragments.append({
			"node": fragment,
			"target": target,
			"phase": _hash_01(i, 97) * TAU,
			"speed": lerpf(0.55, 1.05, _hash_01(i, 109)),
			"base_rotation": target_rotation,
		})


func _build_frame_targets(viewport_size: Vector2) -> Array[Vector2]:
	var targets: Array[Vector2] = []
	var left: float = frame_margin
	var right: float = maxf(frame_margin, viewport_size.x - frame_margin)
	var top: float = frame_margin
	var bottom: float = maxf(frame_margin, viewport_size.y - frame_margin)
	var horizontal_count: int = int(fragment_count * 0.32)
	var vertical_count: int = int(fragment_count * 0.18)
	var corner_count: int = maxi(2, int((fragment_count - horizontal_count * 2 - vertical_count * 2) / 4))

	for i in range(horizontal_count):
		var t := float(i) / float(max(horizontal_count - 1, 1))
		targets.append(Vector2(lerpf(left + 90.0, right - 90.0, t), top + _hash_signed(i, 3) * 22.0))
		targets.append(Vector2(lerpf(right - 70.0, left + 70.0, t), bottom + _hash_signed(i, 5) * 22.0))

	for i in range(vertical_count):
		var t := float(i) / float(max(vertical_count - 1, 1))
		targets.append(Vector2(left + _hash_signed(i, 7) * 22.0, lerpf(top + 80.0, bottom - 80.0, t)))
		targets.append(Vector2(right + _hash_signed(i, 11) * 22.0, lerpf(bottom - 80.0, top + 80.0, t)))

	var corners := [Vector2(left, top), Vector2(right, top), Vector2(right, bottom), Vector2(left, bottom)]
	for corner_index in range(corners.size()):
		for j in range(corner_count):
			targets.append(corners[corner_index] + _hash_vector(corner_index * 100 + j, 13) * 42.0)

	while targets.size() < fragment_count:
		var index := targets.size()
		targets.append(Vector2(lerpf(left, right, _hash_01(index, 17)), lerpf(top, bottom, _hash_01(index, 19))))
	return targets


func _build_fragment_polygon(index: int) -> PackedVector2Array:
	var radius: float = lerpf(8.0, 18.0, _hash_01(index, 131))
	return PackedVector2Array([
		Vector2(-radius * 0.65, -radius * 0.35),
		Vector2(radius * 0.78, -radius * lerpf(0.25, 0.75, _hash_01(index, 137))),
		Vector2(radius * lerpf(0.25, 0.85, _hash_01(index, 139)), radius * 0.72),
		Vector2(-radius * lerpf(0.45, 0.9, _hash_01(index, 149)), radius * 0.38),
	])


func _animate_background() -> void:
	var tween := create_tween()
	tween.tween_property(background, "modulate:a", 1.0, formation_duration * 0.85).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _animate_fragments() -> void:
	_active_tween = create_tween()
	_active_tween.set_parallel(true)
	for i in range(_fragments.size()):
		var data := _fragments[i]
		var fragment := data["node"] as Polygon2D
		var target := data["target"] as Vector2
		var target_rotation := float(data["base_rotation"])
		var delay := _hash_01(i, 151) * 0.18
		_active_tween.tween_property(fragment, "position", target, formation_duration).set_delay(delay).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		_active_tween.tween_property(fragment, "rotation", target_rotation, formation_duration).set_delay(delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		_active_tween.tween_property(fragment, "modulate:a", 1.0, formation_duration * 0.6).set_delay(delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await _active_tween.finished


func _reveal_text(text_to_show: String) -> void:
	reward_text_label.text = "[center][i]%s[/i][/center]" % _bbcode_escape(text_to_show)
	reward_text_label.visible_ratio = 0.0
	var reveal_duration: float = clampf(float(text_to_show.length()) * text_reveal_seconds_per_character, min_text_reveal_duration, max_text_reveal_duration)
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(content, "modulate:a", 1.0, 0.35).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(reward_text_label, "visible_ratio", 1.0, reveal_duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	await tween.finished


func _on_confirm_button_pressed() -> void:
	if _confirmation_emitted:
		return
	_confirmation_emitted = true
	confirm_button.disabled = true
	confirmation_requested.emit()


func _get_viewport_size() -> Vector2:
	var viewport_rect: Rect2 = get_viewport_rect()
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

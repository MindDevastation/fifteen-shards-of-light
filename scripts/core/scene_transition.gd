extends CanvasLayer
class_name SceneTransitionService

signal transition_started
signal scene_changed
signal transition_finished(scene_path: String)
signal transition_failed(scene_path: String, error_code: int)

const TRANSITION_COLOR := Color(0.035, 0.020, 0.028, 1.0)
const CAMERA_WAIT_TIMEOUT := 1.25

var _busy := false
@onready var veil: ColorRect = $Veil

func _ready() -> void:
	layer = 1000
	process_mode = Node.PROCESS_MODE_ALWAYS
	veil.color = TRANSITION_COLOR
	veil.modulate.a = 0.0
	veil.mouse_filter = Control.MOUSE_FILTER_IGNORE

func transition_to(scene_path: String, fade_in_duration: float = 0.55, fade_out_duration: float = 0.70) -> int:
	if _busy:
		return ERR_BUSY
	if scene_path.is_empty():
		return ERR_INVALID_PARAMETER
	_busy = true
	_run_transition.call_deferred(scene_path, fade_in_duration, fade_out_duration)
	return OK

func _run_transition(scene_path: String, fade_in_duration: float, fade_out_duration: float) -> void:
	transition_started.emit()
	var fade_in := create_tween()
	fade_in.tween_property(veil, "modulate:a", 1.0, fade_in_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await fade_in.finished
	veil.modulate.a = 1.0
	var error := get_tree().change_scene_to_file(scene_path)
	if error != OK:
		await _fade_back_after_failure(scene_path, error, fade_out_duration)
		return
	scene_changed.emit()
	await get_tree().process_frame
	await get_tree().process_frame
	await _wait_for_camera_or_timeout()
	var fade_out := create_tween()
	fade_out.tween_property(veil, "modulate:a", 0.0, fade_out_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await fade_out.finished
	veil.modulate.a = 0.0
	_busy = false
	transition_finished.emit(scene_path)

func _fade_back_after_failure(scene_path: String, error: int, duration: float) -> void:
	var fade := create_tween()
	fade.tween_property(veil, "modulate:a", 0.0, minf(duration, 0.35)).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await fade.finished
	veil.modulate.a = 0.0
	_busy = false
	transition_failed.emit(scene_path, error)

func _wait_for_camera_or_timeout() -> void:
	var elapsed := 0.0
	while elapsed < CAMERA_WAIT_TIMEOUT:
		if get_viewport().get_camera_3d() != null:
			return
		await get_tree().process_frame
		elapsed += get_process_delta_time()

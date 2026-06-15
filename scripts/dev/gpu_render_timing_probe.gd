extends Node
class_name GpuRenderTimingProbe

## Dev-only GPU/render timing capture. It is inactive until start_capture() is called.
## It never traverses the scene tree and disables viewport timing immediately after capture.

signal capture_finished(output_path: String)

const MAX_SAMPLES := 7200

@export var warmup_seconds: float = 5.0
@export var capture_seconds: float = 30.0
@export var output_directory: String = "user://performance"

var _capturing := false
var _warmup_remaining := 0.0
var _capture_remaining := 0.0
var _capture_elapsed := 0.0
var _sample_count := 0
var _scene_label := "manual"
var _phase_label := "gpu_diagnostic"
var _viewport_rid := RID()

var _time_sec_samples := PackedFloat64Array()
var _frame_time_ms_samples := PackedFloat64Array()
var _render_cpu_ms_samples := PackedFloat64Array()
var _render_gpu_ms_samples := PackedFloat64Array()
var _frame_setup_cpu_ms_samples := PackedFloat64Array()
var _draw_call_samples := PackedInt64Array()
var _objects_drawn_samples := PackedInt64Array()


func _ready() -> void:
	_allocate_buffers()
	set_process(false)


func is_capture_running() -> bool:
	return _capturing


func start_capture(scene_label: String = "", phase_label: String = "gpu_diagnostic") -> bool:
	if _capturing:
		print("GPU diagnostic capture is already running.")
		return false

	_scene_label = scene_label if not scene_label.is_empty() else _get_current_scene_label()
	_phase_label = phase_label if not phase_label.is_empty() else "gpu_diagnostic"
	_warmup_remaining = maxf(0.0, warmup_seconds)
	_capture_remaining = maxf(0.0, capture_seconds)
	_capture_elapsed = 0.0
	_sample_count = 0
	_viewport_rid = get_viewport().get_viewport_rid()
	RenderingServer.viewport_set_measure_render_time(_viewport_rid, true)
	_capturing = true
	set_process(true)

	print("GPU diagnostic started: %s / %s. Warm-up %.1fs, capture %.1fs." % [
		_scene_label,
		_phase_label,
		_warmup_remaining,
		_capture_remaining,
	])
	print("Video adapter: ", RenderingServer.get_video_adapter_name())
	print("Video vendor: ", RenderingServer.get_video_adapter_vendor())
	print("Video API: ", RenderingServer.get_video_adapter_api_version())
	print("Rendering method: ", RenderingServer.get_current_rendering_method())
	print("Rendering driver: ", RenderingServer.get_current_rendering_driver_name())
	return true


func cancel_capture() -> void:
	if not _capturing:
		return
	_capturing = false
	set_process(false)
	_disable_viewport_measurement()
	print("GPU diagnostic capture cancelled.")


func _process(delta: float) -> void:
	if not _capturing:
		return

	if _warmup_remaining > 0.0:
		_warmup_remaining = maxf(0.0, _warmup_remaining - delta)
		return

	if _sample_count >= MAX_SAMPLES:
		_finish_capture_deferred()
		return

	_capture_remaining -= delta
	_capture_elapsed += delta
	_store_sample(_sample_count, delta)
	_sample_count += 1

	if _capture_remaining <= 0.0:
		_finish_capture_deferred()


func _store_sample(index: int, delta: float) -> void:
	_time_sec_samples[index] = _capture_elapsed
	_frame_time_ms_samples[index] = delta * 1000.0
	_render_cpu_ms_samples[index] = RenderingServer.viewport_get_measured_render_time_cpu(_viewport_rid)
	_render_gpu_ms_samples[index] = RenderingServer.viewport_get_measured_render_time_gpu(_viewport_rid)
	_frame_setup_cpu_ms_samples[index] = RenderingServer.get_frame_setup_time_cpu()
	_draw_call_samples[index] = int(Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME))
	_objects_drawn_samples[index] = int(Performance.get_monitor(Performance.RENDER_TOTAL_OBJECTS_IN_FRAME))


func _finish_capture_deferred() -> void:
	if not _capturing:
		return
	_capturing = false
	set_process(false)
	_disable_viewport_measurement()
	call_deferred("_write_results")


func _disable_viewport_measurement() -> void:
	if _viewport_rid.is_valid():
		RenderingServer.viewport_set_measure_render_time(_viewport_rid, false)


func _write_results() -> void:
	if _sample_count <= 0:
		push_warning("GPU diagnostic completed without samples.")
		return

	var absolute_directory := ProjectSettings.globalize_path(output_directory)
	var dir_error := DirAccess.make_dir_recursive_absolute(absolute_directory)
	if dir_error != OK and dir_error != ERR_ALREADY_EXISTS:
		push_error("Could not create performance output directory: %s" % absolute_directory)
		return

	var timestamp := Time.get_datetime_string_from_system(false, true)
	timestamp = timestamp.replace(":", "").replace("-", "").replace(" ", "_")
	var path := "%s/gpu_%s_%s_%s.csv" % [
		output_directory,
		_sanitize_filename(_scene_label),
		_sanitize_filename(_phase_label),
		timestamp,
	]
	var file := FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		push_error("Could not write GPU diagnostic CSV: %s" % path)
		return

	var summary := _build_summary()
	var viewport_size := get_viewport().get_visible_rect().size
	file.store_line("# GpuRenderTimingProbe")
	file.store_line("# scene,%s" % _scene_label)
	file.store_line("# phase,%s" % _phase_label)
	file.store_line("# sample_count,%d" % _sample_count)
	file.store_line("# video_adapter,%s" % RenderingServer.get_video_adapter_name())
	file.store_line("# video_vendor,%s" % RenderingServer.get_video_adapter_vendor())
	file.store_line("# video_api,%s" % RenderingServer.get_video_adapter_api_version())
	file.store_line("# rendering_method,%s" % RenderingServer.get_current_rendering_method())
	file.store_line("# rendering_driver,%s" % RenderingServer.get_current_rendering_driver_name())
	file.store_line("# viewport_width,%d" % int(viewport_size.x))
	file.store_line("# viewport_height,%d" % int(viewport_size.y))
	file.store_line("# average_fps_from_frame_times,%.4f" % summary["average_fps"])
	file.store_line("# average_render_cpu_ms,%.4f" % summary["average_render_cpu_ms"])
	file.store_line("# average_render_gpu_ms,%.4f" % summary["average_render_gpu_ms"])
	file.store_line("# average_frame_setup_cpu_ms,%.4f" % summary["average_frame_setup_cpu_ms"])
	file.store_line("# p95_render_gpu_ms,%.4f" % summary["p95_render_gpu_ms"])
	file.store_line("# average_draw_calls,%.4f" % summary["average_draw_calls"])
	file.store_line("# average_objects_drawn,%.4f" % summary["average_objects_drawn"])
	file.store_line("sample,time_sec,frame_time_ms,render_cpu_ms,render_gpu_ms,frame_setup_cpu_ms,draw_calls,objects_drawn")

	for i in range(_sample_count):
		file.store_line("%d,%.6f,%.4f,%.4f,%.4f,%.4f,%d,%d" % [
			i + 1,
			_time_sec_samples[i],
			_frame_time_ms_samples[i],
			_render_cpu_ms_samples[i],
			_render_gpu_ms_samples[i],
			_frame_setup_cpu_ms_samples[i],
			_draw_call_samples[i],
			_objects_drawn_samples[i],
		])

	file.close()
	var absolute_path := ProjectSettings.globalize_path(path)
	print("GPU diagnostic complete.")
	print("GPU diagnostic CSV: ", absolute_path)
	print("GPU summary: avg %.2f FPS | render CPU %.2f ms | render GPU %.2f ms | setup CPU %.2f ms | p95 GPU %.2f ms" % [
		summary["average_fps"],
		summary["average_render_cpu_ms"],
		summary["average_render_gpu_ms"],
		summary["average_frame_setup_cpu_ms"],
		summary["p95_render_gpu_ms"],
	])
	capture_finished.emit(absolute_path)


func _build_summary() -> Dictionary:
	var total_frame_time := 0.0
	var total_render_cpu := 0.0
	var total_render_gpu := 0.0
	var total_setup_cpu := 0.0
	var total_draw_calls := 0.0
	var total_objects_drawn := 0.0
	var sorted_gpu: Array[float] = []
	sorted_gpu.resize(_sample_count)

	for i in range(_sample_count):
		total_frame_time += _frame_time_ms_samples[i]
		total_render_cpu += _render_cpu_ms_samples[i]
		total_render_gpu += _render_gpu_ms_samples[i]
		total_setup_cpu += _frame_setup_cpu_ms_samples[i]
		total_draw_calls += float(_draw_call_samples[i])
		total_objects_drawn += float(_objects_drawn_samples[i])
		sorted_gpu[i] = _render_gpu_ms_samples[i]

	sorted_gpu.sort()
	var count := float(_sample_count)
	var average_frame_time := total_frame_time / count
	return {
		"average_fps": 1000.0 / maxf(average_frame_time, 0.001),
		"average_render_cpu_ms": total_render_cpu / count,
		"average_render_gpu_ms": total_render_gpu / count,
		"average_frame_setup_cpu_ms": total_setup_cpu / count,
		"p95_render_gpu_ms": _percentile(sorted_gpu, 0.95),
		"average_draw_calls": total_draw_calls / count,
		"average_objects_drawn": total_objects_drawn / count,
	}


func _percentile(sorted_values: Array[float], percentile: float) -> float:
	if sorted_values.is_empty():
		return 0.0
	var index := clampi(int(ceil(percentile * float(sorted_values.size()))) - 1, 0, sorted_values.size() - 1)
	return sorted_values[index]


func _allocate_buffers() -> void:
	_time_sec_samples.resize(MAX_SAMPLES)
	_frame_time_ms_samples.resize(MAX_SAMPLES)
	_render_cpu_ms_samples.resize(MAX_SAMPLES)
	_render_gpu_ms_samples.resize(MAX_SAMPLES)
	_frame_setup_cpu_ms_samples.resize(MAX_SAMPLES)
	_draw_call_samples.resize(MAX_SAMPLES)
	_objects_drawn_samples.resize(MAX_SAMPLES)


func _get_current_scene_label() -> String:
	var scene := get_tree().current_scene
	if scene == null:
		return "no_scene"
	if scene.scene_file_path.is_empty():
		return scene.name
	return scene.scene_file_path.get_file().get_basename()


func _sanitize_filename(value: String) -> String:
	var result := value.strip_edges()
	if result.is_empty():
		result = "manual"
	for token in ["/", "\\", ":", "*", "?", "\"", "<", ">", "|", " "]:
		result = result.replace(token, "_")
	return result

extends Node
class_name LightweightPerformanceProbe

## Dev-only, instrumentation-only benchmark helper.
## It performs no work until start_capture() is called and never traverses the scene tree.

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
var _phase_label := "manual"
var _capture_started_announced := false

var _time_sec_samples := PackedFloat64Array()
var _smoothed_fps_samples := PackedFloat64Array()
var _frame_time_ms_samples := PackedFloat64Array()
var _process_time_ms_samples := PackedFloat64Array()
var _physics_time_ms_samples := PackedFloat64Array()
var _draw_call_samples := PackedInt64Array()
var _objects_drawn_samples := PackedInt64Array()
var _object_count_samples := PackedInt64Array()
var _static_memory_samples := PackedInt64Array()


func _ready() -> void:
	_allocate_buffers()
	set_process(false)


func is_capture_running() -> bool:
	return _capturing


func start_capture(scene_label: String = "", phase_label: String = "manual") -> bool:
	if _capturing:
		print("Performance capture is already running.")
		return false

	_scene_label = scene_label if not scene_label.is_empty() else _get_current_scene_label()
	_phase_label = phase_label if not phase_label.is_empty() else "manual"
	_warmup_remaining = maxf(0.0, warmup_seconds)
	_capture_remaining = maxf(0.0, capture_seconds)
	_capture_elapsed = 0.0
	_sample_count = 0
	_capture_started_announced = false
	_capturing = true
	set_process(true)

	print(
		"Performance benchmark started: %s / %s. Warm-up %.1fs, capture %.1fs."
		% [_scene_label, _phase_label, _warmup_remaining, _capture_remaining]
	)
	return true


func cancel_capture() -> void:
	if not _capturing:
		return
	_capturing = false
	set_process(false)
	print("Performance benchmark capture cancelled.")


func _process(delta: float) -> void:
	if not _capturing:
		return

	if _warmup_remaining > 0.0:
		_warmup_remaining = maxf(0.0, _warmup_remaining - delta)
		return

	if not _capture_started_announced:
		_capture_started_announced = true
		print("Performance benchmark capture phase started.")

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
	_smoothed_fps_samples[index] = float(Engine.get_frames_per_second())
	_frame_time_ms_samples[index] = delta * 1000.0
	_process_time_ms_samples[index] = Performance.get_monitor(Performance.TIME_PROCESS) * 1000.0
	_physics_time_ms_samples[index] = Performance.get_monitor(Performance.TIME_PHYSICS_PROCESS) * 1000.0
	_draw_call_samples[index] = int(Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME))
	_objects_drawn_samples[index] = int(Performance.get_monitor(Performance.RENDER_TOTAL_OBJECTS_IN_FRAME))
	_object_count_samples[index] = int(Performance.get_monitor(Performance.OBJECT_COUNT))
	_static_memory_samples[index] = int(Performance.get_monitor(Performance.MEMORY_STATIC))


func _finish_capture_deferred() -> void:
	if not _capturing:
		return
	_capturing = false
	set_process(false)
	call_deferred("_write_results")


func _write_results() -> void:
	if _sample_count <= 0:
		push_warning("Performance benchmark completed without samples.")
		return

	var absolute_directory := ProjectSettings.globalize_path(output_directory)
	var dir_error := DirAccess.make_dir_recursive_absolute(absolute_directory)
	if dir_error != OK and dir_error != ERR_ALREADY_EXISTS:
		push_error("Could not create performance output directory: %s" % absolute_directory)
		return

	var timestamp := Time.get_datetime_string_from_system(false, true)
	timestamp = timestamp.replace(":", "").replace("-", "").replace(" ", "_")
	var safe_scene := _sanitize_filename(_scene_label)
	var safe_phase := _sanitize_filename(_phase_label)
	var path := "%s/perf_%s_%s_%s.csv" % [output_directory, safe_scene, safe_phase, timestamp]
	var file := FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		push_error("Could not write performance CSV: %s" % path)
		return

	var summary := _build_summary()
	file.store_line("# LightweightPerformanceProbe")
	file.store_line("# scene,%s" % _scene_label)
	file.store_line("# phase,%s" % _phase_label)
	file.store_line("# sample_count,%d" % _sample_count)
	file.store_line("# average_fps_from_frame_times,%.4f" % summary["average_fps"])
	file.store_line("# median_frame_time_ms,%.4f" % summary["median_frame_time_ms"])
	file.store_line("# p95_frame_time_ms,%.4f" % summary["p95_frame_time_ms"])
	file.store_line("# p99_frame_time_ms,%.4f" % summary["p99_frame_time_ms"])
	file.store_line("# one_percent_low_fps,%.4f" % summary["one_percent_low_fps"])
	file.store_line("# minimum_fps,%.4f" % summary["minimum_fps"])
	file.store_line("# maximum_frame_time_ms,%.4f" % summary["maximum_frame_time_ms"])
	file.store_line("# average_process_time_ms,%.4f" % summary["average_process_time_ms"])
	file.store_line("# average_physics_time_ms,%.4f" % summary["average_physics_time_ms"])
	file.store_line("# average_draw_calls,%.4f" % summary["average_draw_calls"])
	file.store_line("# average_objects_drawn,%.4f" % summary["average_objects_drawn"])
	file.store_line("# one_percent_low_method,1000 divided by average of slowest ceil(sample_count * 0.01) frame times")
	file.store_line("sample,time_sec,smoothed_fps,frame_time_ms,process_time_ms,physics_time_ms,draw_calls,objects_drawn,object_count,static_memory_bytes")

	for i in range(_sample_count):
		file.store_line("%d,%.6f,%.3f,%.4f,%.4f,%.4f,%d,%d,%d,%d" % [
			i + 1,
			_time_sec_samples[i],
			_smoothed_fps_samples[i],
			_frame_time_ms_samples[i],
			_process_time_ms_samples[i],
			_physics_time_ms_samples[i],
			_draw_call_samples[i],
			_objects_drawn_samples[i],
			_object_count_samples[i],
			_static_memory_samples[i],
		])

	file.close()
	var absolute_path := ProjectSettings.globalize_path(path)
	print("Performance benchmark complete.")
	print("Performance CSV: ", absolute_path)
	print(
		"Summary: avg %.2f FPS | 1%% low %.2f FPS | p95 %.2f ms | process %.2f ms | physics %.2f ms | draw calls %.1f"
		% [
			summary["average_fps"],
			summary["one_percent_low_fps"],
			summary["p95_frame_time_ms"],
			summary["average_process_time_ms"],
			summary["average_physics_time_ms"],
			summary["average_draw_calls"],
		]
	)
	capture_finished.emit(absolute_path)


func _build_summary() -> Dictionary:
	var sorted_frame_times: Array[float] = []
	sorted_frame_times.resize(_sample_count)
	var total_frame_time := 0.0
	var total_process_time := 0.0
	var total_physics_time := 0.0
	var total_draw_calls := 0.0
	var total_objects_drawn := 0.0

	for i in range(_sample_count):
		var frame_time := _frame_time_ms_samples[i]
		sorted_frame_times[i] = frame_time
		total_frame_time += frame_time
		total_process_time += _process_time_ms_samples[i]
		total_physics_time += _physics_time_ms_samples[i]
		total_draw_calls += float(_draw_call_samples[i])
		total_objects_drawn += float(_objects_drawn_samples[i])

	sorted_frame_times.sort()
	var average_frame_time := total_frame_time / float(_sample_count)
	var worst_count := maxi(1, int(ceil(float(_sample_count) * 0.01)))
	var worst_total := 0.0
	for i in range(_sample_count - worst_count, _sample_count):
		worst_total += sorted_frame_times[i]
	var worst_average_frame_time := worst_total / float(worst_count)
	var maximum_frame_time := sorted_frame_times[_sample_count - 1]

	return {
		"average_fps": 1000.0 / maxf(average_frame_time, 0.001),
		"median_frame_time_ms": _percentile(sorted_frame_times, 0.50),
		"p95_frame_time_ms": _percentile(sorted_frame_times, 0.95),
		"p99_frame_time_ms": _percentile(sorted_frame_times, 0.99),
		"one_percent_low_fps": 1000.0 / maxf(worst_average_frame_time, 0.001),
		"minimum_fps": 1000.0 / maxf(maximum_frame_time, 0.001),
		"maximum_frame_time_ms": maximum_frame_time,
		"average_process_time_ms": total_process_time / float(_sample_count),
		"average_physics_time_ms": total_physics_time / float(_sample_count),
		"average_draw_calls": total_draw_calls / float(_sample_count),
		"average_objects_drawn": total_objects_drawn / float(_sample_count),
	}


func _percentile(sorted_values: Array[float], percentile: float) -> float:
	if sorted_values.is_empty():
		return 0.0
	var index := clampi(
		int(ceil(percentile * float(sorted_values.size()))) - 1,
		0,
		sorted_values.size() - 1
	)
	return sorted_values[index]


func _allocate_buffers() -> void:
	_time_sec_samples.resize(MAX_SAMPLES)
	_smoothed_fps_samples.resize(MAX_SAMPLES)
	_frame_time_ms_samples.resize(MAX_SAMPLES)
	_process_time_ms_samples.resize(MAX_SAMPLES)
	_physics_time_ms_samples.resize(MAX_SAMPLES)
	_draw_call_samples.resize(MAX_SAMPLES)
	_objects_drawn_samples.resize(MAX_SAMPLES)
	_object_count_samples.resize(MAX_SAMPLES)
	_static_memory_samples.resize(MAX_SAMPLES)


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

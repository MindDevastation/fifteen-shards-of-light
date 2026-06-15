extends Node
class_name PerformanceProbe

## Dev-only benchmark helper. Disabled until start_capture() is called.
## Attach manually to a test scene or instantiate from the remote console; do not autoload.

@export var warmup_seconds: float = 5.0
@export var capture_seconds: float = 30.0
@export var output_directory: String = "user://performance"
@export var scene_label: String = ""
@export var test_phase: String = "manual"
@export var auto_start: bool = false

var _capturing := false
var _warmup_remaining := 0.0
var _capture_remaining := 0.0
var _samples: Array[String] = []
var _sample_index := 0
var _node_count := 0
var _node_count_accumulator := 0.0


func _ready() -> void:
	set_process(false)
	if auto_start:
		start_capture(scene_label, test_phase)


func start_capture(label: String = "", phase: String = "manual") -> void:
	scene_label = label if not label.is_empty() else _get_scene_label()
	test_phase = phase
	_warmup_remaining = maxf(0.0, warmup_seconds)
	_capture_remaining = maxf(0.0, capture_seconds)
	_samples.clear()
	_sample_index = 0
	_node_count = _count_nodes(get_tree().current_scene)
	_node_count_accumulator = 0.0
	_capturing = true
	set_process(true)


func stop_capture() -> String:
	if not _capturing and _samples.is_empty():
		return ""
	_capturing = false
	set_process(false)
	return _write_csv()


func _process(delta: float) -> void:
	if not _capturing:
		return

	if _warmup_remaining > 0.0:
		_warmup_remaining = maxf(0.0, _warmup_remaining - delta)
		return

	_capture_remaining -= delta
	_node_count_accumulator += delta
	if _node_count_accumulator >= 1.0:
		_node_count_accumulator = 0.0
		_node_count = _count_nodes(get_tree().current_scene)

	_sample_index += 1
	_samples.append(_build_sample_row(delta))

	if _capture_remaining <= 0.0:
		stop_capture()


func _build_sample_row(delta: float) -> String:
	var frame_time_ms := delta * 1000.0
	var fps := Engine.get_frames_per_second()
	var process_time_ms := Performance.get_monitor(Performance.TIME_PROCESS) * 1000.0
	var physics_time_ms := Performance.get_monitor(Performance.TIME_PHYSICS_PROCESS) * 1000.0
	var draw_calls := Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME)
	var object_count := Performance.get_monitor(Performance.OBJECT_COUNT)
	var static_memory := Performance.get_monitor(Performance.MEMORY_STATIC)
	return "%d,%.6f,%d,%.4f,%.4f,%.4f,%d,%d,%d,%d" % [
		_sample_index,
		Time.get_ticks_msec() / 1000.0,
		fps,
		frame_time_ms,
		process_time_ms,
		physics_time_ms,
		int(draw_calls),
		int(object_count),
		_node_count,
		int(static_memory),
	]


func _write_csv() -> String:
	DirAccess.make_dir_recursive_absolute(output_directory)
	var timestamp := Time.get_datetime_string_from_system(false, true).replace(":", "").replace("-", "")
	var safe_scene := _sanitize_filename(scene_label)
	var safe_phase := _sanitize_filename(test_phase)
	var path := "%s/perf_%s_%s_%s.csv" % [output_directory, safe_scene, safe_phase, timestamp]
	var file := FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		push_error("PerformanceProbe could not write %s" % path)
		return ""
	file.store_line("sample,time_sec,fps,frame_time_ms,process_time_ms,physics_time_ms,draw_calls,object_count,node_count,static_memory_bytes")
	for row in _samples:
		file.store_line(row)
	file.close()
	print("PerformanceProbe wrote ", path)
	return path


func _count_nodes(root: Node) -> int:
	if root == null:
		return 0
	var total := 1
	for child in root.get_children():
		total += _count_nodes(child)
	return total


func _get_scene_label() -> String:
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

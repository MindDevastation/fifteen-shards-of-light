extends Node
class_name PerformanceProbe

## Dev-only benchmark helper. Disabled until start_capture() is called.
## Start through DevLevelMenu with F8 or call start_capture(label, phase) manually.
## The probe is not an autoload; capture-time work stores numeric samples and defers CSV formatting.

@export var warmup_seconds: float = 5.0
@export var capture_seconds: float = 30.0
@export var output_directory: String = "user://performance"
@export var scene_label: String = ""
@export var test_phase: String = "manual"
@export var auto_start: bool = false
@export var count_nodes_once_per_second: bool = true
@export var collect_diagnostic_counts: bool = true

const FIREFLY_CLUSTER_SCRIPT := preload("res://scripts/vfx/firefly_cluster_3d.gd")

var _capturing := false
var _warmup_remaining := 0.0
var _capture_remaining := 0.0
var _sample_index := 0
var _node_count := 0
var _visible_mesh_count := 0
var _visible_light_count := 0
var _shadow_enabled_light_count := 0
var _transparent_material_count := 0
var _firefly_cluster_count := 0
var _firefly_mesh_node_count := 0
var _soul_orb_petal_node_count := 0
var _diagnostic_count_accumulator := 0.0
var _last_output_path := ""

var _time_sec_samples := PackedFloat64Array()
var _smoothed_fps_samples := PackedFloat64Array()
var _frame_time_ms_samples := PackedFloat64Array()
var _process_time_ms_samples := PackedFloat64Array()
var _physics_time_ms_samples := PackedFloat64Array()
var _draw_call_samples := PackedInt64Array()
var _objects_drawn_samples := PackedInt64Array()
var _object_count_samples := PackedInt64Array()
var _static_memory_samples := PackedInt64Array()
var _node_count_samples := PackedInt64Array()
var _visible_mesh_samples := PackedInt64Array()
var _visible_light_samples := PackedInt64Array()
var _shadow_light_samples := PackedInt64Array()
var _transparent_material_samples := PackedInt64Array()
var _firefly_cluster_samples := PackedInt64Array()
var _firefly_mesh_samples := PackedInt64Array()
var _soul_orb_petal_samples := PackedInt64Array()


func _ready() -> void:
	set_process(false)
	if auto_start:
		start_capture(scene_label, test_phase)


func start_capture(label: String = "", phase: String = "manual") -> void:
	if _capturing:
		stop_capture()
	scene_label = label if not label.is_empty() else _get_scene_label()
	test_phase = phase
	_warmup_remaining = maxf(0.0, warmup_seconds)
	_capture_remaining = maxf(0.0, capture_seconds)
	_sample_index = 0
	_diagnostic_count_accumulator = 0.0
	_last_output_path = ""
	_clear_samples()
	_refresh_diagnostic_counts()
	_capturing = true
	set_process(true)
	print("PerformanceProbe warm-up started for %s / %s" % [scene_label, test_phase])


func stop_capture() -> String:
	if not _capturing and _frame_time_ms_samples.is_empty():
		return ""
	_capturing = false
	set_process(false)
	_last_output_path = _write_csv()
	return _last_output_path


func get_last_output_path() -> String:
	return _last_output_path


func _process(delta: float) -> void:
	if not _capturing:
		return

	if _warmup_remaining > 0.0:
		_warmup_remaining = maxf(0.0, _warmup_remaining - delta)
		return

	_capture_remaining -= delta
	_diagnostic_count_accumulator += delta
	if _diagnostic_count_accumulator >= 1.0:
		_diagnostic_count_accumulator = 0.0
		_refresh_diagnostic_counts()

	_append_numeric_sample(delta)

	if _capture_remaining <= 0.0:
		stop_capture()


func _append_numeric_sample(delta: float) -> void:
	_sample_index += 1
	_time_sec_samples.append(Time.get_ticks_msec() / 1000.0)
	_smoothed_fps_samples.append(float(Engine.get_frames_per_second()))
	_frame_time_ms_samples.append(delta * 1000.0)
	_process_time_ms_samples.append(Performance.get_monitor(Performance.TIME_PROCESS) * 1000.0)
	_physics_time_ms_samples.append(Performance.get_monitor(Performance.TIME_PHYSICS_PROCESS) * 1000.0)
	_draw_call_samples.append(int(Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME)))
	_objects_drawn_samples.append(int(Performance.get_monitor(Performance.RENDER_TOTAL_OBJECTS_IN_FRAME)))
	_object_count_samples.append(int(Performance.get_monitor(Performance.OBJECT_COUNT)))
	_static_memory_samples.append(int(Performance.get_monitor(Performance.MEMORY_STATIC)))
	_node_count_samples.append(_node_count)
	_visible_mesh_samples.append(_visible_mesh_count)
	_visible_light_samples.append(_visible_light_count)
	_shadow_light_samples.append(_shadow_enabled_light_count)
	_transparent_material_samples.append(_transparent_material_count)
	_firefly_cluster_samples.append(_firefly_cluster_count)
	_firefly_mesh_samples.append(_firefly_mesh_node_count)
	_soul_orb_petal_samples.append(_soul_orb_petal_node_count)


func _clear_samples() -> void:
	_time_sec_samples.clear()
	_smoothed_fps_samples.clear()
	_frame_time_ms_samples.clear()
	_process_time_ms_samples.clear()
	_physics_time_ms_samples.clear()
	_draw_call_samples.clear()
	_objects_drawn_samples.clear()
	_object_count_samples.clear()
	_static_memory_samples.clear()
	_node_count_samples.clear()
	_visible_mesh_samples.clear()
	_visible_light_samples.clear()
	_shadow_light_samples.clear()
	_transparent_material_samples.clear()
	_firefly_cluster_samples.clear()
	_firefly_mesh_samples.clear()
	_soul_orb_petal_samples.clear()


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

	var summary := _build_summary()
	file.store_line("# PerformanceProbe summary")
	for key in summary.keys():
		file.store_line("# %s,%s" % [key, summary[key]])
	file.store_line("sample,time_sec,smoothed_fps,frame_time_ms,process_time_ms,physics_time_ms,draw_calls,objects_drawn,object_count,node_count,static_memory_bytes,visible_meshes,visible_lights,shadow_enabled_lights,transparent_materials,firefly_clusters,firefly_mesh_nodes,soul_orb_petal_nodes")
	for i in range(_frame_time_ms_samples.size()):
		file.store_line("%d,%.6f,%.3f,%.4f,%.4f,%.4f,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d" % [
			i + 1,
			_time_sec_samples[i],
			_smoothed_fps_samples[i],
			_frame_time_ms_samples[i],
			_process_time_ms_samples[i],
			_physics_time_ms_samples[i],
			_draw_call_samples[i],
			_objects_drawn_samples[i],
			_object_count_samples[i],
			_node_count_samples[i],
			_static_memory_samples[i],
			_visible_mesh_samples[i],
			_visible_light_samples[i],
			_shadow_light_samples[i],
			_transparent_material_samples[i],
			_firefly_cluster_samples[i],
			_firefly_mesh_samples[i],
			_soul_orb_petal_samples[i],
		])
	file.close()
	print("PerformanceProbe wrote ", path)
	_print_summary(summary)
	return path


func _build_summary() -> Dictionary:
	var sample_count := _frame_time_ms_samples.size()
	var summary := {
		"scene": scene_label,
		"phase": test_phase,
		"sample_count": sample_count,
		"one_percent_low_method": "1000 divided by the average of the slowest ceil(sample_count*0.01) frame times; frame time source is delta*1000",
	}
	if sample_count <= 0:
		return summary

	var sorted_frame_times := Array(_frame_time_ms_samples)
	sorted_frame_times.sort()
	var total_frame_time := _sum_float_samples(_frame_time_ms_samples)
	var average_frame_time := total_frame_time / float(sample_count)
	var worst_count := maxi(1, int(ceil(float(sample_count) * 0.01)))
	var worst_total := 0.0
	for i in range(sample_count - worst_count, sample_count):
		worst_total += float(sorted_frame_times[i])
	var worst_average_frame_time := worst_total / float(worst_count)

	summary["average_fps_from_frame_times"] = 1000.0 / maxf(average_frame_time, 0.001)
	summary["median_frame_time_ms"] = _percentile_sorted(sorted_frame_times, 0.50)
	summary["p95_frame_time_ms"] = _percentile_sorted(sorted_frame_times, 0.95)
	summary["p99_frame_time_ms"] = _percentile_sorted(sorted_frame_times, 0.99)
	summary["one_percent_low_fps"] = 1000.0 / maxf(worst_average_frame_time, 0.001)
	summary["minimum_fps"] = 1000.0 / maxf(float(sorted_frame_times[sample_count - 1]), 0.001)
	summary["maximum_frame_time_ms"] = float(sorted_frame_times[sample_count - 1])
	summary["average_process_time_ms"] = _sum_float_samples(_process_time_ms_samples) / float(sample_count)
	summary["average_physics_time_ms"] = _sum_float_samples(_physics_time_ms_samples) / float(sample_count)
	summary["average_draw_calls"] = _sum_int_samples(_draw_call_samples) / float(sample_count)
	summary["average_objects_drawn"] = _sum_int_samples(_objects_drawn_samples) / float(sample_count)
	summary["max_visible_meshes"] = _max_int_samples(_visible_mesh_samples)
	summary["max_visible_lights"] = _max_int_samples(_visible_light_samples)
	summary["max_shadow_enabled_lights"] = _max_int_samples(_shadow_light_samples)
	summary["max_transparent_materials"] = _max_int_samples(_transparent_material_samples)
	summary["max_firefly_clusters"] = _max_int_samples(_firefly_cluster_samples)
	summary["max_firefly_mesh_nodes"] = _max_int_samples(_firefly_mesh_samples)
	summary["max_soul_orb_petal_nodes"] = _max_int_samples(_soul_orb_petal_samples)
	return summary


func _print_summary(summary: Dictionary) -> void:
	print("PerformanceProbe summary:")
	for key in summary.keys():
		print("  %s: %s" % [key, summary[key]])


func _percentile_sorted(sorted_values: Array, percentile: float) -> float:
	if sorted_values.is_empty():
		return 0.0
	var index := clampi(int(ceil(percentile * float(sorted_values.size()))) - 1, 0, sorted_values.size() - 1)
	return float(sorted_values[index])


func _sum_float_samples(values: PackedFloat64Array) -> float:
	var total := 0.0
	for value in values:
		total += value
	return total


func _sum_int_samples(values: PackedInt64Array) -> float:
	var total := 0.0
	for value in values:
		total += float(value)
	return total


func _max_int_samples(values: PackedInt64Array) -> int:
	var maximum := 0
	for value in values:
		maximum = maxi(maximum, int(value))
	return maximum


func _refresh_diagnostic_counts() -> void:
	_node_count = 0
	_visible_mesh_count = 0
	_visible_light_count = 0
	_shadow_enabled_light_count = 0
	_transparent_material_count = 0
	_firefly_cluster_count = 0
	_firefly_mesh_node_count = 0
	_soul_orb_petal_node_count = 0
	if not count_nodes_once_per_second and not collect_diagnostic_counts:
		return
	_count_scene_diagnostics(get_tree().current_scene, false)


func _count_scene_diagnostics(root: Node, inside_firefly_cluster: bool) -> void:
	if root == null:
		return
	if count_nodes_once_per_second:
		_node_count += 1

	var firefly_cluster: bool = inside_firefly_cluster or root.get_script() == FIREFLY_CLUSTER_SCRIPT
	if collect_diagnostic_counts:
		if root.get_script() == FIREFLY_CLUSTER_SCRIPT:
			_firefly_cluster_count += 1
		if root is MeshInstance3D and (root as MeshInstance3D).is_visible_in_tree():
			_visible_mesh_count += 1
			if firefly_cluster:
				_firefly_mesh_node_count += 1
			if _mesh_instance_uses_transparency(root as MeshInstance3D):
				_transparent_material_count += 1
			if root.name.begins_with("Petal") or root.name.contains("Petal"):
				_soul_orb_petal_node_count += 1
		elif root is Light3D and (root as Light3D).is_visible_in_tree():
			_visible_light_count += 1
			if (root as Light3D).shadow_enabled:
				_shadow_enabled_light_count += 1

	for child in root.get_children():
		_count_scene_diagnostics(child, firefly_cluster)


func _mesh_instance_uses_transparency(mesh_instance: MeshInstance3D) -> bool:
	if _material_uses_transparency(mesh_instance.material_override):
		return true
	var mesh := mesh_instance.mesh
	if mesh == null:
		return false
	for surface_index in range(mesh.get_surface_count()):
		if _material_uses_transparency(mesh.surface_get_material(surface_index)):
			return true
	return false


func _material_uses_transparency(material: Material) -> bool:
	if material == null:
		return false
	if material is BaseMaterial3D:
		var base := material as BaseMaterial3D
		return base.transparency != BaseMaterial3D.TRANSPARENCY_DISABLED or base.albedo_color.a < 0.999
	return false


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

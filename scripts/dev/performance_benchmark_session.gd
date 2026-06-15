extends Node
class_name PerformanceBenchmarkSession

## Persistent dev-only benchmark session created by PerformanceBenchmarkRunner.
## It survives scene changes and starts the lightweight probe with F4.
## Shift+F4 starts the optional GPU/render timing diagnostic.

const CAPTURE_KEY := KEY_F4
const PROBE_SCRIPT := preload("res://scripts/dev/lightweight_performance_probe.gd")
const GPU_PROBE_SCRIPT := preload("res://scripts/dev/gpu_render_timing_probe.gd")

var _probe = null
var _gpu_probe = null


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	_probe = PROBE_SCRIPT.new()
	_probe.name = "LightweightPerformanceProbe"
	add_child(_probe)
	_gpu_probe = GPU_PROBE_SCRIPT.new()
	_gpu_probe.name = "GpuRenderTimingProbe"
	add_child(_gpu_probe)
	print("Performance benchmark session ready. F4 = lightweight capture, Shift+F4 = GPU/render timing capture.")


func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventKey:
		return
	if not event.pressed or event.echo or event.keycode != CAPTURE_KEY:
		return

	if event.shift_pressed:
		_start_gpu_capture()
	else:
		_start_lightweight_capture()

	get_viewport().set_input_as_handled()


func _start_lightweight_capture() -> void:
	if _gpu_probe.is_capture_running():
		print("GPU diagnostic is already running. Wait for completion before starting F4 capture.")
		return
	if _probe.is_capture_running():
		print("Performance benchmark is already running. Wait for completion before pressing F4 again.")
		return
	_probe.start_capture("", "f4_manual")


func _start_gpu_capture() -> void:
	if _probe.is_capture_running():
		print("Lightweight benchmark is already running. Wait for completion before starting Shift+F4 diagnostic.")
		return
	if _gpu_probe.is_capture_running():
		print("GPU diagnostic is already running. Wait for completion before pressing Shift+F4 again.")
		return
	_gpu_probe.start_capture("", "shift_f4_gpu")

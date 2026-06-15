extends Node
class_name PerformanceBenchmarkSession

## Persistent dev-only benchmark session created by PerformanceBenchmarkRunner.
## It survives scene changes and starts the lightweight probe with F4.

const CAPTURE_KEY := KEY_F4
const PROBE_SCRIPT := preload("res://scripts/dev/lightweight_performance_probe.gd")

var _probe: Node = null


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	_probe = PROBE_SCRIPT.new() as Node
	_probe.name = "LightweightPerformanceProbe"
	add_child(_probe)
	print("Performance benchmark session ready. Press F4 to start a 5s warm-up + 30s capture.")


func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventKey:
		return
	if not event.pressed or event.echo or event.keycode != CAPTURE_KEY:
		return

	if _probe.is_capture_running():
		print("Performance benchmark is already running. Wait for completion before pressing F4 again.")
	else:
		_probe.start_capture("", "f4_manual")

	get_viewport().set_input_as_handled()

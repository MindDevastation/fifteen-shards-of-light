extends Control

const SESSION_SCRIPT := preload("res://scripts/dev/performance_benchmark_session.gd")
const TARGETS := [
	{"label": "StartScene", "path": "res://scenes/core/StartScene.tscn"},
	{"label": "Level_01", "path": "res://scenes/levels/Level_01.tscn"},
	{"label": "Level_10", "path": "res://scenes/levels/Level_10.tscn"},
	{"label": "Level_15", "path": "res://scenes/levels/Level_15.tscn"},
	{"label": "FinalScene", "path": "res://scenes/core/FinalScene.tscn"},
]

var _loading := false


func _ready() -> void:
	call_deferred("_ensure_benchmark_session")
	_build_ui()


func _ensure_benchmark_session() -> void:
	var root := get_tree().root
	var existing := root.get_node_or_null("PerformanceBenchmarkSession")
	if existing != null:
		return
	var session := SESSION_SCRIPT.new() as Node
	session.name = "PerformanceBenchmarkSession"
	root.add_child(session)


func _build_ui() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	var background := ColorRect.new()
	background.color = Color(0.035, 0.04, 0.055, 1.0)
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(background)

	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(center)

	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(520.0, 420.0)
	center.add_child(panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 28)
	margin.add_theme_constant_override("margin_right", 28)
	margin.add_theme_constant_override("margin_top", 24)
	margin.add_theme_constant_override("margin_bottom", 24)
	panel.add_child(margin)

	var content := VBoxContainer.new()
	content.add_theme_constant_override("separation", 12)
	margin.add_child(content)

	var title := Label.new()
	title.text = "Performance Benchmark Runner"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 24)
	content.add_child(title)

	var instructions := Label.new()
	instructions.text = "1. Choose a target scene.\n2. Wait until the scene is stable.\n3. Press F4 for 5s warm-up + 30s capture.\n4. Repeat each test three times.\n\nThe runner adds only a sleeping benchmark session; it does not change gameplay, rendering, physics, or VFX."
	instructions.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	instructions.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	content.add_child(instructions)

	for target in TARGETS:
		var button := Button.new()
		button.text = "Open %s" % target.label
		button.custom_minimum_size.y = 42.0
		button.pressed.connect(_on_target_pressed.bind(target.path))
		content.add_child(button)

	var footer := Label.new()
	footer.text = "CSV path is printed in the Godot output console after capture."
	footer.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	footer.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	content.add_child(footer)


func _on_target_pressed(scene_path: String) -> void:
	if _loading:
		return
	if not ResourceLoader.exists(scene_path, "PackedScene"):
		push_error("Benchmark target scene is missing: %s" % scene_path)
		return
	_loading = true
	call_deferred("_change_scene", scene_path)


func _change_scene(scene_path: String) -> void:
	var error := get_tree().change_scene_to_file(scene_path)
	if error != OK:
		_loading = false
		push_error("Could not load benchmark target %s. Error code: %d" % [scene_path, error])

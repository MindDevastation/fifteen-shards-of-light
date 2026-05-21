extends CanvasLayer

const PRIMARY_TOGGLE_KEY := KEY_Q
const LEGACY_TOGGLE_KEY := KEY_F10
const DEV_LEVELS := [
	{"button_name": "Level01Button", "label": "Level 01", "scene_path": "res://scenes/levels/Level_01.tscn"},
	{"button_name": "Level02Button", "label": "Level 02", "scene_path": "res://scenes/levels/Level_02.tscn"},
	{"button_name": "Level03Button", "label": "Level 03", "scene_path": "res://scenes/levels/Level_03.tscn"},
	{"button_name": "Level04Button", "label": "Level 04", "scene_path": "res://scenes/levels/Level_04.tscn"},
	{"button_name": "Level05Button", "label": "Level 05", "scene_path": "res://scenes/levels/Level_05.tscn"},
	{"button_name": "Level06Button", "label": "Level 06", "scene_path": "res://scenes/levels/Level_06.tscn"},
	{"button_name": "Level07Button", "label": "Level 07", "scene_path": "res://scenes/levels/Level_07.tscn"},
	{"button_name": "Level08Button", "label": "Level 08", "scene_path": "res://scenes/levels/Level_08.tscn"},
	{"button_name": "Level09Button", "label": "Level 09", "scene_path": "res://scenes/levels/Level_09.tscn"},
	{"button_name": "Level10Button", "label": "Level 10", "scene_path": "res://scenes/levels/Level_10.tscn"},
	{"button_name": "Level11Button", "label": "Level 11", "scene_path": "res://scenes/levels/Level_11.tscn"},
	{"button_name": "Level12Button", "label": "Level 12", "scene_path": "res://scenes/levels/Level_12.tscn"},
	{"button_name": "Level13Button", "label": "Level 13", "scene_path": "res://scenes/levels/Level_13.tscn"},
	{"button_name": "Level14Button", "label": "Level 14", "scene_path": "res://scenes/levels/Level_14.tscn"},
	{"button_name": "Level15Button", "label": "Level 15", "scene_path": "res://scenes/levels/Level_15.tscn"},
	{"button_name": "FinalButton", "label": "Final", "scene_path": "res://scenes/core/FinalScene.tscn"},
]

@onready var menu_panel: PanelContainer = %MenuPanel

var _is_loading := false


func _ready() -> void:
	menu_panel.visible = false
	_update_mouse_mode()

	for entry in DEV_LEVELS:
		var button := menu_panel.find_child(entry.button_name, true, false) as Button
		if button == null:
			push_error("DevLevelMenu is missing button: %s" % entry.button_name)
			continue

		button.text = entry.label
		button.pressed.connect(_on_level_button_pressed.bind(entry.scene_path))


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == PRIMARY_TOGGLE_KEY or event.keycode == LEGACY_TOGGLE_KEY:
			menu_panel.visible = not menu_panel.visible
			_update_mouse_mode()
			get_viewport().set_input_as_handled()


func _on_level_button_pressed(scene_path: String) -> void:
	if _is_loading:
		return

	if not ResourceLoader.exists(scene_path, "PackedScene"):
		push_error("DevLevelMenu target scene is missing: %s" % scene_path)
		return

	_is_loading = true
	call_deferred("_change_scene_deferred", scene_path)


func _change_scene_deferred(scene_path: String) -> void:
	var error := get_tree().change_scene_to_file(scene_path)
	if error != OK:
		_is_loading = false
		push_error("DevLevelMenu could not load %s. Error code: %d" % [scene_path, error])
		return

	await get_tree().process_frame
	_is_loading = false


func _update_mouse_mode() -> void:
	if menu_panel.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

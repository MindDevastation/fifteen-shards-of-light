extends Control

@onready var status_label: Label = %StatusLabel
@onready var start_button: Button = %StartButton
@onready var quit_button: Button = %QuitButton

const LEVEL_01_PATH := "res://scenes/levels/Level_01.tscn"


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	start_button.pressed.connect(_on_start_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)


func _on_start_button_pressed() -> void:
	status_label.text = "Loading Level_01..."
	var error := get_tree().change_scene_to_file(LEVEL_01_PATH)
	if error != OK:
		status_label.text = "Could not load Level_01."
		push_error("Could not load %s. Error code: %d" % [LEVEL_01_PATH, error])


func _on_quit_button_pressed() -> void:
	get_tree().quit()

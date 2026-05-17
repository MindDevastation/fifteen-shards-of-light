extends Control

@onready var status_label: Label = %StatusLabel
@onready var start_button: Button = %StartButton
@onready var quit_button: Button = %QuitButton

const START_PLACEHOLDER_MESSAGE := "Start pressed: level loading is intentionally disabled for this Stage 1A placeholder."


func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)


func _on_start_button_pressed() -> void:
	print(START_PLACEHOLDER_MESSAGE)
	status_label.text = START_PLACEHOLDER_MESSAGE


func _on_quit_button_pressed() -> void:
	get_tree().quit()

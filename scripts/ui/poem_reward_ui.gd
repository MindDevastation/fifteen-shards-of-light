extends Control

signal closed

const DEFAULT_PLACEHOLDER_TEXT := "Placeholder reward text for this shard.\nFinal poem text will be added in a later slice."

@onready var reward_text_label: Label = %RewardTextLabel
@onready var continue_button: Button = %ContinueButton


func _ready() -> void:
	continue_button.pressed.connect(_on_continue_button_pressed)


func show_placeholder_reward(reward_text: String = DEFAULT_PLACEHOLDER_TEXT) -> void:
	reward_text_label.text = reward_text
	show()
	continue_button.grab_focus()


func _on_continue_button_pressed() -> void:
	hide()
	closed.emit()

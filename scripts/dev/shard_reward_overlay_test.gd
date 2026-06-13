extends Control

@onready var overlay: Control = $ShardRewardOverlay
@onready var test_1_button: Button = $LauncherPanel/MarginContainer/VBoxContainer/Test1Button
@onready var test_2_button: Button = $LauncherPanel/MarginContainer/VBoxContainer/Test2Button


func _ready() -> void:
	test_1_button.pressed.connect(_on_test_1_pressed)
	test_2_button.pressed.connect(_on_test_2_pressed)
	overlay.confirmation_requested.connect(_on_overlay_confirmation_requested)


func _on_test_1_pressed() -> void:
	overlay.play_reward("Test_1", Vector2(420.0, 720.0))


func _on_test_2_pressed() -> void:
	overlay.play_reward("Test_2", Vector2(1500.0, 360.0))


func _on_overlay_confirmation_requested() -> void:
	print("ShardRewardOverlayTest confirmation requested.")

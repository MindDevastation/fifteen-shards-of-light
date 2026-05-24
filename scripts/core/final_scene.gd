extends Node3D

const SPHERE_FLOAT_AMPLITUDE := 0.18
const SPHERE_FLOAT_SPEED := 2.0
const START_SCENE_PATH := "res://scenes/core/StartScene.tscn"

var _is_player_near_pedestal := false
var _is_pedestal_activated := false
var _sphere_base_position := Vector3.ZERO
var _sphere_float_time := 0.0
var _is_returning_to_menu := false

@onready var interaction_zone: Area3D = $PedestalInteractionZone
@onready var interaction_prompt: Label = $UILayer/InteractionPrompt
@onready var ending_overlay: Control = $UILayer/EndingOverlay
@onready var soul_sphere: MeshInstance3D = $SoulSpherePlaceholder
@onready var main_menu_button: Button = $UILayer/EndingOverlay/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonRow/MainMenuButton
@onready var quit_button: Button = $UILayer/EndingOverlay/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonRow/QuitButton


func _ready() -> void:
	add_to_group("player_interactable")
	interaction_prompt.hide()
	ending_overlay.hide()
	soul_sphere.hide()
	_sphere_base_position = soul_sphere.position

	interaction_zone.body_entered.connect(_on_interaction_zone_body_entered)
	interaction_zone.body_exited.connect(_on_interaction_zone_body_exited)
	main_menu_button.pressed.connect(_on_main_menu_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)



func _process(delta: float) -> void:
	if _is_pedestal_activated:
		_sphere_float_time += delta
		soul_sphere.position = _sphere_base_position + Vector3(0.0, sin(_sphere_float_time * SPHERE_FLOAT_SPEED) * SPHERE_FLOAT_AMPLITUDE, 0.0)


func _activate_pedestal() -> void:
	_is_pedestal_activated = true
	interaction_prompt.hide()
	soul_sphere.show()
	ending_overlay.show()


func _on_interaction_zone_body_entered(body: Node3D) -> void:
	if not _is_player_body(body):
		return

	_is_player_near_pedestal = true
	if not _is_pedestal_activated:
		interaction_prompt.show()


func _on_interaction_zone_body_exited(body: Node3D) -> void:
	if not _is_player_body(body):
		return

	_is_player_near_pedestal = false
	interaction_prompt.hide()


func _is_player_body(body: Node3D) -> bool:
	return body is CharacterBody3D and body.name == "Player"


func _on_main_menu_button_pressed() -> void:
	if _is_returning_to_menu:
		return

	_is_returning_to_menu = true
	call_deferred("_change_to_main_menu_deferred")


func _change_to_main_menu_deferred() -> void:
	var error := get_tree().change_scene_to_file(START_SCENE_PATH)
	if error != OK:
		_is_returning_to_menu = false
		push_error("FinalScene could not load %s. Error code: %d" % [START_SCENE_PATH, error])


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func can_player_interact(player: Node3D) -> bool:
	if _is_pedestal_activated:
		return false
	if player == null:
		return false
	return _is_player_near_pedestal and _is_player_body(player)


func interact(player: Node3D) -> void:
	if not can_player_interact(player):
		return
	_activate_pedestal()

extends Area3D

signal collected

var _is_collected := false
var _player_in_range := false

@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var prompt_label: Label3D = $InteractPrompt


func _ready() -> void:
	add_to_group("player_interactable")
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	prompt_label.visible = false


func _process(_delta: float) -> void:
	if _is_collected:
		return



func _on_body_entered(body: Node3D) -> void:
	if _is_collected:
		return

	if not _is_player_body(body):
		return

	_player_in_range = true
	prompt_label.visible = true


func _on_body_exited(body: Node3D) -> void:
	if _is_collected:
		return

	if not _is_player_body(body):
		return

	_player_in_range = false
	prompt_label.visible = false


func _collect() -> void:
	if _is_collected:
		return

	_is_collected = true
	_player_in_range = false
	prompt_label.visible = false
	collected.emit()
	hide()
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	collision_shape.set_deferred("disabled", true)


func _is_player_body(body: Node3D) -> bool:
	return body is CharacterBody3D and body.name == "Player"


func can_player_interact(player: Node3D) -> bool:
	if _is_collected:
		return false
	if player == null:
		return false
	return _player_in_range and _is_player_body(player)


func interact(player: Node3D) -> void:
	if not can_player_interact(player):
		return
	_collect()

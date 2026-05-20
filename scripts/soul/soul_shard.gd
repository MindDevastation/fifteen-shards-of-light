extends Area3D

signal collected

var _is_collected := false
var _player_in_range := false

@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var prompt_label: Label3D = $InteractPrompt


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	prompt_label.visible = false


func _process(_delta: float) -> void:
	if _is_collected:
		return

	if not _player_in_range:
		return

	if not Input.is_action_just_pressed("interact"):
		return

	_collect()


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

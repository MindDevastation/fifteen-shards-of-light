extends Area3D

signal collected

var _is_collected := false

@onready var collision_shape: CollisionShape3D = $CollisionShape3D


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	if _is_collected:
		return

	if not _is_player_body(body):
		return

	_is_collected = true
	collected.emit()
	hide()
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	collision_shape.set_deferred("disabled", true)


func _is_player_body(body: Node3D) -> bool:
	return body is CharacterBody3D and body.name == "Player"

class_name PlayfulSparkPerch
extends Area3D
signal perch_entered(perch_id: StringName)
signal perch_exited(perch_id: StringName)
@export var perch_id: StringName = &""
func _ready() -> void:
	body_entered.connect(func(body: Node) -> void: if body is CharacterBody3D or body.name == "Player": perch_entered.emit(perch_id))
	body_exited.connect(func(body: Node) -> void: if body is CharacterBody3D or body.name == "Player": perch_exited.emit(perch_id))

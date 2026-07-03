class_name BreathingMeadowPetal
extends Area3D
signal petal_entered(petal_id: StringName)
@export var petal_id: StringName = &""
func _ready() -> void:
	body_entered.connect(func(body: Node) -> void: if body is CharacterBody3D or body.name == "Player": petal_entered.emit(petal_id))

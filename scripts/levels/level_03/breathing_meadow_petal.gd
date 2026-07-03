class_name BreathingMeadowPetal
extends Area3D
signal petal_entered(petal_id: StringName)
@export var petal_id: StringName = &""
func _ready() -> void:
	body_entered.connect(func(_body: Node) -> void: petal_entered.emit(petal_id))

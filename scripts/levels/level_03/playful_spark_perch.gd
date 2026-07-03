class_name PlayfulSparkPerch
extends Area3D
signal perch_entered(perch_id: StringName)
@export var perch_id: StringName = &""
func _ready() -> void:
	body_entered.connect(func(_body: Node) -> void: perch_entered.emit(perch_id))

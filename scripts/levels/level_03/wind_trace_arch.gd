class_name WindTraceArch
extends Area3D
signal arch_entered(arch_id: StringName)
@export var arch_id: StringName = &""
func _ready() -> void:
	body_entered.connect(func(_body: Node) -> void: arch_entered.emit(arch_id))

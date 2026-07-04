class_name WindTraceArch
extends Area3D
signal arch_entered(arch_id: StringName, body: Node)
@export var arch_id: StringName = &""
func _ready() -> void: body_entered.connect(_on_body_entered)
func _on_body_entered(body: Node) -> void:
	if body is CharacterBody3D: arch_entered.emit(arch_id, body)

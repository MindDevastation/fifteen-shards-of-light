class_name WindTraceArch
extends Area3D
signal arch_entered(arch_id: StringName)
@export var arch_id: StringName = &""
func _ready() -> void:
	body_entered.connect(_on_body_entered)
func _on_body_entered(body: Node) -> void:
	if body is CharacterBody3D or body.name == "Player":
		arch_entered.emit(arch_id)

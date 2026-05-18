extends Area3D

@export var reveal_nodes: Array[NodePath] = []

var _activated := false


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	if _activated:
		return
	if not (body is CharacterBody3D and body.name == "Player"):
		return

	_activated = true
	for reveal_path in reveal_nodes:
		var target := get_node_or_null(reveal_path)
		if target != null:
			target.visible = true
			_enable_collision_shapes(target)

	set_deferred("monitoring", false)
	set_deferred("monitorable", false)


func _enable_collision_shapes(node: Node) -> void:
	if node is CollisionShape3D:
		node.disabled = false

	for child in node.get_children():
		_enable_collision_shapes(child)

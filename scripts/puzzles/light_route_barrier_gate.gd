extends StaticBody3D
class_name LightRouteBarrierGate

signal opened

@export var dissolve_duration: float = 1.25
var _opened := false
@onready var mesh: MeshInstance3D = $BarrierMesh
@onready var shape: CollisionShape3D = $CollisionShape3D

func open_gate() -> void:
	if _opened:
		return
	_opened = true
	shape.set_deferred("disabled", true)
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(mesh, "transparency", 1.0, dissolve_duration)
	tween.tween_property(mesh, "position:y", mesh.position.y - 0.65, dissolve_duration)
	tween.finished.connect(func(): hide(); opened.emit())

func reset_gate() -> void:
	_opened = false
	show()
	shape.set_deferred("disabled", false)
	mesh.transparency = 0.0
	mesh.position.y = 0.0

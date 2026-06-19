extends StaticBody3D
class_name LightRouteBarrierGate

signal opened

@export var dissolve_duration: float = 1.25
var _opened := false
var _dissolve_tween: Tween
var _initial_mesh_position: Vector3
var _initial_mesh_transparency: float
var _initial_visible: bool
var _initial_shape_disabled: bool
@onready var mesh: MeshInstance3D = $BarrierMesh
@onready var shape: CollisionShape3D = $CollisionShape3D

func _ready() -> void:
	_initial_mesh_position = mesh.position
	_initial_mesh_transparency = mesh.transparency
	_initial_visible = visible
	_initial_shape_disabled = shape.disabled

func open_gate() -> void:
	if _opened:
		return
	_kill_dissolve_tween()
	_opened = true
	shape.set_deferred("disabled", true)
	show()
	_dissolve_tween = create_tween()
	_dissolve_tween.set_parallel(true)
	_dissolve_tween.tween_property(mesh, "transparency", 1.0, dissolve_duration)
	_dissolve_tween.tween_property(mesh, "position:y", mesh.position.y - 0.65, dissolve_duration)
	_dissolve_tween.finished.connect(_on_dissolve_finished)

func reset_gate() -> void:
	_kill_dissolve_tween()
	_opened = false
	mesh.position = _initial_mesh_position
	mesh.transparency = _initial_mesh_transparency
	visible = _initial_visible
	shape.set_deferred("disabled", _initial_shape_disabled)

func _on_dissolve_finished() -> void:
	if not _opened:
		return
	hide()
	opened.emit()
	_dissolve_tween = null

func _kill_dissolve_tween() -> void:
	if _dissolve_tween != null and _dissolve_tween.is_valid():
		_dissolve_tween.kill()
	_dissolve_tween = null

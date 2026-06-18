extends Node3D
class_name LightRouteBeam

@export var beam_color: Color = Color(1.0, 0.72, 0.32, 1.0)
@export var thickness: float = 0.075
@export var arc_height: float = 0.42
@export var segments: int = 18
@export var fade_duration: float = 0.18

var channel := -1
var source_lamp_id: StringName
var target_lamp_id: StringName
var is_initial := false
var _line: MeshInstance3D
var _material: StandardMaterial3D
var _active_tween: Tween

func _ready() -> void:
	_line = MeshInstance3D.new()
	_line.name = "CurvedBeamMesh"
	_line.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	add_child(_line)

func configure_between(start: Node3D, end: Node3D, color: Color) -> void:
	beam_color = color
	if _line == null:
		_ready()
	var start_local := to_local(_anchor_position(start))
	var end_local := to_local(_anchor_position(end))
	var points := _build_curve_points(start_local, end_local)
	var mesh := ImmediateMesh.new()
	mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLES)
	for i in range(points.size() - 1):
		_add_segment(mesh, points, i)
	mesh.surface_end()
	_line.mesh = mesh
	_material = StandardMaterial3D.new()
	_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	_material.cull_mode = BaseMaterial3D.CULL_DISABLED
	_material.albedo_color = Color(color.r, color.g, color.b, 0.0)
	_material.emission_enabled = true
	_material.emission = color
	_material.emission_energy_multiplier = 1.15
	_line.material_override = _material
	set_active(true, true)

func set_metadata(source_id: StringName, target_id: StringName, channel_index: int, initial: bool) -> void:
	source_lamp_id = source_id
	target_lamp_id = target_id
	channel = channel_index
	is_initial = initial

func set_active(active: bool, instant := false) -> void:
	if _material == null:
		return
	if _active_tween != null and _active_tween.is_valid():
		_active_tween.kill()
	var target_alpha := 0.74 if active else 0.0
	if instant:
		_material.albedo_color.a = target_alpha
		visible = active
		return
	visible = true
	_active_tween = create_tween()
	_active_tween.tween_property(_material, "albedo_color:a", target_alpha, fade_duration)
	if not active:
		_active_tween.finished.connect(func(): visible = false)

func _anchor_position(node: Node3D) -> Vector3:
	if node.has_method("get_beam_anchor_position"):
		return node.call("get_beam_anchor_position")
	return node.global_position + Vector3.UP * 0.55

func _build_curve_points(start_local: Vector3, end_local: Vector3) -> Array[Vector3]:
	var result: Array[Vector3] = []
	for i in range(segments + 1):
		var t := float(i) / float(maxi(1, segments))
		result.append(start_local.lerp(end_local, t) + Vector3.UP * sin(t * PI) * arc_height)
	return result

func _add_segment(mesh: ImmediateMesh, points: Array[Vector3], index: int) -> void:
	var a := points[index]
	var b := points[index + 1]
	var tangent := (b - a).normalized()
	var side := tangent.cross(Vector3.UP).normalized()
	if side.length_squared() < 0.001:
		side = Vector3.RIGHT
	var up := side.cross(tangent).normalized()
	var half_width := thickness
	var half_depth := thickness * 0.35
	var a0 := a - side * half_width - up * half_depth
	var a1 := a + side * half_width - up * half_depth
	var a2 := a + side * half_width + up * half_depth
	var a3 := a - side * half_width + up * half_depth
	var b0 := b - side * half_width - up * half_depth
	var b1 := b + side * half_width - up * half_depth
	var b2 := b + side * half_width + up * half_depth
	var b3 := b - side * half_width + up * half_depth
	_add_quad(mesh, a0, a1, b1, b0)
	_add_quad(mesh, a1, a2, b2, b1)
	_add_quad(mesh, a2, a3, b3, b2)
	_add_quad(mesh, a3, a0, b0, b3)

func _add_quad(mesh: ImmediateMesh, a: Vector3, b: Vector3, c: Vector3, d: Vector3) -> void:
	mesh.surface_add_vertex(a)
	mesh.surface_add_vertex(b)
	mesh.surface_add_vertex(c)
	mesh.surface_add_vertex(a)
	mesh.surface_add_vertex(c)
	mesh.surface_add_vertex(d)

extends Node3D
class_name LightRouteBeam

@export var beam_color: Color = Color(1.0, 0.72, 0.32, 1.0)
@export var thickness: float = 0.075
@export var arc_height: float = 0.42
@export var segments: int = 18

var _line: MeshInstance3D

func _ready() -> void:
	_line = MeshInstance3D.new()
	_line.name = "CurvedBeamMesh"
	_line.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	add_child(_line)

func configure_between(start: Node3D, end: Node3D, color: Color) -> void:
	beam_color = color
	if _line == null:
		_ready()
	var start_local := to_local(start.global_position + Vector3.UP * 0.55)
	var end_local := to_local(end.global_position + Vector3.UP * 0.55)
	var mesh := ImmediateMesh.new()
	mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
	for i in range(segments + 1):
		var t := float(i) / float(maxi(1, segments))
		var point := start_local.lerp(end_local, t) + Vector3.UP * sin(t * PI) * arc_height
		var tangent := (end_local - start_local).normalized()
		var side := tangent.cross(Vector3.UP).normalized()
		if side.length_squared() < 0.001:
			side = Vector3.RIGHT
		mesh.surface_add_vertex(point - side * thickness)
		mesh.surface_add_vertex(point + side * thickness)
	mesh.surface_end()
	_line.mesh = mesh
	var mat := StandardMaterial3D.new()
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.albedo_color = Color(color.r, color.g, color.b, 0.74)
	mat.emission_enabled = true
	mat.emission = color
	mat.emission_energy_multiplier = 1.15
	_line.material_override = mat

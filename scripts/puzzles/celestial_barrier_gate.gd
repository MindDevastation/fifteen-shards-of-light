extends StaticBody3D
class_name CelestialBarrierGate

signal dissolved

@export var dissolve_duration: float = 2.2
@export var symbol_rotation_speed: float = -0.28
@export var barrier_size := Vector2(4.8, 3.2)

var _opened := false
var _mesh: MeshInstance3D
var _symbol: MeshInstance3D
var _shape: CollisionShape3D
var _mat: StandardMaterial3D
var _symbol_mat: ShaderMaterial
var _tween: Tween

func _ready() -> void:
	_build_nodes()
	reset_gate()

func _process(delta: float) -> void:
	if _symbol != null:
		_symbol.rotate_object_local(Vector3.FORWARD, symbol_rotation_speed * delta)

func open_gate() -> void:
	if _opened:
		return
	_opened = true
	_shape.disabled = true
	if _tween != null and _tween.is_valid():
		_tween.kill()
	_tween = create_tween()
	_tween.set_parallel(true)
	_tween.tween_property(_mat, "albedo_color:a", 0.0, dissolve_duration)
	_tween.tween_property(_mat, "emission_energy_multiplier", 0.0, dissolve_duration)
	_tween.tween_property(_symbol_mat, "shader_parameter/alpha", 0.0, dissolve_duration)
	_tween.tween_property(_mesh, "position:y", _mesh.position.y - 0.45, dissolve_duration)
	_tween.finished.connect(func(): hide(); dissolved.emit())

func reset_gate() -> void:
	if _opened:
		return
	show()
	_shape.disabled = false
	_mesh.position = Vector3.ZERO
	_mat.albedo_color = Color(0.72, 0.76, 0.84, 0.34)
	_mat.emission_energy_multiplier = 0.55
	_symbol_mat.set_shader_parameter("alpha", 0.70)

func is_collision_enabled() -> bool:
	return _shape != null and not _shape.disabled

func _build_nodes() -> void:
	_mesh = MeshInstance3D.new()
	_mesh.name = "CelestialMistWall"
	var quad := QuadMesh.new()
	quad.size = barrier_size
	_mesh.mesh = quad
	_mesh.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	_mat = StandardMaterial3D.new()
	_mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	_mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	_mat.cull_mode = BaseMaterial3D.CULL_DISABLED
	_mat.albedo_color = Color(0.72, 0.76, 0.84, 0.34)
	_mat.emission_enabled = true
	_mat.emission = Color(0.72, 0.78, 0.90, 1.0)
	_mat.emission_energy_multiplier = 0.55
	_mesh.material_override = _mat
	add_child(_mesh)
	_symbol = MeshInstance3D.new()
	_symbol.name = "ClockwiseSunMoonSigil"
	var symbol_quad := QuadMesh.new()
	symbol_quad.size = barrier_size * 0.72
	_symbol.mesh = symbol_quad
	_symbol.position = Vector3(0.0, 0.0, 0.012)
	_symbol.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	_symbol_mat = ShaderMaterial.new()
	_symbol_mat.shader = _make_symbol_shader()
	_symbol_mat.set_shader_parameter("alpha", 0.70)
	_symbol.material_override = _symbol_mat
	add_child(_symbol)
	_shape = CollisionShape3D.new()
	_shape.name = "CollisionShape3D"
	var box := BoxShape3D.new()
	box.size = Vector3(barrier_size.x, barrier_size.y, 0.36)
	_shape.shape = box
	add_child(_shape)

func _make_symbol_shader() -> Shader:
	var shader := Shader.new()
	shader.code = """
shader_type spatial;
render_mode unshaded, blend_mix, cull_disabled;
uniform float alpha = 0.7;
float ring(vec2 uv, float r, float w) { float d = abs(length(uv) - r); return 1.0 - smoothstep(w, w + 0.012, d); }
void fragment() {
	vec2 uv = (UV - vec2(0.5)) * 2.0;
	float sun = ring(uv + vec2(0.28, 0.0), 0.23, 0.025);
	for (int i = 0; i < 12; i++) {
		float a = float(i) * 0.5235988;
		vec2 p = uv + vec2(0.28, 0.0) - vec2(cos(a), sin(a)) * 0.34;
		sun += 1.0 - smoothstep(0.018, 0.034, length(p));
	}
	float moon_outer = 1.0 - smoothstep(0.25, 0.27, length(uv - vec2(0.22, 0.0)));
	float moon_cut = 1.0 - smoothstep(0.22, 0.25, length(uv - vec2(0.34, 0.04)));
	float moon = max(moon_outer - moon_cut, 0.0);
	float circle = ring(uv, 0.62, 0.015);
	float sigil = clamp(sun + moon + circle, 0.0, 1.0);
	ALBEDO = vec3(0.78, 0.83, 0.92);
	EMISSION = vec3(0.68, 0.76, 0.95) * sigil * 0.9;
	ALPHA = sigil * alpha;
}
"""
	return shader

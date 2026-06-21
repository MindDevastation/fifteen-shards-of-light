extends StaticBody3D
class_name CelestialBarrierGate

signal dissolved

@export var dissolve_duration: float = 2.2
@export var symbol_rotation_speed: float = -0.28
@export var barrier_size := Vector2(4.8, 3.2)
@export_range(0.0, 1.0, 0.01) var closed_wall_alpha: float = 0.52
@export_range(0.0, 4.0, 0.05) var closed_wall_emission: float = 1.05
@export_range(0.0, 1.0, 0.01) var closed_aura_alpha: float = 0.44
@export_range(0.0, 1.0, 0.01) var closed_symbol_alpha: float = 0.95
@export_range(0.0, 4.0, 0.05) var aura_pulse_speed: float = 1.10
@export_range(0.0, 0.5, 0.01) var aura_pulse_strength: float = 0.12

var _opened := false
var _mesh: MeshInstance3D
var _aura: MeshInstance3D
var _symbol: MeshInstance3D
var _shape: CollisionShape3D
var _mat: StandardMaterial3D
var _aura_mat: ShaderMaterial
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
	_tween.tween_property(_aura_mat, "shader_parameter/alpha", 0.0, dissolve_duration)
	_tween.tween_property(_symbol_mat, "shader_parameter/alpha", 0.0, dissolve_duration)
	_tween.tween_property(_mesh, "position:y", _mesh.position.y - 0.45, dissolve_duration)
	_tween.tween_property(_aura, "position:y", _aura.position.y - 0.45, dissolve_duration)
	_tween.tween_property(_symbol, "position:y", _symbol.position.y - 0.45, dissolve_duration)
	_tween.finished.connect(func(): hide(); dissolved.emit())

func reset_gate() -> void:
	if _opened:
		return
	show()
	_shape.disabled = false
	_mesh.position = Vector3.ZERO
	_aura.position = Vector3(0.0, 0.0, -0.012)
	_symbol.position = Vector3(0.0, 0.0, 0.012)
	_mat.albedo_color = Color(0.58, 0.66, 0.82, closed_wall_alpha)
	_mat.emission_energy_multiplier = closed_wall_emission
	_aura_mat.set_shader_parameter("alpha", closed_aura_alpha)
	_aura_mat.set_shader_parameter("pulse_speed", aura_pulse_speed)
	_aura_mat.set_shader_parameter("pulse_strength", aura_pulse_strength)
	_symbol_mat.set_shader_parameter("alpha", closed_symbol_alpha)

func is_collision_enabled() -> bool:
	return _shape != null and not _shape.disabled

func _build_nodes() -> void:
	_aura = MeshInstance3D.new()
	_aura.name = "CelestialBarrierAura"
	var aura_quad := QuadMesh.new()
	aura_quad.size = barrier_size * 1.06
	_aura.mesh = aura_quad
	_aura.position = Vector3(0.0, 0.0, -0.012)
	_aura.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	_aura_mat = ShaderMaterial.new()
	_aura_mat.shader = _make_aura_shader()
	_aura_mat.set_shader_parameter("alpha", closed_aura_alpha)
	_aura_mat.set_shader_parameter("pulse_speed", aura_pulse_speed)
	_aura_mat.set_shader_parameter("pulse_strength", aura_pulse_strength)
	_aura.material_override = _aura_mat
	add_child(_aura)

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
	_mat.albedo_color = Color(0.58, 0.66, 0.82, closed_wall_alpha)
	_mat.emission_enabled = true
	_mat.emission = Color(0.62, 0.74, 0.98, 1.0)
	_mat.emission_energy_multiplier = closed_wall_emission
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
	_symbol_mat.set_shader_parameter("alpha", closed_symbol_alpha)
	_symbol.material_override = _symbol_mat
	add_child(_symbol)
	_shape = CollisionShape3D.new()
	_shape.name = "CollisionShape3D"
	var box := BoxShape3D.new()
	box.size = Vector3(barrier_size.x, barrier_size.y, 0.36)
	_shape.shape = box
	add_child(_shape)

func _make_aura_shader() -> Shader:
	var shader := Shader.new()
	shader.code = """
shader_type spatial;
render_mode unshaded, blend_mix, cull_disabled, depth_draw_never;
uniform float alpha = 0.44;
uniform float pulse_speed = 1.10;
uniform float pulse_strength = 0.12;
uniform vec3 moon_color = vec3(0.58, 0.72, 1.0);
uniform vec3 sun_color = vec3(1.0, 0.58, 0.16);
void fragment() {
	vec2 centered = UV - vec2(0.5);
	vec2 edge_distance = abs(centered) * 2.0;
	float edge = max(edge_distance.x, edge_distance.y);
	float frame = smoothstep(0.58, 0.98, edge) * (1.0 - smoothstep(0.98, 1.04, edge));
	float soft_fill = 0.34 + 0.16 * (1.0 - length(centered));
	float wave_a = 1.0 - smoothstep(0.015, 0.075, abs(fract(UV.y * 3.0 + UV.x * 0.9 - TIME * pulse_speed * 0.18) - 0.5));
	float wave_b = 1.0 - smoothstep(0.012, 0.065, abs(fract(UV.y * 2.2 - UV.x * 1.1 + TIME * pulse_speed * 0.13) - 0.5));
	float pulse = 1.0 + sin(TIME * pulse_speed) * pulse_strength;
	vec3 celestial_color = mix(moon_color, sun_color, smoothstep(0.28, 0.72, UV.x));
	float opacity = (soft_fill + frame * 0.34 + wave_a * 0.10 + wave_b * 0.08) * pulse;
	ALBEDO = celestial_color;
	EMISSION = celestial_color * (0.55 + frame * 0.65 + (wave_a + wave_b) * 0.18);
	ALPHA = clamp(opacity * alpha, 0.0, 0.72);
}
"""
	return shader

func _make_symbol_shader() -> Shader:
	var shader := Shader.new()
	shader.code = """
shader_type spatial;
render_mode unshaded, blend_mix, cull_disabled, depth_draw_never;
uniform float alpha = 0.95;
uniform float emission_boost = 1.15;
float ring(vec2 uv, float r, float w) { float d = abs(length(uv) - r); return 1.0 - smoothstep(w, w + 0.012, d); }
void fragment() {
	vec2 uv = (UV - vec2(0.5)) * 2.0;
	vec3 moon_color = vec3(0.72, 0.84, 1.0);
	vec3 sun_color = vec3(1.0, 0.62, 0.18);
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
	float sun_mask = clamp(sun, 0.0, 1.0);
	float moon_mask = clamp(moon, 0.0, 1.0);
	float circle_mask = clamp(circle, 0.0, 1.0);
	float sigil = clamp(sun_mask + moon_mask + circle_mask, 0.0, 1.0);
	vec3 circle_color = mix(moon_color, sun_color, smoothstep(0.22, 0.78, UV.x));
	vec3 symbol_color = (sun_color * sun_mask) + (moon_color * moon_mask) + (circle_color * circle_mask);
	symbol_color /= max(sigil, 0.001);
	ALBEDO = symbol_color;
	EMISSION = symbol_color * sigil * emission_boost;
	ALPHA = sigil * alpha;
}
"""
	return shader

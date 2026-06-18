extends Node3D
class_name PortalLightSleeve3D

const SLEEVE_COUNT := 6

@export_range(40, 80, 1) var motes_per_sleeve: int = 64
@export_range(1.2, 2.2, 0.05) var turn_count: float = 1.55
@export_range(0.4, 0.8, 0.05) var depth_range: float = 0.62
@export_range(0.04, 0.18, 0.005) var min_mote_size: float = 0.055
@export_range(0.06, 0.24, 0.005) var max_mote_size: float = 0.145
@export_range(0.0, 2.0, 0.01) var flow_speed: float = 0.68
@export var sleeve_color: Color = Color(1.0, 0.74, 0.32, 0.82)
@export var core_emission: Color = Color(1.0, 0.86, 0.48, 1.0)

var _activation := 0.0
var _time := 0.0
var _streams: Array[MultiMeshInstance3D] = []
var _multimeshes: Array[MultiMesh] = []

func _ready() -> void:
	_build_streams()
	set_activation(0.0)

func _process(delta: float) -> void:
	if _activation <= 0.001:
		return
	_time += delta
	_update_streams()

func set_activation(value: float) -> void:
	_activation = clampf(value, 0.0, 1.0)
	visible = _activation > 0.001
	set_process(visible)
	if visible:
		_update_streams()

func _build_streams() -> void:
	if not _streams.is_empty():
		return
	var material := _make_mote_material()
	for sleeve_index in range(SLEEVE_COUNT):
		var mesh := SphereMesh.new()
		mesh.radius = 0.5
		mesh.height = 1.0
		mesh.radial_segments = 8
		mesh.rings = 4
		mesh.material = material
		var multimesh := MultiMesh.new()
		multimesh.transform_format = MultiMesh.TRANSFORM_3D
		multimesh.use_colors = true
		multimesh.instance_count = motes_per_sleeve
		multimesh.mesh = mesh
		var stream := MultiMeshInstance3D.new()
		stream.name = "SleeveMotes%02d" % (sleeve_index + 1)
		stream.multimesh = multimesh
		stream.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		add_child(stream)
		_streams.append(stream)
		_multimeshes.append(multimesh)

func _make_mote_material() -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.blend_mode = BaseMaterial3D.BLEND_MODE_ADD
	material.albedo_color = sleeve_color
	material.emission_enabled = true
	material.emission = core_emission
	material.emission_energy_multiplier = 1.65
	return material

func _update_streams() -> void:
	for sleeve_index in range(_multimeshes.size()):
		_update_stream(sleeve_index, _multimeshes[sleeve_index])

func _update_stream(sleeve_index: int, multimesh: MultiMesh) -> void:
	var phase := float(sleeve_index) / float(SLEEVE_COUNT)
	var base_angle := phase * TAU
	for mote_index in range(motes_per_sleeve):
		var t := float(mote_index) / float(maxi(1, motes_per_sleeve - 1))
		var flow := fmod(t + _time * flow_speed * 0.18 + phase, 1.0)
		var radial := lerpf(1.18, 0.24, flow)
		var angle := base_angle + flow * turn_count * TAU
		var scatter_seed := _hash_01(sleeve_index * 97 + mote_index * 13)
		var side_jitter := (scatter_seed - 0.5) * 0.16
		var height := lerpf(-1.10, 1.08, flow) + sin(flow * TAU * 1.7 + phase * TAU) * 0.16
		var depth := sin(flow * turn_count * TAU + base_angle) * depth_range * 0.5 + side_jitter
		var position := Vector3(cos(angle) * radial, height + 1.55, sin(angle) * radial * 0.42 + depth)
		var size_variation := lerpf(min_mote_size, max_mote_size, _hash_01(mote_index * 29 + sleeve_index * 41))
		var pulse := 0.74 + 0.26 * sin(_time * 3.4 + float(mote_index) * 0.47 + phase * TAU)
		var final_scale := size_variation * pulse * lerpf(0.45, 1.0, _activation)
		var basis := Basis().scaled(Vector3.ONE * final_scale)
		multimesh.set_instance_transform(mote_index, Transform3D(basis, position))
		var alpha := sleeve_color.a * _activation * lerpf(0.58, 1.0, pulse)
		multimesh.set_instance_color(mote_index, Color(sleeve_color.r, sleeve_color.g, sleeve_color.b, alpha))

func _hash_01(value: int) -> float:
	return absf(sin(float(value) * 12.9898) * 43758.5453 - floor(sin(float(value) * 12.9898) * 43758.5453))

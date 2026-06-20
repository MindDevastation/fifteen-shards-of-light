extends Node3D
class_name SunRayParticleStream

@export var particle_count: int = 48
@export var arc_height: float = 0.82
@export var visibility_range: float = 38.0
@export var fade_duration: float = 0.8

var source_id: StringName
var target_id: StringName
var is_initial := false
var _source: Node3D
var _target: Node3D
var _multimesh_instance: MultiMeshInstance3D
var _material: StandardMaterial3D
var _alpha := 1.0
var _age := 0.0
var _fade_tween: Tween

func _ready() -> void:
	_multimesh_instance = MultiMeshInstance3D.new()
	_multimesh_instance.name = "GoldenParticleMultiMesh"
	_multimesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	add_child(_multimesh_instance)
	var mesh := SphereMesh.new()
	mesh.radius = 0.035
	mesh.height = 0.07
	mesh.radial_segments = 8
	mesh.rings = 4
	var multimesh := MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.use_colors = true
	multimesh.mesh = mesh
	multimesh.instance_count = particle_count
	_multimesh_instance.multimesh = multimesh
	_material = StandardMaterial3D.new()
	_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	_material.albedo_color = Color(1.0, 0.58, 0.16, 0.72)
	_material.emission_enabled = true
	_material.emission = Color(1.0, 0.82, 0.34, 1.0)
	_material.emission_energy_multiplier = 0.95
	mesh.material = _material

func configure_between(source: Node3D, target: Node3D, p_source_id: StringName, p_target_id: StringName, initial: bool) -> void:
	_source = source
	_target = target
	source_id = p_source_id
	target_id = p_target_id
	is_initial = initial
	_update_instances(0.0)

func fade_out_and_free(duration := -1.0) -> void:
	if _fade_tween != null and _fade_tween.is_valid():
		_fade_tween.kill()
	_fade_tween = create_tween()
	_fade_tween.tween_property(self, "_alpha", 0.0, fade_duration if duration < 0.0 else duration)
	_fade_tween.finished.connect(queue_free)

func _process(delta: float) -> void:
	_age += delta
	_update_instances(delta)
	_update_distance_visibility()

func _update_instances(_delta: float) -> void:
	if _source == null or _target == null or _multimesh_instance == null or _multimesh_instance.multimesh == null:
		return
	var start := to_local(_anchor_position(_source))
	var finish := to_local(_anchor_position(_target))
	for i in range(particle_count):
		var base_t := float(i) / float(maxi(1, particle_count - 1))
		var flow_t := fposmod(base_t + _age * 0.105, 1.0)
		var point := start.lerp(finish, flow_t)
		point.y += sin(flow_t * PI) * arc_height
		var side_wave := sin(_age * 1.7 + float(i) * 1.91) * 0.045
		point.x += side_wave
		point.z += cos(_age * 1.3 + float(i) * 1.37) * 0.035
		var taper := sin(flow_t * PI)
		var size := lerpf(0.45, 1.25, _hash01(i)) * clampf(taper, 0.18, 1.0)
		var transform := Transform3D(Basis().scaled(Vector3.ONE * size), point)
		_multimesh_instance.multimesh.set_instance_transform(i, transform)
		var sparkle := 0.78 + 0.22 * sin(_age * 3.0 + float(i) * 2.41)
		var color := Color(1.0, 0.58, 0.16, _alpha * taper * 0.72)
		if i % 7 == 0:
			color = Color(1.0, 0.82, 0.34, _alpha * taper * sparkle)
		_multimesh_instance.multimesh.set_instance_color(i, color)

func _update_distance_visibility() -> void:
	var camera := get_viewport().get_camera_3d()
	if camera == null or _source == null:
		return
	var distance := camera.global_position.distance_to(_source.global_position)
	var range_alpha := clampf(1.0 - smoothstep(visibility_range, visibility_range + 14.0, distance), 0.0, 1.0)
	_multimesh_instance.transparency = 1.0 - range_alpha

func _anchor_position(node: Node3D) -> Vector3:
	if node.has_method("get_beam_anchor_position"):
		return node.call("get_beam_anchor_position")
	return node.global_position + Vector3.UP * 1.15

func _hash01(value: int) -> float:
	return fposmod(sin(float(value) * 12.9898) * 43758.5453, 1.0)

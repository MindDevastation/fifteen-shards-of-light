extends Node3D
class_name SunRayLanternNode

signal interaction_requested(node: SunRayLanternNode, player: Node)

enum LanternState { INACTIVE, ACTIVE_ENDPOINT, SELECTED, COMPLETED, RESETTING }

const WORLD_PROMPT_SCENE := preload("res://scenes/ui/WorldInteractionPrompt.tscn")
const GOLDEN_ORANGE := Color(1.0, 0.58, 0.16, 1.0)

@export var lantern_id: StringName
@export var visual_target_path: NodePath
@export var interaction_radius: float = 3.0
@export var beam_anchor_offset := Vector3(0.0, 1.25, 0.0)
@export_range(0.1, 2.0, 0.01) var activated_ring_inner_radius: float = 0.48
@export_range(0.1, 2.0, 0.01) var activated_ring_outer_radius: float = 0.62
@export_range(-1.0, 2.0, 0.01) var activated_ring_height: float = 0.18
@export_range(0.0, 1.0, 0.01) var activated_ring_alpha: float = 0.78
@export_range(0.0, 4.0, 0.05) var activated_ring_emission: float = 1.20
@export_range(0.5, 8.0, 0.05) var selected_beacon_height: float = 4.20
@export_range(0.01, 0.5, 0.01) var selected_beacon_radius: float = 0.10
@export_range(0.0, 1.0, 0.01) var selected_beacon_alpha: float = 0.34
@export_range(0.0, 4.0, 0.05) var selected_beacon_emission: float = 1.30
@export_range(0.0, 4.0, 0.05) var selected_beacon_pulse_speed: float = 1.35
@export_range(0.0, 0.5, 0.01) var selected_beacon_pulse_strength: float = 0.10

var state := LanternState.INACTIVE
var _controller: Node
var _visual_target: Node3D
var _player_in_range := false
var _current_player: Node
var _halo: MeshInstance3D
var _selected_stream: GPUParticles3D
var _activated_ring: MeshInstance3D
var _activated_ring_material: StandardMaterial3D
var _selected_beacon: MeshInstance3D
var _selected_beacon_material: ShaderMaterial
var _area: Area3D
var _shape: CollisionShape3D
var _prompt: CanvasLayer

func _ready() -> void:
	if _visual_target == null and not visual_target_path.is_empty():
		_visual_target = get_node_or_null(visual_target_path) as Node3D
	_sync_to_visual_target()
	_build_runtime_nodes()
	add_to_group("player_interactable")
	_area.body_entered.connect(_on_body_entered)
	_area.body_exited.connect(_on_body_exited)
	_prompt.call("set_target", self)
	_apply_state()

func bind_visual_target(target: Node3D) -> void:
	_visual_target = target
	if is_inside_tree():
		_sync_to_visual_target()

func get_visual_target() -> Node3D:
	return _visual_target

func get_interaction_area() -> Area3D:
	return _area

func get_prompt() -> CanvasLayer:
	return _prompt

func get_selected_particle_stream() -> GPUParticles3D:
	return _selected_stream

func get_activated_ring() -> MeshInstance3D:
	return _activated_ring

func get_selected_beacon() -> MeshInstance3D:
	return _selected_beacon

func _sync_to_visual_target() -> void:
	if _visual_target == null:
		push_error("SunRayLanternNode %s has no visual target." % [lantern_id])
		return
	global_position = _visual_target.global_position

func configure(controller: Node, id: StringName) -> void:
	_controller = controller
	lantern_id = id
	_apply_state()
	refresh_prompt()

func set_lantern_state(next_state: LanternState) -> void:
	state = next_state
	_apply_state()
	refresh_prompt()

func get_beam_anchor_position() -> Vector3:
	if _visual_target != null:
		return _visual_target.global_position + beam_anchor_offset
	return global_position + beam_anchor_offset

func can_player_interact(player: Node) -> bool:
	return _player_in_range and player == _current_player and _controller != null and bool(_controller.call("can_lantern_be_interacted", self))

func interact(player: Node) -> void:
	if can_player_interact(player):
		interaction_requested.emit(self, player)

func refresh_prompt() -> void:
	if _prompt == null:
		return
	var text := "Направить солнечный луч"
	if _controller != null:
		text = String(_controller.call("get_prompt_text_for_lantern", self))
	_prompt.call("set_action_text", text)
	if can_player_interact(_current_player):
		_prompt.call("show_prompt")
	else:
		_prompt.call("hide_prompt")

func play_success_feedback() -> void:
	if _prompt.has_method("play_confirm_and_hide"):
		_prompt.call("play_confirm_and_hide")

func play_invalid_feedback() -> void:
	var tween := create_tween()
	tween.tween_property(_halo, "transparency", 0.15, 0.08)
	tween.tween_callback(_apply_state)

func _build_runtime_nodes() -> void:
	_area = Area3D.new()
	_area.name = "SunRayInteractionArea"
	add_child(_area)
	_shape = CollisionShape3D.new()
	var sphere := SphereShape3D.new()
	sphere.radius = interaction_radius
	_shape.shape = sphere
	_area.add_child(_shape)
	_prompt = WORLD_PROMPT_SCENE.instantiate() as CanvasLayer
	_prompt.name = "SunRayWorldInteractionPrompt"
	add_child(_prompt)
	_halo = MeshInstance3D.new()
	_halo.name = "SunRayGoldenHalo"
	_halo.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	var mesh := SphereMesh.new()
	mesh.radius = 0.34
	mesh.height = 0.68
	mesh.radial_segments = 24
	mesh.rings = 8
	_halo.mesh = mesh
	var mat := StandardMaterial3D.new()
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.albedo_color = Color(1.0, 0.58, 0.16, 0.0)
	mat.emission_enabled = true
	mat.emission = GOLDEN_ORANGE
	mat.emission_energy_multiplier = 0.7
	_halo.material_override = mat
	_halo.position = beam_anchor_offset * 0.72
	add_child(_halo)
	_selected_stream = GPUParticles3D.new()
	_selected_stream.name = "SunRaySelectedVerticalParticles"
	_selected_stream.amount = 24
	_selected_stream.lifetime = 0.85
	_selected_stream.randomness = 0.35
	_selected_stream.explosiveness = 0.0
	_selected_stream.emitting = false
	_selected_stream.position = beam_anchor_offset
	var process := ParticleProcessMaterial.new()
	process.direction = Vector3.UP
	process.spread = 10.0
	process.initial_velocity_min = 0.55
	process.initial_velocity_max = 0.95
	process.gravity = Vector3.ZERO
	process.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_SPHERE
	process.emission_sphere_radius = 0.10
	process.scale_min = 0.45
	process.scale_max = 1.20
	process.color = Color(1.0, 0.72, 0.24, 0.78)
	_selected_stream.process_material = process
	var particle_mesh := SphereMesh.new()
	particle_mesh.radius = 0.025
	particle_mesh.height = 0.05
	particle_mesh.radial_segments = 8
	particle_mesh.rings = 4
	var particle_material := StandardMaterial3D.new()
	particle_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	particle_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	particle_material.albedo_color = Color(1.0, 0.58, 0.16, 0.72)
	particle_material.emission_enabled = true
	particle_material.emission = Color(1.0, 0.82, 0.34, 1.0)
	particle_material.emission_energy_multiplier = 0.85
	particle_mesh.material = particle_material
	_selected_stream.draw_pass_1 = particle_mesh
	add_child(_selected_stream)

	_selected_beacon = MeshInstance3D.new()
	_selected_beacon.name = "SunRaySelectedBeacon"
	_selected_beacon.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	var beacon_height := maxf(selected_beacon_height, 0.10)
	var beacon_radius := maxf(selected_beacon_radius, 0.01)
	var beacon_mesh := CylinderMesh.new()
	beacon_mesh.top_radius = beacon_radius
	beacon_mesh.bottom_radius = beacon_radius
	beacon_mesh.height = beacon_height
	beacon_mesh.radial_segments = 24
	beacon_mesh.rings = 2
	beacon_mesh.cap_top = false
	beacon_mesh.cap_bottom = false
	_selected_beacon.mesh = beacon_mesh
	_selected_beacon.position = beam_anchor_offset + Vector3(0.0, beacon_height * 0.5, 0.0)
	_selected_beacon_material = ShaderMaterial.new()
	_selected_beacon_material.shader = _make_selected_beacon_shader()
	_selected_beacon_material.set_shader_parameter("beacon_color", Color(1.0, 0.64, 0.18, 1.0))
	_selected_beacon_material.set_shader_parameter("alpha", selected_beacon_alpha)
	_selected_beacon_material.set_shader_parameter("emission_boost", selected_beacon_emission)
	_selected_beacon_material.set_shader_parameter("pulse_speed", selected_beacon_pulse_speed)
	_selected_beacon_material.set_shader_parameter("pulse_strength", selected_beacon_pulse_strength)
	_selected_beacon.material_override = _selected_beacon_material
	_selected_beacon.visible = false
	add_child(_selected_beacon)

	_activated_ring = MeshInstance3D.new()
	_activated_ring.name = "SunRayActivatedRing"
	_activated_ring.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	var ring_mesh := TorusMesh.new()
	var ring_inner_radius := activated_ring_inner_radius
	var ring_outer_radius := activated_ring_outer_radius
	if ring_inner_radius >= ring_outer_radius:
		var original_inner_radius := ring_inner_radius
		ring_inner_radius = min(ring_inner_radius, ring_outer_radius)
		ring_outer_radius = max(original_inner_radius, ring_outer_radius)
		if ring_inner_radius == ring_outer_radius:
			ring_outer_radius = ring_inner_radius + 0.01
	ring_mesh.inner_radius = ring_inner_radius
	ring_mesh.outer_radius = ring_outer_radius
	ring_mesh.rings = 48
	ring_mesh.ring_segments = 16
	_activated_ring.mesh = ring_mesh
	_activated_ring.position = Vector3(0.0, activated_ring_height, 0.0)
	_activated_ring_material = StandardMaterial3D.new()
	_activated_ring_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	_activated_ring_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	_activated_ring_material.cull_mode = BaseMaterial3D.CULL_DISABLED
	_activated_ring_material.albedo_color = Color(1.0, 0.58, 0.16, activated_ring_alpha)
	_activated_ring_material.emission_enabled = true
	_activated_ring_material.emission = Color(1.0, 0.82, 0.34, 1.0)
	_activated_ring_material.emission_energy_multiplier = activated_ring_emission
	_activated_ring.material_override = _activated_ring_material
	_activated_ring.visible = false
	add_child(_activated_ring)

func _make_selected_beacon_shader() -> Shader:
	var shader := Shader.new()
	shader.code = """
shader_type spatial;
render_mode unshaded, blend_add, cull_disabled, depth_draw_never;

uniform vec3 beacon_color = vec3(0.70, 0.84, 1.0);
uniform float alpha = 0.34;
uniform float emission_boost = 1.30;
uniform float pulse_speed = 1.35;
uniform float pulse_strength = 0.10;

void fragment() {
	float vertical = clamp(UV.y, 0.0, 1.0);
	float lower_fade = smoothstep(0.0, 0.08, vertical);
	float upper_fade = 1.0 - smoothstep(0.68, 1.0, vertical);
	float flowing_band = 0.86 + 0.14 * sin(vertical * 18.0 - TIME * pulse_speed * 1.4);
	float pulse = 1.0 + sin(TIME * pulse_speed) * pulse_strength;
	float beam_alpha = alpha * lower_fade * upper_fade * flowing_band * pulse;

	ALBEDO = beacon_color;
	EMISSION = beacon_color * emission_boost * (0.85 + 0.15 * flowing_band);
	ALPHA = clamp(beam_alpha, 0.0, 0.58);
}
"""
	return shader

func _apply_state() -> void:
	if _halo == null:
		return
	var alpha := 0.0
	var scale_value := 1.0
	_selected_stream.emitting = false
	_activated_ring.visible = false
	_selected_beacon.visible = false
	match state:
		LanternState.INACTIVE:
			alpha = 0.0
		LanternState.ACTIVE_ENDPOINT:
			alpha = 0.42
			scale_value = 1.08
		LanternState.SELECTED:
			alpha = 0.72
			scale_value = 1.22
			_selected_stream.emitting = true
			_selected_stream.restart()
			_selected_beacon.visible = true
		LanternState.COMPLETED:
			alpha = 0.30
			_activated_ring.visible = true
		LanternState.RESETTING:
			alpha = 0.14
	_halo.visible = alpha > 0.0
	_halo.transparency = 1.0 - alpha
	_halo.scale = Vector3.ONE * scale_value

func _on_body_entered(body: Node) -> void:
	if body.has_method("_try_start_interaction") or body.name == "Player":
		_player_in_range = true
		_current_player = body
		refresh_prompt()

func _on_body_exited(body: Node) -> void:
	if body == _current_player:
		_player_in_range = false
		_current_player = null
		refresh_prompt()

extends Node3D

@export var emission_enabled: bool = true:
	set(value):
		emission_enabled = value
		_apply_enabled_state()

@export_range(0.2, 6.0, 0.1) var cluster_radius: float = 1.2:
	set(value):
		cluster_radius = value
		_rebuild_fireflies()

@export_range(1, 32, 1) var firefly_count: int = 10:
	set(value):
		firefly_count = value
		_rebuild_fireflies()

@export var base_color: Color = Color(1.0, 0.9, 0.72, 0.75):
	set(value):
		base_color = value
		_apply_material_to_fireflies()

@export_range(0.1, 2.0, 0.05) var brightness_multiplier: float = 0.4:
	set(value):
		brightness_multiplier = value
		_apply_material_to_fireflies()

@export_range(0.1, 3.0, 0.1) var height_range: float = 0.8:
	set(value):
		height_range = value
		_rebuild_fireflies()

@export_range(0.05, 2.0, 0.01) var drift_speed: float = 0.22
@export_range(0.0, 1.0, 0.01) var flicker_strength: float = 0.2
@export_range(0.01, 0.2, 0.005) var firefly_size: float = 0.045:
	set(value):
		firefly_size = value
		_apply_material_to_fireflies()

@export var cluster_light_enabled: bool = false:
	set(value):
		cluster_light_enabled = value
		_apply_light_settings()

@export_range(0.0, 0.6, 0.01) var cluster_light_energy: float = 0.08:
	set(value):
		cluster_light_energy = value
		_apply_light_settings()

@onready var _firefly_root: Node3D = $FireflyRoot
@onready var _cluster_light: OmniLight3D = $OptionalClusterLight

var _shared_mesh: SphereMesh
var _shared_material: StandardMaterial3D
var _fireflies: Array[Dictionary] = []

func _ready() -> void:
	_ensure_visual_resources()
	_rebuild_fireflies()
	_apply_enabled_state()
	_apply_light_settings()

func _process(delta: float) -> void:
	if not emission_enabled:
		return

	var time_sec := Time.get_ticks_msec() * 0.001
	for firefly_data in _fireflies:
		var node: MeshInstance3D = firefly_data["node"]
		if node == null:
			continue

		var orbit_speed: float = firefly_data["orbit_speed"]
		var bob_speed: float = firefly_data["bob_speed"]
		var bob_amount: float = firefly_data["bob_amount"]
		var radius: float = firefly_data["radius"]
		var center: Vector3 = firefly_data["center"]
		var orbit_phase: float = firefly_data["orbit_phase"]
		var bob_phase: float = firefly_data["bob_phase"]
		var flicker_phase: float = firefly_data["flicker_phase"]
		var flicker_speed: float = firefly_data["flicker_speed"]
		var size_scale: float = firefly_data["size_scale"]

		var angle := time_sec * orbit_speed + orbit_phase
		var bob := sin(time_sec * bob_speed + bob_phase) * bob_amount

		node.position = center + Vector3(
			cos(angle) * radius,
			bob,
			sin(angle) * radius
		)

		var flicker_wave := 0.5 + 0.5 * sin(time_sec * flicker_speed + flicker_phase)
		var flicker_scale := 1.0 + (flicker_wave - 0.5) * 2.0 * flicker_strength
		node.scale = Vector3.ONE * max(0.01, firefly_size * size_scale * flicker_scale)

func _ensure_visual_resources() -> void:
	if _shared_mesh == null:
		_shared_mesh = SphereMesh.new()
		_shared_mesh.radial_segments = 6
		_shared_mesh.rings = 4
		_shared_mesh.radius = 0.5
		_shared_mesh.height = 1.0

	if _shared_material == null:
		_shared_material = StandardMaterial3D.new()
		_shared_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		_shared_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		_shared_material.flags_transparent = true
		_shared_material.no_depth_test = false
		_shared_material.emission_enabled = true
		_shared_material.albedo_color = base_color

func _rebuild_fireflies() -> void:
	if not is_node_ready():
		return

	_ensure_visual_resources()
	for child in _firefly_root.get_children():
		child.queue_free()

	_fireflies.clear()
	var count := max(1, firefly_count)

	for i in count:
		var firefly := MeshInstance3D.new()
		firefly.name = "Firefly_%02d" % i
		firefly.mesh = _shared_mesh
		firefly.material_override = _shared_material
		_firefly_root.add_child(firefly)

		var radius := randf_range(cluster_radius * 0.2, cluster_radius)
		var center := Vector3(
			randf_range(-cluster_radius * 0.45, cluster_radius * 0.45),
			randf_range(-height_range * 0.5, height_range * 0.5),
			randf_range(-cluster_radius * 0.45, cluster_radius * 0.45)
		)

		_fireflies.append({
			"node": firefly,
			"center": center,
			"radius": radius,
			"orbit_phase": randf_range(0.0, TAU),
			"bob_phase": randf_range(0.0, TAU),
			"flicker_phase": randf_range(0.0, TAU),
			"orbit_speed": drift_speed * randf_range(0.7, 1.25),
			"bob_speed": drift_speed * randf_range(0.9, 1.7),
			"flicker_speed": drift_speed * randf_range(2.0, 3.2),
			"bob_amount": randf_range(0.03, max(0.05, height_range * 0.18)),
			"size_scale": randf_range(0.85, 1.15)
		})

	_apply_material_to_fireflies()
	_apply_enabled_state()

func _apply_enabled_state() -> void:
	if not is_node_ready():
		return
	_firefly_root.visible = emission_enabled
	set_process(emission_enabled)
	_apply_light_settings()

func _apply_material_to_fireflies() -> void:
	if _shared_material == null:
		return

	var color := base_color
	color.a = clamp(base_color.a, 0.05, 1.0)
	var lit_color := Color(
		clamp(base_color.r * brightness_multiplier, 0.0, 1.0),
		clamp(base_color.g * brightness_multiplier, 0.0, 1.0),
		clamp(base_color.b * brightness_multiplier, 0.0, 1.0),
		color.a
	)

	_shared_material.albedo_color = lit_color
	_shared_material.emission = lit_color
	_shared_material.emission_energy_multiplier = 0.8 + brightness_multiplier * 1.8

func _apply_light_settings() -> void:
	if not is_node_ready() or _cluster_light == null:
		return

	_cluster_light.visible = cluster_light_enabled and emission_enabled
	_cluster_light.light_energy = cluster_light_energy
	_cluster_light.light_color = base_color

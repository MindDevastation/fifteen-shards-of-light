extends Node3D

@export var emission_enabled: bool = true:
	set(value):
		emission_enabled = value
		_apply_to_particles()

@export_range(0.2, 6.0, 0.1) var cluster_radius: float = 1.4:
	set(value):
		cluster_radius = value
		_apply_to_particles()

@export_range(1, 128, 1) var particle_amount: int = 18:
	set(value):
		particle_amount = value
		_apply_to_particles()

@export var base_color: Color = Color(1.0, 0.9, 0.72, 0.72):
	set(value):
		base_color = value
		_apply_to_particles()

@export_range(0.1, 3.0, 0.05) var brightness_multiplier: float = 0.65:
	set(value):
		brightness_multiplier = value
		_apply_to_particles()

@export_range(0.1, 4.0, 0.1) var height_range: float = 1.1:
	set(value):
		height_range = value
		_apply_to_particles()

@onready var _particles: GPUParticles3D = $GPUParticles3D

func _ready() -> void:
	_apply_to_particles()

func _apply_to_particles() -> void:
	if not is_node_ready() or _particles == null:
		return

	_particles.emitting = emission_enabled
	_particles.amount = particle_amount

	var process_material: ParticleProcessMaterial = _particles.process_material as ParticleProcessMaterial
	if process_material == null:
		return

	process_material.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_SPHERE
	process_material.emission_sphere_radius = cluster_radius
	process_material.emission_box_extents = Vector3(cluster_radius, height_range * 0.5, cluster_radius)

	process_material.initial_velocity_min = 0.03
	process_material.initial_velocity_max = 0.11
	process_material.gravity = Vector3.ZERO
	process_material.direction = Vector3(0.0, 1.0, 0.0)
	process_material.spread = 180.0
	process_material.orbit_velocity_min = -0.15
	process_material.orbit_velocity_max = 0.15
	process_material.damping_min = 0.15
	process_material.damping_max = 0.25
	process_material.scale_min = 0.02
	process_material.scale_max = 0.05
	process_material.angular_velocity_min = -0.2
	process_material.angular_velocity_max = 0.2

	var final_color := base_color
	final_color.r = clamp(final_color.r * brightness_multiplier, 0.0, 1.0)
	final_color.g = clamp(final_color.g * brightness_multiplier, 0.0, 1.0)
	final_color.b = clamp(final_color.b * brightness_multiplier, 0.0, 1.0)
	process_material.color = final_color

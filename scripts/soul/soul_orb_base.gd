extends Node3D

@export var inner_ring_speed: float = 0.35
@export var outer_ring_speed: float = -0.22
@export var petal_orbit_speed: float = 0.18
@export var core_breathe_amplitude: float = 0.03
@export var core_breathe_speed: float = 1.2
@export var glow_energy_base: float = 0.85
@export var glow_energy_amplitude: float = 0.2
@export var glow_pulse_speed: float = 1.1

@onready var core_root: Node3D = $VisualRoot/CoreRoot
@onready var inner_ring_root: Node3D = $VisualRoot/InnerRingRoot
@onready var outer_ring_root: Node3D = $VisualRoot/OuterRingRoot
@onready var petal_orbit_root: Node3D = $VisualRoot/PetalOrbitRoot
@onready var orb_light: OmniLight3D = $VisualRoot/GlowRoot/OmniLight3D

var _time: float = 0.0
var _core_base_scale: Vector3 = Vector3.ONE


func _ready() -> void:
	_core_base_scale = core_root.scale


func _process(delta: float) -> void:
	_time += delta

	inner_ring_root.rotate_y(inner_ring_speed * delta)
	outer_ring_root.rotate_x(outer_ring_speed * delta)
	outer_ring_root.rotate_z(outer_ring_speed * 0.6 * delta)
	petal_orbit_root.rotate_y(petal_orbit_speed * delta)

	var breathe_phase := sin(_time * core_breathe_speed)
	var breathe_scale := 1.0 + (core_breathe_amplitude * breathe_phase)
	core_root.scale = _core_base_scale * breathe_scale

	var glow_phase := (sin(_time * glow_pulse_speed) + 1.0) * 0.5
	orb_light.light_energy = glow_energy_base + (glow_energy_amplitude * glow_phase)

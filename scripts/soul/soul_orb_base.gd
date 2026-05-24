extends Node3D

@export var inner_ring_speed: float = 0.35
@export var outer_ring_speed: float = -0.22
@export var core_breathe_amplitude: float = 0.03
@export var core_breathe_speed: float = 1.2
@export var glow_energy_base: float = 0.85
@export var glow_energy_amplitude: float = 0.2
@export var glow_pulse_speed: float = 1.1

@export_range(20, 25, 1) var petal_count: int = 20
@export var petal_scale: Vector3 = Vector3(0.25, 0.25, 0.25)
@export var petal_min_radius: float = 0.48
@export var petal_max_radius: float = 0.74
@export var petal_radial_amplitude: float = 0.08
@export var petal_motion_speed: float = 0.9
@export var petal_spin_speed_min: float = 0.35
@export var petal_spin_speed_max: float = 1.4

@onready var core_root: Node3D = $VisualRoot/CoreRoot
@onready var inner_ring_root: Node3D = $VisualRoot/InnerRingRoot
@onready var outer_ring_center_root: Node3D = $VisualRoot/OuterRingCenterRoot
@onready var petal_container: Node3D = $VisualRoot/PetalContainer
@onready var orb_light: OmniLight3D = $VisualRoot/GlowRoot/OmniLight3D

var _time: float = 0.0
var _core_base_scale: Vector3 = Vector3.ONE
var _petal_data: Array[Dictionary] = []
var _petal_roots: Array[Node3D] = []


func _ready() -> void:
	_core_base_scale = core_root.scale
	_build_petal_data()


func _process(delta: float) -> void:
	_time += delta

	inner_ring_root.rotate_y(inner_ring_speed * delta)
	outer_ring_center_root.rotate_x(outer_ring_speed * delta)
	outer_ring_center_root.rotate_z(outer_ring_speed * 0.6 * delta)

	var breathe_phase := sin(_time * core_breathe_speed)
	var breathe_scale := 1.0 + (core_breathe_amplitude * breathe_phase)
	core_root.scale = _core_base_scale * breathe_scale

	var glow_phase := (sin(_time * glow_pulse_speed) + 1.0) * 0.5
	orb_light.light_energy = glow_energy_base + (glow_energy_amplitude * glow_phase)

	_update_petals()


func _build_petal_data() -> void:
	_petal_data.clear()
	_petal_roots.clear()

	var petals: Array[Node] = petal_container.get_children()
	var active_count: int = min(petal_count, petals.size())

	for i in range(petals.size()):
		var node: Node = petals[i]
		if not node is Node3D:
			continue

		var petal_root: Node3D = node as Node3D
		var enabled: bool = i < active_count
		petal_root.visible = enabled
		if not enabled:
			continue

		_petal_roots.append(petal_root)

		var petal_model := petal_root.get_child(0) as Node3D
		petal_model.scale = petal_scale

		var t := float(i) / float(max(active_count, 1))
		var theta := TAU * t
		var phi := acos(clampf(1.0 - 2.0 * t, -1.0, 1.0))
		var direction := Vector3(
			sin(phi) * cos(theta),
			cos(phi),
			sin(phi) * sin(theta)
		).normalized()

		var radius_lerp := _hash_01(i, 19)
		var base_radius := lerpf(petal_min_radius, petal_max_radius, radius_lerp)
		var radial_amp := petal_radial_amplitude * lerpf(0.45, 1.0, _hash_01(i, 43))
		var radial_speed := petal_motion_speed * lerpf(0.65, 1.35, _hash_01(i, 67))
		var orbit_speed := petal_motion_speed * lerpf(0.25, 0.75, _hash_01(i, 83))
		var orbit_axis := Vector3(
			_hash_signed(i, 97),
			_hash_signed(i, 113),
			_hash_signed(i, 131)
		).normalized()
		if orbit_axis.length_squared() < 0.001:
			orbit_axis = Vector3.UP

		var spin_speed := Vector3(
			lerpf(petal_spin_speed_min, petal_spin_speed_max, _hash_01(i, 151)) * _sign_from_hash(i, 163),
			lerpf(petal_spin_speed_min, petal_spin_speed_max, _hash_01(i, 173)) * _sign_from_hash(i, 179),
			lerpf(petal_spin_speed_min, petal_spin_speed_max, _hash_01(i, 191)) * _sign_from_hash(i, 197)
		)

		var base_phase := TAU * _hash_01(i, 211)
		var orbit_phase := TAU * _hash_01(i, 223)

		_petal_data.append({
			"base_direction": direction,
			"base_radius": base_radius,
			"radial_amp": radial_amp,
			"radial_speed": radial_speed,
			"base_phase": base_phase,
			"orbit_axis": orbit_axis,
			"orbit_speed": orbit_speed,
			"orbit_phase": orbit_phase,
			"spin_speed": spin_speed
		})


func _update_petals() -> void:
	for i in _petal_roots.size():
		var petal_root := _petal_roots[i]
		var data := _petal_data[i]

		var radial_phase := _time * data["radial_speed"] + data["base_phase"]
		var radius := data["base_radius"] + sin(radial_phase) * data["radial_amp"]

		var orbit_angle := _time * data["orbit_speed"] + data["orbit_phase"]
		var direction := data["base_direction"].rotated(data["orbit_axis"], orbit_angle).normalized()

		petal_root.position = direction * radius
		petal_root.rotate_x(data["spin_speed"].x * get_process_delta_time())
		petal_root.rotate_y(data["spin_speed"].y * get_process_delta_time())
		petal_root.rotate_z(data["spin_speed"].z * get_process_delta_time())


func _hash_01(index: int, salt: int) -> float:
	var v := int(index * 92821 + salt * 68917 + 1337)
	v = int((v ^ (v >> 13)) * 1274126177)
	v = v ^ (v >> 16)
	var positive := abs(v % 10000)
	return float(positive) / 10000.0


func _hash_signed(index: int, salt: int) -> float:
	return _hash_01(index, salt) * 2.0 - 1.0


func _sign_from_hash(index: int, salt: int) -> float:
	if _hash_01(index, salt) < 0.5:
		return -1.0
	return 1.0

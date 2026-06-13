extends Area3D

signal collected
signal reward_sequence_requested(shard: Node, shard_id: StringName, reward_text: String, world_position: Vector3)

@export var shard_id: StringName = &""
@export_multiline var reward_text: String = ""

@export var hover_amplitude: float = 0.14
@export var hover_speed: float = 0.95
@export var rotation_speed: float = 0.24
@export var glow_energy_base: float = 0.48
@export var glow_energy_amplitude: float = 0.055
@export var glow_pulse_speed: float = 0.72
@export var aura_pulse_amplitude: float = 0.022
@export var core_pulse_amplitude: float = 0.16
@export var orbit_rotation_speed: float = 0.18
@export var charge_duration: float = 0.6
@export var charge_scale_multiplier: float = 1.16
@export var charge_glow_multiplier: float = 2.1
@export var legacy_completion_delay: float = 0.9

const SPIRAL_MOTE_COUNT := 15
const SPIRAL_HEIGHT := 1.2
const SPIRAL_BOTTOM := -0.17
const SPIRAL_CYCLE_SECONDS := 5.8
const SPIRAL_TURNS := 1.32
const SPIRAL_BASE_RADIUS := 0.34
const SPIRAL_ANGULAR_DRIFT := 0.16
const PRIMARY_ARC_CAMERA_BLEND := 0.58
const SECONDARY_ARC_CAMERA_BLEND := 0.42

enum CollectionState {
	IDLE,
	CHARGING,
	BURSTING,
	WAITING_FOR_REWARD_SEQUENCE,
	COLLECTED,
}

var _state := CollectionState.IDLE
var _player_in_range := false
var _idle_time := 0.0
var _visual_base_position := Vector3.ZERO
var _visual_base_scale := Vector3.ONE
var _ground_vfx_base_scale := Vector3.ONE
var _halo_primary_base_scale := Vector3.ONE
var _halo_inner_base_scale := Vector3.ONE
var _core_base_scale := Vector3.ONE
var _idle_phase := 0.0
var _collection_completed := false
var _spiral_motes: Array[MeshInstance3D] = []
var _spiral_materials: Array[StandardMaterial3D] = []
var _spiral_phase_offsets: Array[float] = []
var _spiral_radius_offsets: Array[float] = []
var _spiral_scale_offsets: Array[float] = []
var _spiral_brightness_offsets: Array[float] = []
var _orbit_warm_base_scale := Vector3.ONE
var _orbit_rose_base_scale := Vector3.ONE

@onready var ground_vfx_root: Node3D = $GroundVFXRoot
@onready var visual_root: Node3D = $VisualRoot
@onready var glow_light: OmniLight3D = $VisualRoot/GlowLight
@onready var under_glow_light: OmniLight3D = $GroundVFXRoot/UnderGlowLight
@onready var halo_primary: MeshInstance3D = $VisualRoot/HaloPrimary
@onready var halo_inner: MeshInstance3D = $VisualRoot/HaloInner
@onready var core_glow: MeshInstance3D = $VisualRoot/CoreGlow
@onready var orbit_accents: Node3D = $VisualRoot/OrbitAccents
@onready var orbit_arc_warm: MeshInstance3D = $VisualRoot/OrbitAccents/OrbitArcWarm
@onready var orbit_arc_rose: MeshInstance3D = $VisualRoot/OrbitAccents/OrbitArcRose
@onready var spiral_motes: Node3D = $VisualRoot/SpiralMotes
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var prompt_label: Label3D = $InteractPrompt
@onready var collection_burst: GPUParticles3D = $CollectionBurst


func _ready() -> void:
	add_to_group("player_interactable")
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	prompt_label.visible = false
	collection_burst.emitting = false
	_visual_base_position = visual_root.position
	_visual_base_scale = visual_root.scale
	_ground_vfx_base_scale = ground_vfx_root.scale
	_halo_primary_base_scale = halo_primary.scale
	_halo_inner_base_scale = halo_inner.scale
	_core_base_scale = core_glow.scale
	_orbit_warm_base_scale = orbit_arc_warm.scale
	_orbit_rose_base_scale = orbit_arc_rose.scale
	_idle_phase = _get_idle_phase()
	_setup_spiral_motes()
	glow_light.light_energy = glow_energy_base


func _process(delta: float) -> void:
	if _state != CollectionState.IDLE:
		return

	_update_idle_presentation(delta)


func _on_body_entered(body: Node3D) -> void:
	if _state != CollectionState.IDLE:
		return

	if not _is_player_body(body):
		return

	_player_in_range = true
	prompt_label.visible = true


func _on_body_exited(body: Node3D) -> void:
	if _state != CollectionState.IDLE:
		return

	if not _is_player_body(body):
		return

	_player_in_range = false
	prompt_label.visible = false


func _begin_collection_sequence() -> void:
	if _state != CollectionState.IDLE:
		return

	_state = CollectionState.CHARGING
	_player_in_range = false
	prompt_label.visible = false
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	collision_shape.set_deferred("disabled", true)

	var charge_tween := create_tween()
	charge_tween.set_parallel(true)
	charge_tween.tween_property(visual_root, "scale", _visual_base_scale * charge_scale_multiplier, charge_duration * 0.55).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	charge_tween.tween_property(glow_light, "light_energy", glow_energy_base * charge_glow_multiplier, charge_duration * 0.55).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	charge_tween.chain().tween_property(visual_root, "scale", _visual_base_scale * 0.92, charge_duration * 0.45).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await charge_tween.finished

	if _state != CollectionState.CHARGING:
		return

	_play_world_burst()
	_request_or_complete_collection()


func _play_world_burst() -> void:
	_state = CollectionState.BURSTING
	visual_root.visible = false
	ground_vfx_root.visible = false
	collection_burst.global_position = global_position
	collection_burst.restart()
	collection_burst.emitting = true


func _request_or_complete_collection() -> void:
	if _has_reward_sequence_listener():
		_state = CollectionState.WAITING_FOR_REWARD_SEQUENCE
		reward_sequence_requested.emit(self, shard_id, reward_text, global_position)
		return

	await get_tree().create_timer(legacy_completion_delay).timeout
	complete_collection_sequence()


func _has_reward_sequence_listener() -> bool:
	return get_signal_connection_list(&"reward_sequence_requested").size() > 0


func complete_collection_sequence() -> void:
	if _collection_completed:
		return

	_collection_completed = true
	_state = CollectionState.COLLECTED
	_player_in_range = false
	prompt_label.visible = false
	visual_root.visible = false
	ground_vfx_root.visible = false
	collected.emit()
	hide()
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	collision_shape.set_deferred("disabled", true)


func _update_idle_presentation(delta: float) -> void:
	_idle_time += delta
	var wave_time := _idle_time * hover_speed + _idle_phase
	visual_root.position = _visual_base_position + Vector3.UP * (sin(wave_time) * hover_amplitude)
	visual_root.rotate_y(rotation_speed * delta)

	var glow_wave := sin(_idle_time * glow_pulse_speed + _idle_phase)
	glow_light.light_energy = max(0.0, glow_energy_base + glow_wave * glow_energy_amplitude)
	under_glow_light.light_energy = max(0.0, 0.1 + glow_wave * 0.015)

	var slow_pulse := sin(_idle_time * 0.82 + _idle_phase)
	var core_pulse := sin(_idle_time * 1.35 + _idle_phase * 0.7)
	halo_primary.scale = _halo_primary_base_scale * (1.0 + slow_pulse * aura_pulse_amplitude)
	var heart_halo_pulse := sin(_idle_time * 1.75 + _idle_phase * 0.45)
	halo_inner.scale = _halo_inner_base_scale * (1.0 + heart_halo_pulse * aura_pulse_amplitude * 1.55)
	core_glow.scale = _core_base_scale * (1.0 + core_pulse * core_pulse_amplitude)
	ground_vfx_root.scale = _ground_vfx_base_scale * (1.0 + slow_pulse * 0.025)
	orbit_accents.rotate_y(orbit_rotation_speed * delta)
	orbit_accents.rotation.z = sin(_idle_time * 0.5 + _idle_phase) * 0.055
	orbit_arc_warm.scale = _orbit_warm_base_scale * (1.0 + sin(_idle_time * 0.62 + _idle_phase) * 0.025)
	orbit_arc_rose.scale = _orbit_rose_base_scale * (1.0 + sin(_idle_time * 0.47 + _idle_phase * 1.3) * 0.018)
	_update_orbit_arc_facing()
	_update_spiral_motes()


func _setup_spiral_motes() -> void:
	_spiral_motes.clear()
	_spiral_materials.clear()
	_spiral_phase_offsets.clear()
	_spiral_radius_offsets.clear()
	_spiral_scale_offsets.clear()
	_spiral_brightness_offsets.clear()

	for index in SPIRAL_MOTE_COUNT:
		var mote := spiral_motes.get_child(index) as MeshInstance3D
		if mote == null:
			continue

		var material := mote.mesh.surface_get_material(0).duplicate() as StandardMaterial3D
		mote.material_override = material
		_spiral_motes.append(mote)
		_spiral_materials.append(material)

		var normalized_index := float(index) / float(SPIRAL_MOTE_COUNT)
		_spiral_phase_offsets.append(normalized_index + sin(float(index) * 1.73) * 0.035)
		_spiral_radius_offsets.append(sin(float(index) * 2.41) * 0.045 + cos(float(index) * 0.83) * 0.025)
		_spiral_scale_offsets.append(0.026 + fposmod(float(index) * 0.013, 0.025))
		_spiral_brightness_offsets.append(0.84 + fposmod(float(index) * 0.137, 0.22))


func _update_spiral_motes() -> void:
	for index in _spiral_motes.size():
		var mote := _spiral_motes[index]
		var material := _spiral_materials[index]
		var cycle_progress := fposmod((_idle_time / SPIRAL_CYCLE_SECONDS) + _spiral_phase_offsets[index], 1.0)
		var eased_rise := smoothstep(0.0, 1.0, cycle_progress)
		var organic_wobble := sin(_idle_time * 0.74 + float(index) * 1.91) * 0.018
		var radius := SPIRAL_BASE_RADIUS + _spiral_radius_offsets[index] + organic_wobble
		var angle := cycle_progress * TAU * SPIRAL_TURNS + _idle_phase + float(index) * 0.37 + _idle_time * SPIRAL_ANGULAR_DRIFT
		var height := SPIRAL_BOTTOM + eased_rise * SPIRAL_HEIGHT

		mote.position = Vector3(cos(angle) * radius, height, sin(angle) * radius)
		mote.scale = Vector3.ONE * _spiral_scale_offsets[index] * (0.86 + sin(_idle_time * 1.1 + float(index)) * 0.08)

		var fade_in := smoothstep(0.02, 0.18, cycle_progress)
		var fade_out := 1.0 - smoothstep(0.76, 0.98, cycle_progress)
		var alpha: float = clampf(fade_in * fade_out * _spiral_brightness_offsets[index], 0.0, 0.88)
		material.albedo_color = Color(1.0, 0.86, 0.5, alpha)
		material.emission_energy_multiplier = 0.86 + alpha * 0.68


func _update_orbit_arc_facing() -> void:
	var camera := get_viewport().get_camera_3d()
	if camera == null:
		return

	_blend_arc_toward_camera(orbit_arc_warm, PRIMARY_ARC_CAMERA_BLEND, _idle_time * 0.24)
	_blend_arc_toward_camera(orbit_arc_rose, SECONDARY_ARC_CAMERA_BLEND, -_idle_time * 0.15 + 0.8)


func _blend_arc_toward_camera(arc: MeshInstance3D, blend: float, roll: float) -> void:
	var camera := get_viewport().get_camera_3d()
	var to_camera := arc.global_position.direction_to(camera.global_position)
	var current_forward := -arc.global_transform.basis.z.normalized()
	var target_forward := current_forward.slerp(to_camera, blend).normalized()
	var up_hint := Vector3.UP
	if abs(target_forward.dot(up_hint)) > 0.92:
		up_hint = camera.global_transform.basis.x.normalized()

	var right := up_hint.cross(target_forward).normalized()
	var up := target_forward.cross(right).normalized()
	var faced_basis := Basis(right, up, -target_forward).rotated(target_forward, roll).orthonormalized()
	arc.global_transform.basis = faced_basis.scaled(arc.scale)


func _get_idle_phase() -> float:
	var phase_seed: int = abs(int(hash(str(get_path())))) % 10000
	return (float(phase_seed) / 10000.0) * TAU


func _is_player_body(body: Node3D) -> bool:
	return body is CharacterBody3D and body.name == "Player"


func can_player_interact(player: Node3D) -> bool:
	if _state != CollectionState.IDLE:
		return false
	if player == null:
		return false
	return _player_in_range and _is_player_body(player)


func interact(player: Node3D) -> void:
	if not can_player_interact(player):
		return
	_begin_collection_sequence()

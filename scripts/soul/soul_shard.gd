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
@export var charge_duration: float = 1.2
@export var legacy_completion_delay: float = 0.9
@export_range(0.5, 3.0, 0.05) var interaction_radius: float = 1.30

const SPIRAL_MOTE_COUNT := 15
const SPIRAL_HEIGHT := 1.2
const SPIRAL_BOTTOM := -0.17
const SPIRAL_CYCLE_SECONDS := 5.8
const SPIRAL_TURNS := 1.32
const SPIRAL_BASE_RADIUS := 0.34
const SPIRAL_ANGULAR_DRIFT := 0.16
const CRYSTAL_HALO_CAMERA_OFFSET := 0.045
const CRYSTAL_HALO_BASE_ALPHA := 0.1
const CRYSTAL_HALO_ALPHA_AMPLITUDE := 0.025
const CRYSTAL_HALO_BASE_EMISSION := 0.3
const CRYSTAL_HALO_EMISSION_AMPLITUDE := 0.05
const HEART_HALO_CYCLE_SECONDS := 1.55
const HEART_HALO_CAMERA_OFFSET := 0.03
const HEART_HALO_BASE_ALPHA := 0.14
const HEART_HALO_ALPHA_BOOST := 0.14
const HEART_HALO_BASE_EMISSION := 0.42
const HEART_HALO_EMISSION_BOOST := 0.34
const CHARGE_TERMINAL_HOLD_SECONDS := 0.06
const COLLECTION_BLOOM_DURATION := 0.42
const COLLECTION_INNER_BLOOM_END_PROGRESS := 0.43
const COLLECTION_INNER_BLOOM_START_SCALE := 0.18
const COLLECTION_INNER_BLOOM_PEAK_SCALE := 0.62
const COLLECTION_INNER_BLOOM_START_ALPHA := 0.56
const COLLECTION_INNER_BLOOM_START_EMISSION := 1.25
const COLLECTION_INNER_BLOOM_END_EMISSION := 0.2
const COLLECTION_OUTER_BLOOM_START_SCALE := 0.22
const COLLECTION_OUTER_BLOOM_END_SCALE := 0.92
const COLLECTION_OUTER_BLOOM_START_ALPHA := 0.28
const COLLECTION_OUTER_BLOOM_START_EMISSION := 0.72
const COLLECTION_OUTER_BLOOM_END_EMISSION := 0.12


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
var _spiral_time := 0.0
var _visual_base_position := Vector3.ZERO
var _visual_base_scale := Vector3.ONE
var _ground_vfx_base_scale := Vector3.ONE
var _crystal_halo_base_scale := Vector3.ONE
var _crystal_halo_base_position := Vector3.ZERO
var _crystal_halo_material: StandardMaterial3D
var _heart_pulse_halo_base_scale := Vector3.ONE
var _heart_pulse_halo_base_position := Vector3.ZERO
var _heart_pulse_halo_material: StandardMaterial3D
var _core_base_scale := Vector3.ONE
var _idle_phase := 0.0
var _collection_completed := false
var _spiral_motes: Array[MeshInstance3D] = []
var _spiral_materials: Array[StandardMaterial3D] = []
var _spiral_phase_offsets: Array[float] = []
var _spiral_radius_offsets: Array[float] = []
var _spiral_scale_offsets: Array[float] = []
var _spiral_brightness_offsets: Array[float] = []
var _orbit_arc_base_scales: Array[Vector3] = []
var _orbit_arc_base_positions: Array[Vector3] = []
var _orbit_arc_materials: Array[StandardMaterial3D] = []
var _charge_progress: float = 0.0
var _charge_tween: Tween
var _charge_burst_handed_off := false
var _charge_hover_multiplier := 1.0
var _charge_rotation_multiplier := 1.0
var _charge_spiral_speed_multiplier := 1.0
var _charge_spiral_radius_multiplier := 1.0
var _charge_spiral_vertical_multiplier := 1.0
var _charge_visual_scale_multiplier := 1.0
var _charge_core_scale_multiplier := 1.0
var _charge_crystal_halo_scale_multiplier := 1.0
var _charge_crystal_halo_alpha_multiplier := 1.0
var _charge_crystal_halo_emission_multiplier := 1.0
var _charge_heart_halo_scale_multiplier := 1.0
var _charge_heart_alpha_multiplier := 1.0
var _charge_heart_emission_multiplier := 1.0
var _charge_heart_pulse := 0.0
var _charge_heart_start_scale := Vector3.ONE
var _charge_heart_start_alpha := HEART_HALO_BASE_ALPHA
var _charge_heart_start_emission := HEART_HALO_BASE_EMISSION
var _charge_settle_eased := 1.0
var _charge_core_pulse_multiplier := 1.0
var _charge_light_pulse_multiplier := 1.0
var _charge_light_multiplier := 1.0
var _collection_bloom_tween: Tween
var _collection_bloom_progress := 0.0
var _collection_outer_bloom_material: StandardMaterial3D
var _collection_inner_bloom_material: StandardMaterial3D
var _collection_outer_bloom_base_scale := Vector3.ONE
var _collection_inner_bloom_base_scale := Vector3.ONE


@onready var ground_vfx_root: Node3D = $GroundVFXRoot
@onready var visual_root: Node3D = $VisualRoot
@onready var glow_light: OmniLight3D = $VisualRoot/GlowLight
@onready var under_glow_light: OmniLight3D = $GroundVFXRoot/UnderGlowLight
@onready var crystal_halo: MeshInstance3D = $VisualRoot/CrystalHalo
@onready var heart_pulse_halo: MeshInstance3D = $VisualRoot/HeartPulseHalo
@onready var core_glow: MeshInstance3D = $VisualRoot/CoreGlow
@onready var orbit_accents: Node3D = $VisualRoot/OrbitAccents
@onready var primary_arc: MeshInstance3D = $VisualRoot/OrbitAccents/PrimaryArc
@onready var secondary_arc: MeshInstance3D = $VisualRoot/OrbitAccents/SecondaryArc
@onready var tertiary_arc: MeshInstance3D = $VisualRoot/OrbitAccents/TertiaryArc
@onready var spiral_motes: Node3D = $VisualRoot/SpiralMotes
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var prompt_anchor: Marker3D = $PromptAnchor
@onready var interaction_prompt = $WorldInteractionPrompt
@onready var collection_burst: GPUParticles3D = $CollectionBurst
@onready var collection_petal_burst: GPUParticles3D = $CollectionPetalBurst
@onready var collection_bloom_root: Node3D = $CollectionBloomRoot
@onready var collection_outer_bloom: MeshInstance3D = $CollectionBloomRoot/CollectionOuterBloom
@onready var collection_inner_bloom: MeshInstance3D = $CollectionBloomRoot/CollectionInnerBloom


func _ready() -> void:
	add_to_group("player_interactable")
	_configure_interaction_shape()
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	interaction_prompt.set_target(prompt_anchor)
	interaction_prompt.hide_prompt()
	collection_burst.emitting = false
	collection_burst.one_shot = true
	collection_petal_burst.emitting = false
	collection_petal_burst.one_shot = true
	_visual_base_position = visual_root.position
	_visual_base_scale = visual_root.scale
	_ground_vfx_base_scale = ground_vfx_root.scale
	_crystal_halo_base_scale = crystal_halo.scale
	_crystal_halo_base_position = crystal_halo.position
	_heart_pulse_halo_base_scale = heart_pulse_halo.scale
	_heart_pulse_halo_base_position = heart_pulse_halo.position
	_core_base_scale = core_glow.scale
	_collection_outer_bloom_base_scale = collection_outer_bloom.scale
	_collection_inner_bloom_base_scale = collection_inner_bloom.scale
	_setup_crystal_halo_material()
	_setup_orbit_arc_materials()
	_idle_phase = _get_idle_phase()
	_setup_heart_halo_material()
	_setup_spiral_motes()
	_setup_collection_bloom_materials()
	_reset_collection_burst_visuals()
	glow_light.light_energy = glow_energy_base

func _configure_interaction_shape() -> void:
	if collision_shape == null or collision_shape.shape == null:
		push_warning("SoulShard interaction radius could not be applied because CollisionShape3D has no shape.")
		return
	if not collision_shape.shape is SphereShape3D:
		push_warning("SoulShard interaction radius expects SphereShape3D, found %s." % [collision_shape.shape.get_class()])
		return
	var sphere_shape := (collision_shape.shape as SphereShape3D).duplicate() as SphereShape3D
	sphere_shape.radius = interaction_radius
	collision_shape.shape = sphere_shape

func _process(delta: float) -> void:
	if _state == CollectionState.CHARGING:
		_update_charge_presentation(delta)
		return

	if _state == CollectionState.IDLE:
		_update_idle_presentation(delta)


func _on_body_entered(body: Node3D) -> void:
	if _state != CollectionState.IDLE:
		return

	if not _is_player_body(body):
		return

	_player_in_range = true
	interaction_prompt.show_prompt()


func _on_body_exited(body: Node3D) -> void:
	if _state != CollectionState.IDLE:
		return

	if not _is_player_body(body):
		return

	_player_in_range = false
	interaction_prompt.hide_prompt()


func _begin_collection_sequence() -> void:
	if _state != CollectionState.IDLE:
		return

	_state = CollectionState.CHARGING
	_player_in_range = false
	interaction_prompt.play_confirm_and_hide()
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	collision_shape.set_deferred("disabled", true)

	_start_charge_anticipation()


func _start_charge_anticipation() -> void:
	_kill_charge_tween()
	_charge_burst_handed_off = false
	_capture_charge_heart_start_state()
	_set_charge_progress(0.0)
	_charge_tween = create_tween()
	_charge_tween.tween_method(Callable(self, "_set_charge_progress"), 0.0, 1.0, charge_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	_charge_tween.tween_interval(CHARGE_TERMINAL_HOLD_SECONDS)
	_charge_tween.finished.connect(_on_charge_finished)


func _capture_charge_heart_start_state() -> void:
	_charge_heart_start_scale = heart_pulse_halo.scale
	if _heart_pulse_halo_material == null:
		_charge_heart_start_alpha = HEART_HALO_BASE_ALPHA
		_charge_heart_start_emission = HEART_HALO_BASE_EMISSION
		return

	_charge_heart_start_alpha = _heart_pulse_halo_material.albedo_color.a
	_charge_heart_start_emission = _heart_pulse_halo_material.emission_energy_multiplier


func _kill_charge_tween() -> void:
	if _charge_tween != null and _charge_tween.is_valid():
		_charge_tween.kill()

	_charge_tween = null


func _set_charge_progress(value: float) -> void:
	_charge_progress = clampf(value, 0.0, 1.0)
	_apply_charge_visuals(_charge_progress)


func _apply_charge_visuals(progress: float) -> void:
	var settle_progress := _remap_clamped(progress, 0.0, 0.15)
	var gather_progress := _remap_clamped(progress, 0.15, 0.70)
	var heart_progress := _remap_clamped(progress, 0.70, 0.88)
	var compression_progress := _remap_clamped(progress, 0.88, 1.0)
	var settle_eased := smoothstep(0.0, 1.0, settle_progress)
	var gather_eased := smoothstep(0.0, 1.0, gather_progress)
	var heart_wave := sin(heart_progress * PI)
	heart_wave = smoothstep(0.0, 1.0, heart_wave)
	var compression_eased := smoothstep(0.0, 1.0, compression_progress)

	_charge_settle_eased = settle_eased
	_charge_hover_multiplier = lerpf(1.0, 0.32, settle_eased)
	_charge_rotation_multiplier = lerpf(1.0, 0.75, settle_eased)
	_charge_spiral_speed_multiplier = lerpf(1.0, 2.0, gather_eased)
	_charge_spiral_radius_multiplier = lerpf(1.0, 0.34, gather_eased)
	_charge_spiral_vertical_multiplier = lerpf(1.0, 0.55, gather_eased)
	_charge_visual_scale_multiplier = lerpf(1.0, 1.05, gather_eased)
	_charge_core_scale_multiplier = lerpf(1.0, 1.07, gather_eased)
	_charge_crystal_halo_scale_multiplier = lerpf(1.0, 0.95, gather_eased)
	_charge_crystal_halo_alpha_multiplier = 1.0
	_charge_crystal_halo_emission_multiplier = 1.0
	_charge_heart_halo_scale_multiplier = lerpf(1.0, 1.04, gather_eased)
	_charge_heart_alpha_multiplier = lerpf(1.0, 1.18, gather_eased)
	_charge_heart_emission_multiplier = lerpf(1.0, 1.18, gather_eased)
	_charge_heart_pulse = heart_wave
	_charge_core_pulse_multiplier = 1.0 + heart_wave * 0.18
	_charge_light_pulse_multiplier = 1.0 + heart_wave * 0.1
	_charge_light_multiplier = lerpf(1.0, 1.18, gather_eased)

	_charge_spiral_speed_multiplier = lerpf(_charge_spiral_speed_multiplier, 1.7, compression_eased)
	_charge_spiral_radius_multiplier = lerpf(_charge_spiral_radius_multiplier, 0.18, compression_eased)
	_charge_spiral_vertical_multiplier = lerpf(_charge_spiral_vertical_multiplier, 0.32, compression_eased)
	_charge_visual_scale_multiplier = lerpf(_charge_visual_scale_multiplier, 0.94, compression_eased)
	_charge_core_scale_multiplier = lerpf(_charge_core_scale_multiplier, 1.08, compression_eased)
	_charge_crystal_halo_scale_multiplier = lerpf(_charge_crystal_halo_scale_multiplier, 0.92, compression_eased)
	_charge_crystal_halo_alpha_multiplier = lerpf(1.0, 0.82, compression_eased)
	_charge_crystal_halo_emission_multiplier = lerpf(1.0, 0.82, compression_eased)
	_charge_light_multiplier = lerpf(_charge_light_multiplier, 1.12, compression_eased)


func _on_charge_finished() -> void:
	_charge_tween = null
	if _state != CollectionState.CHARGING:
		return
	if _charge_burst_handed_off:
		return

	_charge_burst_handed_off = true
	_play_world_burst()
	_request_or_complete_collection()


func _remap_clamped(value: float, input_min: float, input_max: float) -> float:
	if is_equal_approx(input_min, input_max):
		return 1.0

	return clampf((value - input_min) / (input_max - input_min), 0.0, 1.0)


func _play_world_burst() -> void:
	_state = CollectionState.BURSTING
	visual_root.visible = false
	ground_vfx_root.visible = false
	_start_collection_burst_visuals()


func _setup_collection_bloom_materials() -> void:
	_collection_outer_bloom_material = collection_outer_bloom.mesh.surface_get_material(0).duplicate() as StandardMaterial3D
	collection_outer_bloom.material_override = _collection_outer_bloom_material
	_collection_inner_bloom_material = collection_inner_bloom.mesh.surface_get_material(0).duplicate() as StandardMaterial3D
	collection_inner_bloom.material_override = _collection_inner_bloom_material


func _start_collection_burst_visuals() -> void:
	_reset_collection_burst_visuals()
	collection_burst.global_position = global_position
	collection_burst.restart()
	collection_burst.emitting = true
	collection_petal_burst.global_position = global_position
	collection_petal_burst.restart()
	collection_petal_burst.emitting = true
	collection_bloom_root.global_position = global_position
	collection_bloom_root.visible = true
	_set_collection_bloom_progress(0.0)
	_collection_bloom_tween = create_tween()
	_collection_bloom_tween.tween_method(Callable(self, "_set_collection_bloom_progress"), 0.0, 1.0, COLLECTION_BLOOM_DURATION).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	_collection_bloom_tween.finished.connect(_finish_collection_bloom)


func _reset_collection_burst_visuals() -> void:
	_kill_collection_bloom_tween()
	_collection_bloom_progress = 0.0
	collection_burst.emitting = false
	collection_petal_burst.emitting = false
	collection_bloom_root.visible = false
	collection_bloom_root.global_position = global_position
	collection_inner_bloom.scale = Vector3.ONE * COLLECTION_INNER_BLOOM_START_SCALE
	collection_outer_bloom.scale = Vector3.ONE * COLLECTION_OUTER_BLOOM_START_SCALE
	_apply_collection_bloom_visuals(0.0)


func _kill_collection_bloom_tween() -> void:
	if _collection_bloom_tween != null and _collection_bloom_tween.is_valid():
		_collection_bloom_tween.kill()

	_collection_bloom_tween = null


func _set_collection_bloom_progress(value: float) -> void:
	_collection_bloom_progress = clampf(value, 0.0, 1.0)
	_apply_collection_bloom_visuals(_collection_bloom_progress)


func _apply_collection_bloom_visuals(progress: float) -> void:
	var inner_progress := _remap_clamped(progress, 0.0, COLLECTION_INNER_BLOOM_END_PROGRESS)
	var outer_progress := clampf(progress, 0.0, 1.0)
	var inner_scale_eased := sin(inner_progress * PI * 0.5)
	var outer_scale_eased := sin(outer_progress * PI * 0.5)
	var inner_fade := 1.0 - smoothstep(0.0, 1.0, inner_progress)
	var outer_fade := 1.0 - smoothstep(0.0, 1.0, outer_progress)

	collection_inner_bloom.scale = Vector3.ONE * lerpf(COLLECTION_INNER_BLOOM_START_SCALE, COLLECTION_INNER_BLOOM_PEAK_SCALE, inner_scale_eased)
	collection_outer_bloom.scale = Vector3.ONE * lerpf(COLLECTION_OUTER_BLOOM_START_SCALE, COLLECTION_OUTER_BLOOM_END_SCALE, outer_scale_eased)

	if _collection_inner_bloom_material != null:
		_collection_inner_bloom_material.albedo_color = Color(1.0, 0.84, 0.58, COLLECTION_INNER_BLOOM_START_ALPHA * inner_fade)
		_collection_inner_bloom_material.emission_energy_multiplier = lerpf(COLLECTION_INNER_BLOOM_END_EMISSION, COLLECTION_INNER_BLOOM_START_EMISSION, inner_fade)
	if _collection_outer_bloom_material != null:
		_collection_outer_bloom_material.albedo_color = Color(1.0, 0.72, 0.42, COLLECTION_OUTER_BLOOM_START_ALPHA * outer_fade)
		_collection_outer_bloom_material.emission_energy_multiplier = lerpf(COLLECTION_OUTER_BLOOM_END_EMISSION, COLLECTION_OUTER_BLOOM_START_EMISSION, outer_fade)


func _finish_collection_bloom() -> void:
	_collection_bloom_tween = null
	_set_collection_bloom_progress(1.0)
	collection_bloom_root.visible = false


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
	interaction_prompt.hide_prompt()
	visual_root.visible = false
	ground_vfx_root.visible = false
	collected.emit()
	hide()
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	collision_shape.set_deferred("disabled", true)


func _update_idle_presentation(delta: float) -> void:
	_idle_time += delta
	_spiral_time += delta
	var wave_time := _idle_time * hover_speed + _idle_phase
	visual_root.position = _visual_base_position + Vector3.UP * (sin(wave_time) * hover_amplitude)
	visual_root.rotate_y(rotation_speed * delta)

	var glow_wave := sin(_idle_time * glow_pulse_speed + _idle_phase)
	glow_light.light_energy = max(0.0, glow_energy_base + glow_wave * glow_energy_amplitude)
	under_glow_light.light_energy = max(0.0, 0.1 + glow_wave * 0.015)

	var slow_pulse := sin(_idle_time * 0.82 + _idle_phase)
	var core_pulse := sin(_idle_time * 1.35 + _idle_phase * 0.7)
	_update_crystal_halo(slow_pulse)
	_update_heart_halo_pulse()
	core_glow.scale = _core_base_scale * (1.0 + core_pulse * core_pulse_amplitude)
	ground_vfx_root.scale = _ground_vfx_base_scale * (1.0 + slow_pulse * 0.025)
	orbit_accents.rotate_y(orbit_rotation_speed * delta)
	orbit_accents.rotation.z = sin(_idle_time * 0.5 + _idle_phase) * 0.055
	_update_orbit_arcs()
	_update_spiral_motes()


func _update_charge_presentation(delta: float) -> void:
	_idle_time += delta
	_spiral_time += delta * _charge_spiral_speed_multiplier
	var wave_time := _idle_time * hover_speed + _idle_phase
	visual_root.position = _visual_base_position + Vector3.UP * (sin(wave_time) * hover_amplitude * _charge_hover_multiplier)
	visual_root.rotate_y(rotation_speed * _charge_rotation_multiplier * delta)
	visual_root.scale = _visual_base_scale * _charge_visual_scale_multiplier

	var glow_wave := sin(_idle_time * glow_pulse_speed + _idle_phase)
	glow_light.light_energy = max(0.0, (glow_energy_base + glow_wave * glow_energy_amplitude) * _charge_light_multiplier * _charge_light_pulse_multiplier)
	under_glow_light.light_energy = max(0.0, (0.1 + glow_wave * 0.015) * _charge_light_multiplier * _charge_light_pulse_multiplier)

	var slow_pulse := sin(_idle_time * 0.82 + _idle_phase)
	var core_pulse := sin(_idle_time * 1.35 + _idle_phase * 0.7)
	_update_crystal_halo(slow_pulse)
	crystal_halo.scale *= _charge_crystal_halo_scale_multiplier
	_apply_charge_crystal_halo_softening()
	_update_charge_heart_halo()
	core_glow.scale = _core_base_scale * (1.0 + core_pulse * core_pulse_amplitude) * _charge_core_scale_multiplier * _charge_core_pulse_multiplier
	ground_vfx_root.scale = _ground_vfx_base_scale * (1.0 + slow_pulse * 0.025)
	orbit_accents.rotate_y(orbit_rotation_speed * _charge_rotation_multiplier * delta)
	orbit_accents.rotation.z = sin(_idle_time * 0.5 + _idle_phase) * 0.055 * _charge_rotation_multiplier
	_update_orbit_arcs()
	_update_spiral_motes()


func _setup_crystal_halo_material() -> void:
	_crystal_halo_material = crystal_halo.mesh.surface_get_material(0).duplicate() as StandardMaterial3D
	crystal_halo.material_override = _crystal_halo_material


func _setup_heart_halo_material() -> void:
	_heart_pulse_halo_material = heart_pulse_halo.mesh.surface_get_material(0).duplicate() as StandardMaterial3D
	heart_pulse_halo.material_override = _heart_pulse_halo_material


func _update_charge_heart_halo() -> void:
	var heart_scale_multiplier := lerpf(_charge_heart_halo_scale_multiplier, 1.12, _charge_heart_pulse)
	var desired_scale := _heart_pulse_halo_base_scale * heart_scale_multiplier
	var alpha_multiplier := _charge_heart_alpha_multiplier * lerpf(1.0, 1.5, _charge_heart_pulse)
	var emission_multiplier := _charge_heart_emission_multiplier * lerpf(1.0, 1.5, _charge_heart_pulse)
	var desired_alpha := clampf(HEART_HALO_BASE_ALPHA * alpha_multiplier, 0.0, 0.36)
	var desired_emission := HEART_HALO_BASE_EMISSION * emission_multiplier

	heart_pulse_halo.scale = _charge_heart_start_scale.lerp(desired_scale, _charge_settle_eased)
	_update_heart_halo_camera_offset()

	if _heart_pulse_halo_material == null:
		return

	var blended_alpha := lerpf(_charge_heart_start_alpha, desired_alpha, _charge_settle_eased)
	var blended_emission := lerpf(_charge_heart_start_emission, desired_emission, _charge_settle_eased)
	_heart_pulse_halo_material.albedo_color = Color(1.0, 0.9, 0.78, blended_alpha)
	_heart_pulse_halo_material.emission_energy_multiplier = blended_emission


func _apply_charge_crystal_halo_softening() -> void:
	if _crystal_halo_material == null:
		return

	var halo_color := _crystal_halo_material.albedo_color
	halo_color.a = clampf(halo_color.a * _charge_crystal_halo_alpha_multiplier, 0.0, 0.13)
	_crystal_halo_material.albedo_color = halo_color
	_crystal_halo_material.emission_energy_multiplier *= _charge_crystal_halo_emission_multiplier



func _update_crystal_halo(slow_pulse: float) -> void:
	crystal_halo.scale = _crystal_halo_base_scale * (1.0 + slow_pulse * aura_pulse_amplitude)
	_update_crystal_halo_camera_offset()

	if _crystal_halo_material == null:
		return

	var halo_alpha: float = CRYSTAL_HALO_BASE_ALPHA + slow_pulse * CRYSTAL_HALO_ALPHA_AMPLITUDE
	_crystal_halo_material.albedo_color = Color(1.0, 0.72, 0.55, clampf(halo_alpha, 0.075, 0.13))
	_crystal_halo_material.emission_energy_multiplier = CRYSTAL_HALO_BASE_EMISSION + slow_pulse * CRYSTAL_HALO_EMISSION_AMPLITUDE


func _update_crystal_halo_camera_offset() -> void:
	var camera := get_viewport().get_camera_3d()
	if camera == null:
		crystal_halo.position = _crystal_halo_base_position
		return

	var base_global_position := visual_root.to_global(_crystal_halo_base_position)
	var to_camera := base_global_position.direction_to(camera.global_position)
	crystal_halo.global_position = base_global_position - to_camera * CRYSTAL_HALO_CAMERA_OFFSET


func _update_heart_halo_pulse() -> void:
	var cycle_position := fposmod((_idle_time + _idle_phase * 0.05) / HEART_HALO_CYCLE_SECONDS, 1.0)
	var primary_pulse := _heartbeat_peak(cycle_position, 0.13, 0.055)
	var secondary_pulse := _heartbeat_peak(cycle_position, 0.33, 0.065) * 0.58
	var pulse: float = clampf(primary_pulse + secondary_pulse, 0.0, 1.0)

	heart_pulse_halo.scale = _heart_pulse_halo_base_scale * (1.0 + pulse * 0.13)
	_update_heart_halo_camera_offset()

	if _heart_pulse_halo_material == null:
		return

	var pulse_alpha := HEART_HALO_BASE_ALPHA + pulse * HEART_HALO_ALPHA_BOOST
	_heart_pulse_halo_material.albedo_color = Color(1.0, 0.9, 0.78, pulse_alpha)
	_heart_pulse_halo_material.emission_energy_multiplier = HEART_HALO_BASE_EMISSION + pulse * HEART_HALO_EMISSION_BOOST


func _heartbeat_peak(cycle_position: float, center: float, width: float) -> float:
	var distance: float = abs(cycle_position - center)
	distance = minf(distance, 1.0 - distance)
	var normalized_distance: float = clampf(distance / width, 0.0, 1.0)
	return 1.0 - smoothstep(0.0, 1.0, normalized_distance)


func _update_heart_halo_camera_offset() -> void:
	var camera := get_viewport().get_camera_3d()
	if camera == null:
		heart_pulse_halo.position = _heart_pulse_halo_base_position
		return

	var base_global_position := visual_root.to_global(_heart_pulse_halo_base_position)
	var to_camera := base_global_position.direction_to(camera.global_position)
	heart_pulse_halo.global_position = base_global_position + to_camera * HEART_HALO_CAMERA_OFFSET


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
		var cycle_progress := fposmod((_spiral_time / SPIRAL_CYCLE_SECONDS) + _spiral_phase_offsets[index], 1.0)
		var eased_rise := smoothstep(0.0, 1.0, cycle_progress)
		var organic_wobble := sin(_idle_time * 0.74 + float(index) * 1.91) * 0.018
		var radius := (SPIRAL_BASE_RADIUS + _spiral_radius_offsets[index] + organic_wobble) * _charge_spiral_radius_multiplier
		var angle := cycle_progress * TAU * SPIRAL_TURNS + _idle_phase + float(index) * 0.37 + _spiral_time * SPIRAL_ANGULAR_DRIFT
		var vertical_height := SPIRAL_HEIGHT * _charge_spiral_vertical_multiplier
		var vertical_offset := (SPIRAL_HEIGHT - vertical_height) * 0.5
		var height := SPIRAL_BOTTOM + vertical_offset + eased_rise * vertical_height

		mote.position = Vector3(cos(angle) * radius, height, sin(angle) * radius)
		mote.scale = Vector3.ONE * _spiral_scale_offsets[index] * (0.86 + sin(_idle_time * 1.1 + float(index)) * 0.08)

		var fade_in := smoothstep(0.02, 0.18, cycle_progress)
		var fade_out := 1.0 - smoothstep(0.76, 0.98, cycle_progress)
		var alpha: float = clampf(fade_in * fade_out * _spiral_brightness_offsets[index], 0.0, 0.88)
		material.albedo_color = Color(1.0, 0.86, 0.5, alpha)
		material.emission_energy_multiplier = 0.86 + alpha * 0.68


func _setup_orbit_arc_materials() -> void:
	_orbit_arc_base_scales = [primary_arc.scale, secondary_arc.scale, tertiary_arc.scale]
	_orbit_arc_base_positions = [primary_arc.position, secondary_arc.position, tertiary_arc.position]
	_orbit_arc_materials.clear()
	for arc in [primary_arc, secondary_arc, tertiary_arc]:
		var material := arc.mesh.surface_get_material(0).duplicate() as StandardMaterial3D
		arc.material_override = material
		_orbit_arc_materials.append(material)


func _update_orbit_arcs() -> void:
	_update_orbit_arc(primary_arc, 0, 0.5, 1.45, 0.65, 1.0, 0.82, 1.62, 0.24, 0.025, _idle_time * 0.22)
	_update_orbit_arc(secondary_arc, 1, 0.42, 1.08, 0.58, 1.25, 0.46, 0.42, -0.18, 0.018, _idle_time * -0.16 + 0.9)
	_update_orbit_arc(tertiary_arc, 2, 0.56, 0.78, 0.66, 1.4, 0.28, 0.28, 0.14, 0.014, _idle_time * 0.11 + 1.8)


func _update_orbit_arc(
	arc: MeshInstance3D,
	index: int,
	fade_in_seconds: float,
	visible_seconds: float,
	fade_out_seconds: float,
	rest_seconds: float,
	peak_alpha: float,
	peak_emission: float,
	motion_speed: float,
	scale_amplitude: float,
	roll: float
) -> void:
	var cycle_duration := fade_in_seconds + visible_seconds + fade_out_seconds + rest_seconds
	var phase_offset := float(index) * 0.37 + _idle_phase * (0.03 + float(index) * 0.01)
	var cycle_time := fposmod(_idle_time + phase_offset, cycle_duration)
	var envelope := 0.0

	if cycle_time < fade_in_seconds:
		envelope = smoothstep(0.0, 1.0, cycle_time / fade_in_seconds)
	elif cycle_time < fade_in_seconds + visible_seconds:
		envelope = 1.0
	elif cycle_time < fade_in_seconds + visible_seconds + fade_out_seconds:
		var fade_out_progress := (cycle_time - fade_in_seconds - visible_seconds) / fade_out_seconds
		envelope = 1.0 - smoothstep(0.0, 1.0, fade_out_progress)

	var gentle_motion := sin(_idle_time * (0.55 + abs(motion_speed)) + float(index) * 1.7)
	arc.position = _orbit_arc_base_positions[index] + Vector3(cos(_idle_time * motion_speed + float(index)) * 0.012, gentle_motion * 0.012, sin(_idle_time * motion_speed + float(index)) * 0.01) * envelope
	arc.scale = _orbit_arc_base_scales[index] * (1.0 + gentle_motion * scale_amplitude * envelope)
	_set_arc_camera_facing(arc, roll + gentle_motion * 0.08 * envelope)

	var material := _orbit_arc_materials[index]
	var arc_color := material.albedo_color
	arc_color.a = peak_alpha * envelope
	material.albedo_color = arc_color
	material.emission_energy_multiplier = peak_emission * envelope


func _set_arc_camera_facing(arc: MeshInstance3D, roll: float) -> void:
	var camera := get_viewport().get_camera_3d()
	if camera == null:
		return

	var to_camera := arc.global_position.direction_to(camera.global_position).normalized()
	var up_hint := camera.global_transform.basis.y.normalized()
	var right := up_hint.cross(to_camera).normalized()
	var up := to_camera.cross(right).normalized()
	arc.global_transform.basis = Basis(right, up, -to_camera).rotated(to_camera, roll).orthonormalized().scaled(arc.scale)

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

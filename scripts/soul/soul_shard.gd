extends Area3D

signal collected

@export var hover_amplitude: float = 0.14
@export var hover_speed: float = 1.1
@export var rotation_speed: float = 0.3
@export var glow_energy_base: float = 0.65
@export var glow_energy_amplitude: float = 0.12
@export var glow_pulse_speed: float = 0.9

var _is_collected := false
var _player_in_range := false
var _idle_time := 0.0
var _visual_base_position := Vector3.ZERO
var _idle_phase := 0.0

@onready var visual_root: Node3D = $VisualRoot
@onready var glow_light: OmniLight3D = $VisualRoot/GlowLight
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var prompt_label: Label3D = $InteractPrompt


func _ready() -> void:
	add_to_group("player_interactable")
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	prompt_label.visible = false
	_visual_base_position = visual_root.position
	_idle_phase = _get_idle_phase()
	glow_light.light_energy = glow_energy_base


func _process(delta: float) -> void:
	if _is_collected:
		return

	_update_idle_presentation(delta)


func _on_body_entered(body: Node3D) -> void:
	if _is_collected:
		return

	if not _is_player_body(body):
		return

	_player_in_range = true
	prompt_label.visible = true


func _on_body_exited(body: Node3D) -> void:
	if _is_collected:
		return

	if not _is_player_body(body):
		return

	_player_in_range = false
	prompt_label.visible = false


func _collect() -> void:
	if _is_collected:
		return

	_is_collected = true
	_player_in_range = false
	prompt_label.visible = false
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


func _get_idle_phase() -> float:
	var phase_seed: int = abs(int(hash(str(get_path())))) % 10000
	return (float(phase_seed) / 10000.0) * TAU


func _is_player_body(body: Node3D) -> bool:
	return body is CharacterBody3D and body.name == "Player"


func can_player_interact(player: Node3D) -> bool:
	if _is_collected:
		return false
	if player == null:
		return false
	return _player_in_range and _is_player_body(player)


func interact(player: Node3D) -> void:
	if not can_player_interact(player):
		return
	_collect()

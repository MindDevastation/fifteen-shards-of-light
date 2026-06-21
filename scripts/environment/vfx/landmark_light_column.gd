extends Node3D
class_name LandmarkLightColumn

signal appearance_completed

@export var appearance_duration: float = 1.8
@export var settle_duration: float = 0.45
@export var light_energy: float = 0.65

var _active := false
var _appearance_done := false
var _beam_materials: Array[ShaderMaterial] = []
var _ring_material: ShaderMaterial
@onready var visual_root: Node3D = $VisualRoot
@onready var falling_motes: GPUParticles3D = $VisualRoot/FallingMotes
@onready var rising_motes: GPUParticles3D = $VisualRoot/RisingMotes
@onready var landmark_glow: OmniLight3D = $VisualRoot/LandmarkGlow

func _ready() -> void:
	for child in $VisualRoot/BeamLayers.get_children():
		if child is MeshInstance3D and child.material_override is ShaderMaterial:
			child.material_override = child.material_override.duplicate()
			_beam_materials.append(child.material_override)
	if $VisualRoot/GroundRing.material_override is ShaderMaterial:
		$VisualRoot/GroundRing.material_override = $VisualRoot/GroundRing.material_override.duplicate()
		_ring_material = $VisualRoot/GroundRing.material_override
	_set_activation(0.0)
	set_active(false)

func appear() -> void:
	if _appearance_done:
		appearance_completed.emit()
		return
	_active = true
	show()
	visual_root.show()
	set_process(true)
	falling_motes.emitting = true
	rising_motes.emitting = true
	var tween := create_tween()
	tween.tween_method(_set_activation, 0.0, 1.0, appearance_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(landmark_glow, "light_energy", light_energy, appearance_duration)
	tween.tween_interval(settle_duration)
	tween.finished.connect(_on_appearance_finished)

func set_active(active: bool) -> void:
	_active = active
	visible = active
	visual_root.visible = active
	set_process(active)
	falling_motes.emitting = active
	rising_motes.emitting = active
	if not active:
		landmark_glow.light_energy = 0.0

func _process(delta: float) -> void:
	if not _active:
		return
	$VisualRoot/GroundRing.rotate_y(delta * 0.12)

func _set_activation(value: float) -> void:
	for material in _beam_materials:
		material.set_shader_parameter("activation", value)
	if _ring_material != null:
		_ring_material.set_shader_parameter("activation", value)

func _on_appearance_finished() -> void:
	_appearance_done = true
	appearance_completed.emit()

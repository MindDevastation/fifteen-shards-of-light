@tool
extends Node3D
class_name HelpStoneInscription3D

@export_category("Help Stone Inscription")
@export_multiline var text: String = "":
	set(value):
		text = value
		_update_inscription()
@export var inscription_size: Vector2 = Vector2(1.24, 0.84):
	set(value):
		inscription_size = value
		_update_inscription()
@export var font_size: int = 36:
	set(value):
		font_size = value
		_update_inscription()
@export var text_color: Color = Color(0.13, 0.095, 0.075, 1.0):
	set(value):
		text_color = value
		_update_inscription()
@export var text_shadow_color: Color = Color(0.52, 0.46, 0.36, 0.44):
	set(value):
		text_shadow_color = value
		_update_inscription()
@export var mask_color: Color = Color(0.34, 0.30, 0.25, 0.92):
	set(value):
		mask_color = value
		_update_inscription()

@onready var stone_mask: MeshInstance3D = $StoneMask
@onready var label: Label3D = $Label3D

var _mask_material: ShaderMaterial
var _mesh_localized := false

func _ready() -> void:
	_ensure_local_resources()
	_update_inscription()

func _ensure_local_resources() -> void:
	if not is_node_ready():
		return
	if not _mesh_localized and stone_mask.mesh != null:
		stone_mask.mesh = stone_mask.mesh.duplicate()
		stone_mask.mesh.resource_local_to_scene = true
		_mesh_localized = true
	if _mask_material == null and stone_mask.material_override is ShaderMaterial:
		_mask_material = (stone_mask.material_override as ShaderMaterial).duplicate() as ShaderMaterial
		_mask_material.resource_local_to_scene = true
		stone_mask.material_override = _mask_material

func _update_inscription() -> void:
	if not is_node_ready():
		return
	_ensure_local_resources()
	if stone_mask.mesh is PlaneMesh:
		(stone_mask.mesh as PlaneMesh).size = inscription_size
	if _mask_material != null:
		_mask_material.set_shader_parameter("stone_tint", mask_color)
	label.text = text
	label.font_size = font_size
	label.modulate = text_color
	label.outline_modulate = text_shadow_color
	label.width = inscription_size.x * 900.0

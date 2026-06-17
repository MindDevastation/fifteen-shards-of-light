@tool
extends Node3D
class_name HelpStoneTextPanel3D

@export_category("Help Stone Text")
@export_multiline var text: String = "":
	set(value):
		text = value
		_update_panel()
@export var panel_size: Vector2 = Vector2(1.16, 0.76):
	set(value):
		panel_size = value
		_update_panel()
@export var font_size: int = 38:
	set(value):
		font_size = value
		_update_panel()
@export var text_color: Color = Color(0.18, 0.12, 0.08, 1.0):
	set(value):
		text_color = value
		_update_panel()
@export var panel_color: Color = Color(0.34, 0.30, 0.25, 0.0):
	set(value):
		panel_color = value
		_update_panel()
@export var engraving_shadow_color: Color = Color(0.06, 0.045, 0.035, 0.72):
	set(value):
		engraving_shadow_color = value
		_update_panel()

@onready var backing_plane: MeshInstance3D = $BackingPlane
@onready var label: Label3D = $Label3D

var _panel_material: StandardMaterial3D
var _mesh_localized := false

func _ready() -> void:
	_ensure_local_resources()
	_update_panel()

func _ensure_local_resources() -> void:
	if not is_node_ready():
		return
	if not _mesh_localized and backing_plane.mesh != null:
		backing_plane.mesh = backing_plane.mesh.duplicate()
		backing_plane.mesh.resource_local_to_scene = true
		_mesh_localized = true
	if _panel_material == null:
		if backing_plane.material_override is StandardMaterial3D:
			_panel_material = (backing_plane.material_override as StandardMaterial3D).duplicate() as StandardMaterial3D
		else:
			_panel_material = StandardMaterial3D.new()
		_panel_material.resource_local_to_scene = true
		_panel_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		_panel_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		_panel_material.blend_mode = BaseMaterial3D.BLEND_MODE_MIX
		_panel_material.specular_mode = BaseMaterial3D.SPECULAR_DISABLED
		_panel_material.cull_mode = BaseMaterial3D.CULL_DISABLED
		_panel_material.no_depth_test = false
		backing_plane.material_override = _panel_material

func _update_panel() -> void:
	if not is_node_ready():
		return
	_ensure_local_resources()
	if backing_plane.mesh is PlaneMesh:
		(backing_plane.mesh as PlaneMesh).size = panel_size
	_panel_material.albedo_color = panel_color
	backing_plane.visible = panel_color.a > 0.01
	label.text = text
	label.font_size = font_size
	label.modulate = text_color
	label.outline_modulate = engraving_shadow_color
	label.width = panel_size.x * 900.0

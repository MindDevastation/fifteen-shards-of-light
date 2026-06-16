extends Node3D
class_name CloudQualityController

const CLOUD_MATERIAL := preload("res://resources/environment/stylized_cloud_material.tres")

func _ready() -> void:
	_apply_shadowless_soft_cloud_material(self)

func _apply_shadowless_soft_cloud_material(root: Node) -> void:
	if root is GeometryInstance3D:
		root.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	if root is MeshInstance3D:
		var mesh_instance := root as MeshInstance3D
		mesh_instance.material_override = CLOUD_MATERIAL
		mesh_instance.gi_mode = GeometryInstance3D.GI_MODE_DISABLED
	for child in root.get_children():
		_apply_shadowless_soft_cloud_material(child)

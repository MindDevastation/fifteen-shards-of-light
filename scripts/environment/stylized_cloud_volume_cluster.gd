extends "res://scripts/environment/cloud_quality_controller.gd"
class_name StylizedCloudVolumeCluster

const LOBE_LAYOUT := [
	{"name": "BackLobe", "position": Vector3(-0.18, 0.06, 0.26), "scale": Vector3(1.42, 0.64, 0.76), "shadow": 0.145, "highlight": 0.082},
	{"name": "MiddleLobe", "position": Vector3(0.0, 0.0, 0.0), "scale": Vector3(1.66, 0.74, 0.86), "shadow": 0.125, "highlight": 0.105},
	{"name": "FrontLobe", "position": Vector3(0.22, -0.03, -0.22), "scale": Vector3(1.30, 0.58, 0.70), "shadow": 0.105, "highlight": 0.118},
	{"name": "LeftPuff", "position": Vector3(-0.62, -0.04, -0.10), "scale": Vector3(0.92, 0.52, 0.62), "shadow": 0.115, "highlight": 0.112},
	{"name": "RightPuff", "position": Vector3(0.66, 0.02, 0.16), "scale": Vector3(1.04, 0.56, 0.66), "shadow": 0.135, "highlight": 0.096},
]

func _ready() -> void:
	super._ready()
	_build_volume_lobes()

func _build_volume_lobes() -> void:
	if has_node("VolumeLobes"):
		return
	var volume_root := Node3D.new()
	volume_root.name = "VolumeLobes"
	add_child(volume_root)
	for lobe_data in LOBE_LAYOUT:
		volume_root.add_child(_make_lobe(lobe_data))

func _make_lobe(lobe_data: Dictionary) -> MeshInstance3D:
	var mesh := SphereMesh.new()
	mesh.radius = 0.5
	mesh.height = 1.0
	mesh.radial_segments = 18
	mesh.rings = 10
	var lobe := MeshInstance3D.new()
	lobe.name = String(lobe_data["name"])
	lobe.mesh = mesh
	lobe.position = lobe_data["position"] as Vector3
	lobe.scale = lobe_data["scale"] as Vector3
	lobe.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	lobe.gi_mode = GeometryInstance3D.GI_MODE_DISABLED
	var material := CLOUD_MATERIAL.duplicate() as ShaderMaterial
	material.set_shader_parameter("body_shadow_strength", float(lobe_data["shadow"]))
	material.set_shader_parameter("crown_highlight_strength", float(lobe_data["highlight"]))
	material.set_shader_parameter("noise_influence", 0.032)
	lobe.material_override = material
	return lobe

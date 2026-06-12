extends Node

@export var soul_orb_path: NodePath
@export var barrier_path: NodePath
@export var open_offset: Vector3 = Vector3(0.0, -4.0, 0.0)
@export var open_duration: float = 3.5

var _opened := false

func _ready() -> void:
	var orb := get_node_or_null(soul_orb_path)
	if orb != null and orb.has_signal("collected"):
		orb.connect("collected", _on_soul_orb_collected)
	if get_tree() != null:
		get_tree().node_added.connect(_on_node_added)

func _on_node_added(node: Node) -> void:
	if _opened:
		return
	if node.name == "SoulOrb_Follow":
		_open_barrier()

func _on_soul_orb_collected() -> void:
	_open_barrier()

func _open_barrier() -> void:
	if _opened:
		return
	_opened = true
	var barrier := get_node_or_null(barrier_path) as Node3D
	if barrier == null:
		return
	var tween := create_tween()
	tween.tween_property(barrier, "position", barrier.position + open_offset, open_duration)

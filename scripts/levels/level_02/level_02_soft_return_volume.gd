extends Area3D
class_name Level02SoftReturnVolume

signal recovery_requested(anchor_id: StringName, body: Node3D)
signal recovery_completed(anchor_id: StringName, body: Node3D)

@export var enabled: bool = false
@export var default_anchor_id: StringName = &"center"
@export var transform_epsilon := 0.001
var _suspended := false
var _anchors: Dictionary = {}
var _pending: Node3D = null

func _ready() -> void:
	monitoring = enabled
	body_entered.connect(_on_body_entered)
	_auto_register_scene_anchors()

func _auto_register_scene_anchors() -> void:
	var root := get_tree().current_scene
	var safe := root.get_node_or_null("SafeAnchors") if root else null
	if safe:
		for child in safe.get_children():
			if child is Node3D:
				register_anchor(StringName(child.name.to_snake_case()), child)
				register_anchor(StringName(child.name), child)

func register_anchor(anchor_id: StringName, anchor: Node3D) -> void:
	if anchor != null:
		_anchors[anchor_id] = anchor

func commit_domain() -> void:
	arm()

func arm() -> void:
	enabled = true
	monitoring = true

func disarm() -> void:
	enabled = false
	monitoring = false

func set_suspended(value: bool) -> void:
	_suspended = value
	if not _suspended and _pending != null:
		var body := _pending
		_pending = null
		recover_body(body, default_anchor_id)

func recover_body(body: Node3D, anchor_id: StringName = default_anchor_id) -> bool:
	if not enabled or body == null:
		return false
	if _suspended:
		_pending = body
		return false
	var anchor: Node3D = _anchors.get(anchor_id, _anchors.get(default_anchor_id, null))
	if anchor == null:
		return false
	recovery_requested.emit(anchor_id, body)
	if "velocity" in body:
		body.velocity = Vector3.ZERO
	body.global_transform = anchor.global_transform
	recovery_completed.emit(anchor_id, body)
	return true

func _on_body_entered(body: Node3D) -> void:
	if body != null and body.name == "Player":
		recover_body(body)

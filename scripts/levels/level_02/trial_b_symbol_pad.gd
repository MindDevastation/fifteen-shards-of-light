extends Area3D
class_name TrialBSymbolPad
signal pad_pressed(pad_id: StringName)
@export var pad_id: StringName
var armed := false
func arm() -> void: armed = true; monitoring = true
func disarm() -> void: armed = false; monitoring = false
func interact(_player: Node3D=null) -> void:
	if armed: pad_pressed.emit(pad_id)
func _ready() -> void:
	monitoring = false
	body_entered.connect(func(body): if armed and body.name == "Player": pad_pressed.emit(pad_id))

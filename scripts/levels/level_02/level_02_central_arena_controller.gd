extends Area3D
class_name Level02CentralArenaController
signal center_presence_changed(present: bool)
var armed := false
func arm() -> void: armed = true; monitoring = true
func _ready() -> void:
	monitoring = false
	body_entered.connect(func(body): if armed and body.name == "Player": center_presence_changed.emit(true))
	body_exited.connect(func(body): if armed and body.name == "Player": center_presence_changed.emit(false))

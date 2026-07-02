extends Area3D
class_name Level02CentralArenaController
signal center_presence_changed(present: bool)
var armed := false

func commit_domain() -> void:
	disarm()

func arm() -> void:
	armed = true
	monitoring = true

func disarm() -> void:
	armed = false
	monitoring = false

func _ready() -> void:
	disarm()
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node3D) -> void:
	if armed and body.name == "Player":
		center_presence_changed.emit(true)

func _on_body_exited(body: Node3D) -> void:
	if armed and body.name == "Player":
		center_presence_changed.emit(false)

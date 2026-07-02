extends Area3D
class_name Level02ArrivalController
signal arrival_completed
var armed := false
var completed := false

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

func _on_body_entered(body: Node3D) -> void:
	if armed and not completed and body.name == "Player":
		completed = true
		arrival_completed.emit()

extends Area3D
class_name Level02ArrivalController
signal arrival_completed
var armed := false
var completed := false
func arm() -> void: armed = true
func _ready() -> void:
	monitoring = false
	body_entered.connect(_on_body_entered)
func _on_body_entered(body: Node3D) -> void:
	if armed and not completed and body.name == "Player":
		completed = true
		arrival_completed.emit()

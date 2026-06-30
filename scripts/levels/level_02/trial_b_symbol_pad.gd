extends Area3D
class_name TrialBSymbolPad

signal pad_pressed(pad_id: StringName)
@export var pad_id: StringName
@export var rearm_distance := 1.2
var armed := false
var occupied := false

func _ready() -> void:
	monitoring = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func arm() -> void:
	armed = not occupied
	monitoring = true

func disarm() -> void:
	armed = false

func can_player_interact(_player: Node = null) -> bool:
	return armed and not occupied

func interact(player: Node = null) -> void:
	if can_player_interact(player):
		armed = false
		pad_pressed.emit(pad_id)

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		occupied = true
		interact(body)

func _on_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		occupied = false
		if monitoring:
			armed = true

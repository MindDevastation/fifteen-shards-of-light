extends Area3D
class_name TrialBSymbolPad

signal pad_pressed(pad_id: StringName)
@export var pad_id: StringName
@export var rearm_distance := 1.2
var armed := false
var occupied := false
var input_permitted := false
var _accepted_while_occupied := false

func _ready() -> void:
	monitoring = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func arm() -> void:
	input_permitted = true
	monitoring = true
	armed = not occupied
	_accepted_while_occupied = false if not occupied else _accepted_while_occupied

func disarm() -> void:
	input_permitted = false
	armed = false
	monitoring = true

func can_player_interact(_player: Node = null) -> bool:
	return input_permitted and armed and not occupied and not _accepted_while_occupied

func interact(player: Node = null) -> void:
	_accept_press(player, false)

func _accept_press(player: Node, from_body_entry: bool) -> void:
	if player != null and player.name != "Player":
		return
	if not can_player_interact(player):
		return
	armed = false
	if from_body_entry:
		occupied = true
		_accepted_while_occupied = true
	pad_pressed.emit(pad_id)

func _on_body_entered(body: Node3D) -> void:
	if body.name != "Player":
		return
	_accept_press(body, true)
	if not occupied:
		occupied = true

func _on_body_exited(body: Node3D) -> void:
	if body.name != "Player":
		return
	occupied = false
	_accepted_while_occupied = false
	if input_permitted:
		armed = true

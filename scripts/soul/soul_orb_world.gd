extends Node3D

@export var hover_base_height: float = 1.25
@export var hover_amplitude: float = 0.12
@export var hover_speed: float = 1.1

@onready var hover_root: Node3D = $HoverRoot

var _time: float = 0.0


func _ready() -> void:
	hover_root.position.y = hover_base_height


func _process(delta: float) -> void:
	_time += delta
	hover_root.position.y = hover_base_height + sin(_time * hover_speed) * hover_amplitude

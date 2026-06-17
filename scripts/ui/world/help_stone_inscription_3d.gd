@tool
extends Node3D
class_name HelpStoneInscription3D

@export_category("Help Stone Inscription")
@export_multiline var text: String = "":
	set(value):
		text = value
		_update_inscription()
@export var inscription_size: Vector2 = Vector2(1.24, 0.84):
	set(value):
		inscription_size = value
		_update_inscription()
@export var font_size: int = 36:
	set(value):
		font_size = value
		_update_inscription()
@export var text_color: Color = Color(0.16, 0.12, 0.095, 1.0):
	set(value):
		text_color = value
		_update_inscription()
@export var text_shadow_color: Color = Color(0.055, 0.045, 0.036, 0.62):
	set(value):
		text_shadow_color = value
		_update_inscription()
@onready var label: Label3D = $Label3D

func _ready() -> void:
	_update_inscription()


func _update_inscription() -> void:
	if not is_node_ready():
		return
	label.text = text
	label.font_size = font_size
	label.modulate = text_color
	label.outline_modulate = text_shadow_color
	label.width = inscription_size.x * 900.0
	label.outline_size = maxi(2, int(round(float(font_size) * 0.085)))

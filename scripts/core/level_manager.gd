extends Node

@export var level_id: int = 1


func _ready() -> void:
	print("LevelManager ready for level %d." % level_id)

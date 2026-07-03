class_name Level03LocalPortalCore
extends Node3D

signal activation_started
signal activation_completed
signal transition_started
signal transition_failed(player: Node, error_code: int)
signal transition_completed

enum EntryMode { AUTO_ENTER, INTERACT }
@export var target_scene_path: String = "res://scenes/levels/Level_04.tscn"
@export var entry_mode: EntryMode = EntryMode.AUTO_ENTER
@export var require_entry_confirmation: bool = false
var active := false

func activate() -> void:
	if active:
		return
	activation_started.emit()
	active = true
	visible = true
	activation_completed.emit()

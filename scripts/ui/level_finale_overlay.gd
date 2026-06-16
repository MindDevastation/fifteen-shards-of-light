extends Control
class_name LevelFinaleOverlay

signal closed

@export var text_reveal_duration: float = 1.6
@export var open_duration: float = 0.35
@export var close_duration: float = 0.25

var _full_text := ""
var _can_confirm := false
var _closed_emitted := false
@onready var panel: PanelContainer = $Panel
@onready var finale_label: Label = $Panel/MarginContainer/VBoxContainer/FinaleText
@onready var continue_label: Label = $Panel/MarginContainer/VBoxContainer/ContinueHint

func _ready() -> void:
	hide()
	mouse_filter = Control.MOUSE_FILTER_STOP
	panel.modulate.a = 0.0
	continue_label.modulate.a = 0.0

func show_finale_text(text: String) -> void:
	_full_text = text
	_can_confirm = false
	_closed_emitted = false
	finale_label.text = ""
	continue_label.modulate.a = 0.0
	show()
	var tween := create_tween()
	tween.tween_property(panel, "modulate:a", 1.0, open_duration)
	tween.tween_method(_set_reveal_ratio, 0.0, 1.0, text_reveal_duration)
	tween.finished.connect(_on_reveal_finished)

func _unhandled_input(event: InputEvent) -> void:
	if not visible or not _can_confirm:
		return
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("interact"):
		accept_event()
		_close_once()

func _set_reveal_ratio(ratio: float) -> void:
	var count := int(round(_full_text.length() * ratio))
	finale_label.text = _full_text.substr(0, count)

func _on_reveal_finished() -> void:
	_can_confirm = true
	continue_label.text = "Нажми E, чтобы продолжить"
	create_tween().tween_property(continue_label, "modulate:a", 1.0, 0.25)

func _close_once() -> void:
	if _closed_emitted:
		return
	_closed_emitted = true
	_can_confirm = false
	var tween := create_tween()
	tween.tween_property(panel, "modulate:a", 0.0, close_duration)
	tween.finished.connect(func():
		hide()
		closed.emit()
	)

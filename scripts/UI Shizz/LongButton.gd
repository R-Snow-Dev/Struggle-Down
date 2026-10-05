extends Control
class_name LongButton

@export var text: String = ''

@onready var label = $Display/Label
@onready var display = $Display

signal pressed()
signal hover()
signal offHover()

func _ready() -> void:
	label.text = text



func _on_button_mouse_entered() -> void:
	display.position.y = 0
	hover.emit()

func _on_button_mouse_exited() -> void:
	display.position.y = 3
	offHover.emit()

func _on_button_pressed() -> void:
	pressed.emit()

extends Control
class_name TextButton

signal pressed()
signal hover()
signal off_hover()

var text: String = 'Test'

@onready var l = $Visuals/Label
@onready var v = $Visuals

@export var t: String = 'test'

func _ready() -> void:
	l.text = t

func setText(s: String) -> void:
	l.text = s
	
func _on_button_mouse_entered() -> void:
	hover.emit()
	v.position.y = -2


func _on_button_mouse_exited() -> void:
	off_hover.emit()
	v.position.y = 0


func _on_button_pressed() -> void:
	pressed.emit()

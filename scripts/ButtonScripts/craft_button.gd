extends Node2D
class_name ComponentButton

signal pressed(c: ComponentButton)
signal hover()
signal off_hover()

@onready var d = $Display
@onready var qMark = $Display/Label

var comp: Components

func setComp(c: Components) -> void:
	if comp:
		d.remove_child(comp)
	qMark.visible = false
	comp = c
	comp.scale = Vector2(2,2)
	d.add_child(comp)
	
func removeComp() -> void:
	d.remove_child(comp)
	qMark.visible = true

func _on_button_mouse_entered() -> void:
	AudioManager.play_sound('Hover')
	hover.emit()
	d.position.y = -2

func _on_button_mouse_exited() -> void:
	off_hover.emit()
	d.position.y = 0


func _on_button_pressed() -> void:
	AudioManager.play_sound('Select')
	pressed.emit(self)
	d.position.y = 0

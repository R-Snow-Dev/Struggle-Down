extends Node2D
class_name ArrowButton

signal pressed()
signal hover()
signal off_hover()

var isHovering = false
@onready var s = $Arrow

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("select"):
		if isHovering:
			pressed.emit()
			AudioManager.play_sound('Select')



func _on_area_2d_mouse_entered() -> void:
	AudioManager.play_sound('Hover')
	hover.emit()
	isHovering = true
	s.position.y = -2

func _on_area_2d_mouse_exited() -> void:
	isHovering = false
	off_hover.emit()
	s.position.y = 0

extends Area2D

signal up
signal down

var hover = false

func _process(delta: float) -> void:
	if hover:
		if Input.is_action_just_pressed("scroll_up"):
			up.emit()
		elif Input.is_action_just_pressed("scroll_down"):
			down.emit()

func _on_mouse_entered() -> void:
	hover = true

func _on_mouse_exited() -> void:
	hover = false

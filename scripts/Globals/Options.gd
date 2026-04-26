extends CanvasLayer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('Pause'):
		visible = false
		
func _on_back_pressed() -> void:
	AudioManager.play_sound('Select')
	visible = false


func _on_back_mouse_entered() -> void:
	AudioManager.play_sound('Hover')

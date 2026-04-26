extends Control
class_name PauseMenu

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('Pause'):
		if visible:
			AudioManager.play_sound('Select')
			EventBus.unpause.emit()
		else:
			AudioManager.play_sound('Pause')
			EventBus.pause.emit()
		visible = !visible


func _on_return_pressed() -> void:
	AudioManager.play_sound('Select')
	EventBus.unpause.emit()
	visible = false


func _on_return_to_title_screen_pressed() -> void:
	AudioManager.play_sound('Select')
	EventBus.unpause.emit()
	visible = false
	EventBus.title_screen.emit()


func _on_quit_pressed() -> void:
	AudioManager.play_sound('Select')
	EventBus.unpause.emit()
	visible = false
	EventBus.update_hp.emit(-9999)


func _on_options_pressed() -> void:
	AudioManager.play_sound('Select')
	OptionMenu.visible = true


func _on_return_mouse_entered() -> void:
	AudioManager.play_sound('Hover')


func _on_options_mouse_entered() -> void:
	AudioManager.play_sound('Hover')


func _on_quit_mouse_entered() -> void:
	AudioManager.play_sound('Hover')


func _on_return_to_title_screen_mouse_entered() -> void:
	AudioManager.play_sound('Hover')

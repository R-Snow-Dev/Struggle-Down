extends Node2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('Pause'):
		AudioManager.play_sound('Pause')
		EventBus.title_screen.emit()

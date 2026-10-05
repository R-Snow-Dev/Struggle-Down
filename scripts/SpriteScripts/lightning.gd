extends AnimatedSprite2D

	


func _on_frame_changed() -> void:
	if frame == 3:
		AudioManager.play_sound('Lightning')
		AudioManager.play_sound('Thunder')

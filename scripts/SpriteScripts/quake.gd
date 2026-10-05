extends AnimatedSprite2D




func _on_frame_changed() -> void:
	if frame == 0 or frame == 1:
		AudioManager.play_sound('Shake1')
	else:
		AudioManager.play_sound('Shake2')
		

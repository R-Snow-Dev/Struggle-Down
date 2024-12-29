extends CPUParticles2D




func _on_finished() -> void:
	# removes itself from a tree once it finishes playback
	queue_free()

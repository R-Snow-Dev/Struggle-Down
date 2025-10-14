extends CPUParticles2D

func _enter_tree() -> void:
	emitting = true


func _on_finished() -> void:
	# removes itself from a tree once it finishes playback
	queue_free()

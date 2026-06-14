extends WildDamage
class_name Explosion

@onready var visual = $CPUParticles2D


func _ready() -> void:
	visual.emitting = true
	await get_tree().create_timer(2).timeout
	end.emit()
	queue_free()

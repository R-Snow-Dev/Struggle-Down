extends WildDamage
class_name Explosion

@onready var visual = $CPUParticles2D


func _ready() -> void:
	visual.emitting = true
	await get_tree().create_timer(0.5).timeout
	end.emit()
	EventBus.playerDoneAttacking.emit()
	queue_free()

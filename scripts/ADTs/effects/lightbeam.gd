extends WeaponEffect
class_name Lightbeam

@onready var visual = $CPUParticles2D

func _process(delta: float) -> void:
	position.y += 5

func _ready() -> void:
	setEffect("stun")
	setChance(1.0)
	await get_tree().create_timer(0.18).timeout
	queue_free()

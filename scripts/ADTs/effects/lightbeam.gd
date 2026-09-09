extends WeaponEffect
class_name Lightbeam

@onready var visual = $CPUParticles2D

var facing = Vector2(0,0)

func _process(delta: float) -> void:
	position += 2.5 * facing

func _ready() -> void:
	var facing = Overseer.getController().player.facing
	setEffect("stun")
	setChance(1.0)
	await get_tree().create_timer(0.36).timeout
	queue_free()

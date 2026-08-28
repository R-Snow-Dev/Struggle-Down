extends Node2D
class_name AttackEffects

var lf = 0.1

func setLifespan(amount: float) -> void:
	lf = amount
	
func setSprite(s: Node) -> void:
	add_child(s)
	
func _ready() -> void:
	await get_tree().create_timer(lf).timeout
	call_deferred("queue_free")

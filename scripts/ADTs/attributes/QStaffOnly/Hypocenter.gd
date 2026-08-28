extends Attribute
class_name Hypocenter

func _init() -> void:
	type = "onAttacked"
	name = "Hypocenter"
	description = "You have become the origin of devastation.

Your weapon is triggered when you are hit.

All will turn to dust when the earth moves."
	
func effect(target : Node):
	Overseer.control.player.attack_origin.freeAttack(WeaponList.held)

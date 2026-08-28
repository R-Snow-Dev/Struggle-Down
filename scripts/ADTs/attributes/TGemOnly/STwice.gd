extends Attribute
class_name STwice

func _init() -> void:
	type = "onKill"
	name = "Strikes Twice"
	description = "It was always a myth.
	
	Your weapon triggers every time you kill a foe."

func effect(target : Node):
	target.player.attack_origin.freeAttack(WeaponList.held)

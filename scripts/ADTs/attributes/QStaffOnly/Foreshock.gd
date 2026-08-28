extends Attribute
class_name Foreshock

func _init() -> void:
	type = "onRoom"
	name = "Foreshock"
	description = "Herald the destruction.
	
	Your weapon triggers every time you enter an undiscovered room."

func effect(target : Node):
	target.player.attack_origin.freeAttack(WeaponList.held)

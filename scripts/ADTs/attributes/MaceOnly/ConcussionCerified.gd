extends Attribute
class_name ConcussionCertified

func _init() -> void:
	type = "passive"
	name = "Concussion Certified"
	description = "You gain the spite of a great spirit imprisoned inside the weapon. 

+15% chance to stun enemies when attacking with blunt, shockwave or explosive attacks."
	
func onPickup(target : Node):
	WeaponList.addIEffect("blunt", "stun", 0.15)
	WeaponList.addIEffect("shockwave", "stun", 0.15)
	WeaponList.addIEffect("explosive", "stun", 0.15)

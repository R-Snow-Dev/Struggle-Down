extends Attribute
class_name Rattled

func _init() -> void:
	type = "passive"
	name = "Rattled"
	description = "You gain the ire of the spirits imprisoned inside the weapon. 

+5% chance to stun enemies when attacking with blunt, shockwave or explosive attacks"
	
func onPickup(target : Node):
	WeaponList.addIEffect("blunt", "stun", 0.05)
	WeaponList.addIEffect("shockwave", "stun", 0.05)
	WeaponList.addIEffect("explosive", "stun", 0.05)

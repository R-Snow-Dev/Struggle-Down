extends Attribute
class_name LockUp

func _init() -> void:
	type = "passive"
	name = "Lock Up"
	description = "You gain the ire of the spirits imprisoned inside the gem. 

+5% chance to stun enemies when attacking with shock attacks."
	
func onPickup(target : Node):
	WeaponList.addIEffect("shock", "stun", 0.05)

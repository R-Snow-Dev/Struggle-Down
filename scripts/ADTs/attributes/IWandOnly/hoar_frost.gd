extends Attribute
class_name HoarFrost

func _init() -> void:
	type = "passive"
	name = "Hoar-Frost"
	description = "You inherit the wrath of the Winter Court. 
	
Your frost damage gain a 5% chance to afflict slow onto your enemies."
	
func onPickup(target : Node):
	WeaponList.addIEffect("frost", "slow", 0.05)

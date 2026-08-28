extends Attribute
class_name Detonate

func _init() -> void:
	type = "passive"
	name = "Chain Detonantions"
	description = "You inherit the madness of a infamous demolishionist. 

Your explosions gain a 5% chance to cause hit targets to explode."
	
func onPickup(target : Node):
	WeaponList.addIEffect("explosive", "exchain", 0.05)

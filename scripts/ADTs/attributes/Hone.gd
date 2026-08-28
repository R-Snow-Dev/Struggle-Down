extends Attribute
class_name Hone

func _init() -> void:
	type = "passive"
	name = "Honed"
	description = "You inherit the will of a great bladesmith.
	
	You deal 1 more slashing damage for all slashing attacks."

func onPickup(target : Node):
	WeaponList.damages["slash"] += 1

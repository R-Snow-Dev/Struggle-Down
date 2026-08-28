extends Attribute
class_name Golden

func _init() -> void:
	type = "passive"
	name = "Golden Soul"
	description = "You inherit the will of a devout believer.
	
	You deal 5 more holy damage for all holy attacks."

func onPickup(target : Node):
	WeaponList.damages["holy"] += 5

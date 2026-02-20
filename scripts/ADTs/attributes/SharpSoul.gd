extends Attribute
class_name SharpSoul

func _init() -> void:
	type = "passive"
	name = "Sharp Soul"
	description = "You inherit the will of a stabbing fanatic.
	
	You deal 1 more piercing damage for all piercing attacks."

func onPickup(target : Node):
	WeaponList.damages["pierce"] += 1

extends Attribute
class_name StabSpecialist

func _init() -> void:
	type = "passive"
	name = "Stab Specialist"
	description = "Maximum penetration, always.
	
	You deal 3 more piercing damage for all piercing attacks."

func onPickup(target : Node):
	WeaponList.damages["pierce"] += 3

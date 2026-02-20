extends Attribute
class_name SliceSpecialist

func _init() -> void:
	type = "passive"
	name = "Slice Specialist"
	description = "Become one with the cutting edge.
	
	You deal 3 more slashing damage for all slashing attacks."

func onPickup(target : Node):
	WeaponList.damages["slash"] += 3

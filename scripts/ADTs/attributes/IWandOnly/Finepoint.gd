extends Attribute
class_name Finepoint

func _init() -> void:
	type = "passive"
	name = "Finepoint"
	description = "Your focus increases your lethality.
	
	You deal 2 more piercing damage for all piercing attacks."

func onPickup(target : Node):
	WeaponList.damages["piercing"] += 2

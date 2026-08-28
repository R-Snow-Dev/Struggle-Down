extends Attribute
class_name Oxidizer

func _init() -> void:
	type = "passive"
	name = "Oxidizer"
	description = "You are touched by the spirit of destruction.
	
	You deal 3 more explosive damage for all explosion attacks."

func onPickup(target : Node):
	WeaponList.damages["explosive"] += 1

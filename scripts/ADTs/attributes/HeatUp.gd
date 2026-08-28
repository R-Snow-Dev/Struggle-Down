extends Attribute
class_name HeatUp

func _init() -> void:
	type = "passive"
	name = "Heat Up"
	description = "You are touched by the spirit of fire.
	
	You deal 2 more fire damage for all fire attacks."

func onPickup(target : Node):
	WeaponList.damages["fire"] += 2

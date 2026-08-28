extends Attribute
class_name ColdSnap

func _init() -> void:
	type = "passive"
	name = "Cold Snap"
	description = "You are touched by the spirit of winter.
	
	You deal 1 more frost damage for all frost attacks."

func onPickup(target : Node):
	WeaponList.damages["frost"] += 1

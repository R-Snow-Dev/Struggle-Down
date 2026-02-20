extends Attribute
class_name SuperAdapt

func _init() -> void:
	type = "passive"
	name = "Super Adaptability"
	description = "You are familiar with all forms of violence.
	
	You deal 1 more damage for all damage types."

func onPickup(target : Node):
	for d in WeaponList.damages:
		WeaponList.damages[d] += 1

extends Attribute
class_name SpearMastery


func _init() -> void:
	type = "passive"
	name = "Spear Mastery"
	description = "You inherit the will of an unnamed soldier.
	
	You deal 1 more piercing damage when using a spear."

func onPickup(target : Node):
	WeaponList.weapons[4].addBaseDam(1)

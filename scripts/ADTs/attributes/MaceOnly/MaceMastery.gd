extends Attribute
class_name MaceMastery

func _init() -> void:
	type = "passive"
	name = "Mace Mastery"
	description = "You inherit the will of an unnamed warrior. 

You deal 1 more blunt damage when using a mace."

func onPickup(target : Node):
	WeaponList.weapons[3].addBaseDam(1)

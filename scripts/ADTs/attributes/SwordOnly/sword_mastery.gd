extends Attribute
class_name SwordMastery


func _init() -> void:
	type = "passive"
	name = "Sword Mastery"
	description = "You inherit the will of an unnamed swordsman. You deal 1 more slashing damage when using a sword."

func onPickup(target : Node):
	WeaponList.weapons[1].addBaseDam(1)

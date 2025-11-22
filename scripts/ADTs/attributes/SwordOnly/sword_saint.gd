extends Attribute
class_name SwordSaint

func _init() -> void:
	type = "passive"
	name = "Sword Saint"
	description = "You inherit the will of a swordsman of great renown. When attacking
	with a sword, deal an extra 3 slashing damage"
	
func onPickup(target : Node):
	WeaponList.weapons[1].addBaseDam(3)

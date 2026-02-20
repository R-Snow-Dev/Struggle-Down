extends Attribute
class_name HolyBlessing

func _init() -> void:
	type = "passive"
	name = "Blood Baptism"
	description = "The blood of the most holy of beings resists being burned. Wash your hands in it, and be purified.

 All melee weapons gain holy attack, and your holy damage is increased by 3. 

Go and grant peace."

func onPickup(target : Node):
	for x in range(0, 7):
		WeaponList.weapons[x].addExtraAttack("holy")
	WeaponList.damages["holy"] += 3

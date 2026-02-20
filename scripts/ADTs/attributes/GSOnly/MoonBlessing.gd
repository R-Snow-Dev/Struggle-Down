extends Attribute
class_name MoonBlessing

func _init() -> void:
	type = "passive"
	name = "Blessing of the Moon"
	description = "Ancient Moonlight is freed from it's vessel, illuminating your soul.

 All melee weapons gain frost attack, and your frost damage is increased by 3. 

Though a reflection, the light of the moon still touches all."

func onPickup(target : Node):
	for x in range(0, 7):
		WeaponList.weapons[x].addExtraAttack("frost")
	WeaponList.damages["frost"] += 3

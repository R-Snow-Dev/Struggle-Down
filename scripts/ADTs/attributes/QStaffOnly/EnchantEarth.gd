extends Attribute
class_name EnchantEarth

func _init() -> void:
	type = "passive"
	name = "Enchantment: Earth"
	description = "You inherit the power of Richter.
	
	All Weapons gain an additional shockwave attack."

func onPickup(target : Node):
	for w:Weapon in WeaponList.weapons.slice(1,-1):
		w.addExtraAttack('shockwave')
	if WeaponList.damages["shockwave"] < 1:
		WeaponList.damages["shockwave"] += 1

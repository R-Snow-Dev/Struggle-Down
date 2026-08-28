extends Attribute
class_name EnchantFire

func _init() -> void:
	type = "passive"
	name = "Enchantment: Fire"
	description = "You inherit the power of the Red Star.
	
	All Weapons gain an additional fire attack."

func onPickup(target : Node):
	for w:Weapon in WeaponList.weapons.slice(1,-1):
		w.addExtraAttack('fire')
	if WeaponList.damages["fire"] < 1:
		WeaponList.damages["fire"] += 1

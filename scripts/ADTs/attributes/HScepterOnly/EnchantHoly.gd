extends Attribute
class_name EnchantHoly

func _init() -> void:
	type = "passive"
	name = "Enchantment: Light"
	description = "You inherit the power of the One Above.
	
	All Weapons gain an additional holy attack."

func onPickup(target : Node):
	for w:Weapon in WeaponList.weapons.slice(1,-1):
		w.addExtraAttack('holy')
	if WeaponList.damages["holy"] < 1:
		WeaponList.damages["holy"] += 1

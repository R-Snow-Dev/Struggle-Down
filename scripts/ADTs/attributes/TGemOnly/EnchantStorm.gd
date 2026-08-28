extends Attribute
class_name EnchantStorm

func _init() -> void:
	type = "passive"
	name = "Enchantment: Storm"
	description = "You inherit the power of Saint Elmo.
	
	All Weapons gain an additional shock attack."

func onPickup(target : Node):
	for w:Weapon in WeaponList.weapons.slice(1,-1):
		w.addExtraAttack('shock')
	if WeaponList.damages["shock"] < 1:
		WeaponList.damages["shock"] += 1

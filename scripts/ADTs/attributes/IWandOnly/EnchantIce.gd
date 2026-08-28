extends Attribute
class_name EnchantIce

func _init() -> void:
	type = "passive"
	name = "Enchantment: Ice"
	description = "You inherit the power of the Northmen.
	
	All Weapons gain an additional frost attack."

func onPickup(target : Node):
	for w:Weapon in WeaponList.weapons.slice(1,-1):
		w.addExtraAttack('frost')
	if WeaponList.damages["frost"] < 1:
		WeaponList.damages["frost"] += 1

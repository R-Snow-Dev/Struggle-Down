extends Attribute
class_name MaceMult

func effect(target: Node) -> int:
	var mace: Weapon = WeaponList.weapons[3]
	mace.setCost(target.actionsAvailable)
	mace.setAtkDam(target.actionsAvailable * mace.getBaseDam())
	return 0

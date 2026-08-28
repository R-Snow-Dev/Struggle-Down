extends Attribute
class_name MaceMult

func effect(target: Node) -> int:
	var mace: Weapon = WeaponList.weapons[3]
	mace.setTCost(target.actionsAvailable)
	mace.setAtkDam(target.actionsAvailable * mace.getBaseDam())
	effectDone.emit()
	return 0

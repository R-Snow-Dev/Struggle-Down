extends Attribute
class_name BlackGS
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	WeaponList.weapons[2].setTCost(WeaponList.weapons[2].getCost() - 1)
	return 0

func special(target: Node) -> int:
	return 0

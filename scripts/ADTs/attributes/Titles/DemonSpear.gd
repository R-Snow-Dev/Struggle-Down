extends Attribute
class_name DemonSpear
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	if Overseer.wrath:
		WeaponList.weapons[4].setTCost(0)
	return 0

func special(target: Node) -> int:
	return 0

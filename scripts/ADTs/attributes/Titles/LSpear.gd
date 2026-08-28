extends Attribute
class_name LSpear
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	WeaponList.addTempDamage("holy", 5)
	return 0

func special(target: Node) -> int:
	return 0

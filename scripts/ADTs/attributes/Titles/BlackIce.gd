extends Attribute
class_name BlackIce
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	WeaponList.addTempEffect('blackfrost', 0.2)
	return 0

func special(target: Node) -> int:
	return 0

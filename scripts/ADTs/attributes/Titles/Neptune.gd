extends Attribute
class_name Neptune
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	WeaponList.addTempEffect('slow', 1.0)
	return 0

func special(target: Node) -> int:
	return 0

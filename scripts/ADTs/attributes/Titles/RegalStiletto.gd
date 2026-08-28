extends Attribute
class_name RegalStiletto
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	WeaponList.addTempDamage('pierce', int(Overseer.getGold() / 20))
	return 0

func special(target: Node) -> int:
	return 0

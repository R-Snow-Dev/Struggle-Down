extends Attribute
class_name KingHalberd
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	if rng.randf() > 0.05:
		WeaponList.addTempDamage('death', 1)
	return 0

func special(target: Node) -> int:
	return 0

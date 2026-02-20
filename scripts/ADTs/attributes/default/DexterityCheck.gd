extends Attribute
class_name DexterityCheck
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	var w: Weapon = WeaponList.weapons[6]
	if rng.randf() > 0.666:
		w.setCost(1)
	else:
		w.setCost(0)
	return 0

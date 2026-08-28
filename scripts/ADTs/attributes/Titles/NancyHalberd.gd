extends Attribute
class_name NancyHalberd
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	var w: Weapon = WeaponList.weapon[5]
	if w.getDamageType() == 'pierce':
		WeaponList.addTempEffect('bleed', 1.0)
	else:
		WeaponList.addTempEffect('slow', 1.0)
	return 0

func special(target: Node) -> int:
	return 0

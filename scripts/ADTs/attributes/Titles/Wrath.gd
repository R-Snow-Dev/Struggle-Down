extends Attribute
class_name Wrath
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	if Overseer.getWrath():
		WeaponList.addTempDamage('fire',1)
	return 0

func special(target: Node) -> int:
	if Overseer.getWrath():
		Overseer.setWrath(false)
	else:
		Overseer.setWrath(true)
	return 0

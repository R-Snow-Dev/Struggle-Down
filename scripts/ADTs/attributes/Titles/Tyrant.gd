extends Attribute
class_name Tyrant
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	var amount = SaveController.getData('pHP') - SaveController.getData('curHP')
	WeaponList.addTempDamage('explosive', amount)
	return 0

func special(target: Node) -> int:
	return 0

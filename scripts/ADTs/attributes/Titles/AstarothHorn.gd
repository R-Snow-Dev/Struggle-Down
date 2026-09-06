extends Attribute
class_name AstarothHorn
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	WeaponList.addTempDamage('fire', pow(SaveController.getData('floor'), SaveController.getData('level')))
	return 0

func special(target: Node) -> int:
	return 0

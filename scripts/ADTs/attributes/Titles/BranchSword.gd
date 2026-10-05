extends Attribute
class_name BranchSword
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	WeaponList.addTempDamage("special", 7)
	print('yea')
	return 0

func special(target: Node) -> int:
	return 0

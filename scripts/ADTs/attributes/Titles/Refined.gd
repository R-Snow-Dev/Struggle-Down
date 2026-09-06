extends Attribute
class_name Refined
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	return 0

func special(target: Node) -> int:
	var g: Weapon = WeaponList.weapons[10]
	g.setTDim(Vector2(3,11))
	WeaponList.addTempDamage('shock', -3)
	WeaponList.addTempEffect('stun', 0.3)
	return 0

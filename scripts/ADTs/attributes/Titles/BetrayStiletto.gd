extends Attribute
class_name BetrayStiletto
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	var w: Weapon = WeaponList.weapons[6]
	w.setTDim(Vector2i(1,3))
	w.setTOrigin(Vector2(0,-1))
	return 0

func special(target: Node) -> int:
	return 0

extends Attribute
class_name Artisan
var rng = RandomNumberGenerator.new()

var amount = 0

func effect(target: Node) -> int:
	var charm:Weapon = WeaponList.weapons[11]
	amount = 0
	return 0

func special(target: Node) -> int:
	var charm:Weapon = WeaponList.weapons[11]
	amount += 1
	charm.setTDim(charm.getDim() + Vector2i(2*amount, 2*amount))
	charm.setTOrigin(charm.getOrigin() - Vector2(0,amount))
	EventBus.updateActions.emit(-1)
	return 0

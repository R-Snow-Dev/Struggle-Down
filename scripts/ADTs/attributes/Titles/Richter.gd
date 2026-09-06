extends Attribute
class_name Richter
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	WeaponList.addTempDamage('shockwave', Overseer.getController().player.actionsAvailable)
	return 0

func special(target: Node) -> int:
	return 0

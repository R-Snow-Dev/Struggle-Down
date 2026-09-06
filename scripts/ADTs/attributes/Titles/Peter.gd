extends Attribute
class_name Peter
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	return 0

func special(target: Node) -> int:
	EventBus.swap_weapon.emit(0)
	EventBus.update_hp.emit(SaveController.getData('pHP') - SaveController.getData('curHP'))
	target.shielded = true
	target.draw()
	return 0

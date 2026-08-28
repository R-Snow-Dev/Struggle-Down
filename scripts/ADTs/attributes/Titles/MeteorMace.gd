extends Attribute
class_name MeteorMace
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	print("Special Power")
	EventBus.updateActions.emit(target.actionsAvailable)
	return 0

func special(target: Node) -> int:
	return 0

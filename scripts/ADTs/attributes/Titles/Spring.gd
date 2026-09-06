extends Attribute
class_name Spring
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	return 0

func special(target: Node) -> int:
	EventBus.pause.emit()
	Overseer.getBoard().randTP()
	EventBus.unpause.emit()
	return 0

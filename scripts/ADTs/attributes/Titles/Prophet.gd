extends Attribute
class_name Prophet
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	return 0

func special(target: Node) -> int:
	Overseer.getController().revealLadder()
	return 0

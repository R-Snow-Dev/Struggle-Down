extends Attribute
class_name TrollMace
var rng = RandomNumberGenerator.new()

var tname = 'Troll Mace'

func effect(target: Node) -> int:
	print("Special Power")
	if target.actionsAvailable >= SaveController.getData('pActions'):
		print("shields up")
		target.shielded = true
	return 0

func special(target: Node) -> int:
	return 0

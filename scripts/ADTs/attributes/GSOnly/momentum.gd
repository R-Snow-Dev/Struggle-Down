extends Attribute
class_name Momentum

var counter: int = 0

func _init() -> void:
	type = "onHit"
	name = "Momentum"
	description = "You inherit the will of an unnamed giant.
	
	Your greatsword deals 2 more slashing damage for every sequential attack used on your turn."
	EventBus.fiend_phase.connect(reset)

func effect(target: Node) -> int:
	if WeaponList.held == 2:
		var total = counter
		counter += 2
		effectDone.emit()
		return total
	effectDone.emit()
	return 0

func reset() -> void:
	counter = 0

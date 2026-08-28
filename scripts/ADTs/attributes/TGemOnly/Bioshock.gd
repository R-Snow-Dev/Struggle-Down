extends Attribute
class_name Bioshock

var rng = RandomNumberGenerator.new()

func _init() -> void:
	type = "onKill"
	name = "Overclock"
	description = "You gain an understanding of the lightning present in all creatures.
	
	Gain a 25% chance to recover one action every time you kill a foe."


func effect(target : Node):
	if rng.randf() <= 0.25:
		EventBus.updateActions.emit(1)
	effectDone.emit()

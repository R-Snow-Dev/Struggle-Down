extends Attribute
class_name Nimble

func _init() -> void:
	type = "passive"
	name = "Nimble Footed"
	description = "You gain the skill of a successfull rogue.

Gain 1 permanent action."
	
func onPickup(target : Node):
	EventBus.updateTotActions.emit(1)

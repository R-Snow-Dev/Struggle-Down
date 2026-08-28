extends Attribute
class_name Gale

func _init() -> void:
	type = "passive"
	name = "Gale"
	description = "Hurricane-force speed.

Gain 1 permanent action."
	
func onPickup(target : Node):
	EventBus.updateTotActions.emit(1)

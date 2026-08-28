extends Attribute
class_name Sirocco

func _init() -> void:
	type = "passive"
	name = "Sirocco"
	description = "Gain the ferocity of the Sirocco, the Desert Wind.

Gain 2 permanent actions."
	
func onPickup(target : Node):
	EventBus.updateTotActions.emit(2)

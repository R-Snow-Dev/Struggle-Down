extends Attribute
class_name WindUP

func _init() -> void:
	type = "passive"
	name = "Wind Up"
	description = "You gain the patience of a stalwart guardian.

Gain 1 permanent action."
	
func onPickup(target : Node):
	EventBus.updateTotActions.emit(1)

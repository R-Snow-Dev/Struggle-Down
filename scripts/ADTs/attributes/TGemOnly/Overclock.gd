extends Attribute
class_name Overclock

func _init() -> void:
	type = "onRoom"
	name = "Overclock"
	description = "A touch of thunder fills your muscles.
	
	Gain a extra action every time you enter an undiscovered room."


func effect(target : Node):
	EventBus.updateActions.emit(1)

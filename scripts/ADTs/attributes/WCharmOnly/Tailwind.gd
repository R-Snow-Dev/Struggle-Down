extends Attribute
class_name Tailwind

func _init() -> void:
	type = "onRoom"
	name = "Tailwind"
	description = "A gust of wind gently urges you forward.
	
	Gain a extra action every time you enter an undiscovered room."


func effect(target : Node):
	EventBus.updateActions.emit(1)

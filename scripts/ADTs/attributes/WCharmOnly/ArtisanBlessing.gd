extends Attribute
class_name ArtisanBlessing

var stacks = 0 

func _init() -> void:
	type = "onRoom"
	name = "Artisan's Refinement"
	description = "An artist's work cannot be shortcut. Mediocrity comes from those who rush.
	
	Everytime you enter a room, gain extra actions equal to the amount of rooms you have discovered. Resets upon descending floors.
	
	The journey defines the destination."


func effect(target : Node):
	stacks += 1
	EventBus.updateActions.emit(stacks)

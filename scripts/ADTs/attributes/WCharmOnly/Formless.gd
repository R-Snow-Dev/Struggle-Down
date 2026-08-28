extends Attribute
class_name Formless

func _init() -> void:
	type = "passive"
	name = "Formless"
	description = "The winds are ever changing, ever moving, and unstoppable. You shall be aswell.

When moving, gain a 25% chance for an action to not be consumed.

Become unbound."
	
func onPickup(target : Node):
	Overseer.control.player.nullChance += 0.25

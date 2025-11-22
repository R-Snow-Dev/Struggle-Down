extends Attribute
class_name QuickDraw

func _init() -> void:
	type = "onCondition"
	name = "Quick Draw"
	description = "You inherit the teachings of a mighty samurai. If your first action
	is an attack with a sword, you gain a 5% chance that no action is consumed."
	
func onPickup(target : Node):
	pass

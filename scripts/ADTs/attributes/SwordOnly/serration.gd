extends Attribute
class_name Serration

func _init() -> void:
	type = "active"
	name = "Serration"
	description = "The spirit of a chipped blade grants you it's grudge. When using a sword,
	you may right-click its icon to serrate its edge at the cost of an action. The next time
	you attack with the sword, you will deal a bonus 3 slashing damage, and gain an extra 50% chance to bleed."
	
func effect(target: Node) -> int:
	return 0

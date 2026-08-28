extends Attribute
class_name Angel

func _init() -> void:
	type = "passive"
	name = "Angel"
	description = "The heavens have always been at war with the Unholy ones. Only their angels had the powers to mach the dark forces, however still their might was not enough. All they could do was stall. 
	
	Gain a 5% chance to ignore damage.
	
	You are their hope. They fight beside you now."

func onPickup(target : Node):
	UpgradeList.angel += 0.05

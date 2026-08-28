extends Attribute
class_name RegalBlessing

func _init() -> void:
	type = "passive"
	name = "Regal Blessing"
	description = "The soul of a wealthy monarch blesses you. 
	
	All enemies drop the maximum gold possible.
	
	Money is power, and you will have all of it."

func onPickup(target : Node):
	UpgradeList.setMax(true)

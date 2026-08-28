extends Attribute
class_name DTassel

func _init() -> void:
	type = "passive"
	name = "Demon Tassel"
	description = "Infernal artifact found on the hilts of weapons belonging to the most foul of demons.\n
	Increase damage done when using a melee weapon."

func onPickup(target : Node):
	UpgradeList.setRData('meleeMult', 1.3)

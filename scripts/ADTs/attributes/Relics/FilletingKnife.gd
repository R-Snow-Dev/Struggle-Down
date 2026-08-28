extends Attribute
class_name FKnife

func _init() -> void:
	type = "passive"
	name = "Filleting Knife"
	description = "An elegant and slender blade.\n
	Gain more component drops from fiends."

func onPickup(target : Node):
	UpgradeList.setRData('dropAttempts', 2)

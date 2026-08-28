extends Attribute
class_name GStandard

func _init() -> void:
	type = "passive"
	name = "Gold Standard"
	description = "Battle standard carried by the armies of avarice.\n
	Multiplies damage done with all weapons in proportion with the amount of gold collected."

func onPickup(target : Node):
	UpgradeList.setRData('goldMult', true)

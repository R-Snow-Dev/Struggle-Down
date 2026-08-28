extends Attribute
class_name PStarter

func _init() -> void:
	type = "passive"
	name = "Primordial Starter"
	description = "Prima Materium. All matter derives from this.\n
	Items may not be consumed upon use."

func onPickup(target : Node):
	UpgradeList.setRData('consumptionChance', 0.8)

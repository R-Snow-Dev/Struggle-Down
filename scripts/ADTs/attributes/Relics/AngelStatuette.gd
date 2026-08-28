extends Attribute
class_name AStatuette

func _init() -> void:
	type = "passive"
	name = "Angel Statuette"
	description = "Depicts a guardian from beyond the veil. You feel safer.\n
	Gain immunity to all field damage."

func onPickup(target : Node):
	UpgradeList.setRData('angel', true)

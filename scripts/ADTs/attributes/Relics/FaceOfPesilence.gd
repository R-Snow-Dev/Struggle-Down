extends Attribute
class_name FPesilence

func _init() -> void:
	type = "passive"
	name = "Face of Pestilence"
	description = "Mask of a plague doctor. Its purpose has been twitsed by infernal magicks.\n
	Damage done by damage-over-time effects are doubled."

func onPickup(target : Node):
	UpgradeList.setRData('pestilence', 2.0)

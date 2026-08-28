extends Attribute
class_name Libra

func _init() -> void:
	type = "passive"
	name = "Libra"
	description = "Constellation given form. Contains governance over balance.\n
	The weaknesses and resistences of fiends are both reduced."

func onPickup(target : Node):
	UpgradeList.setRData('libra', true)

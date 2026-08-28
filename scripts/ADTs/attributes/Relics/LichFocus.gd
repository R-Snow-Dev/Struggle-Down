extends Attribute
class_name LFocus

func _init() -> void:
	type = "passive"
	name = "Lich Focus"
	description = "Arcane focus crafted out of a human skull. Contains a re-purposed phylactery.\n
	Increase damage done when using a magic weapon."

func onPickup(target : Node):
	UpgradeList.setRData('magMult', 1.3)

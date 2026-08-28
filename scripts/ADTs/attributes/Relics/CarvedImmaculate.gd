extends Attribute
class_name CImmaculate

func _init() -> void:
	type = "passive"
	name = "The Carved Immaculate"
	description = "Perfection represented on the material plane. An impossible object.\n
	Gain a point in a random stat for the rest of the run whenever you complete a floor without taking damage."

func onPickup(target : Node):
	UpgradeList.setRData('immaculate', true)

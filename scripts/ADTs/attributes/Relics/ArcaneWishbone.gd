extends Attribute
class_name AWishbone

func _init() -> void:
	type = "passive"
	name = "Arcane Wishbone"
	description = "Forked wishbone of an arcane creature. Magic travels through it freely.\n
	Double cast spells, but each spell deals half of its original damage."

func onPickup(target : Node):
	UpgradeList.setRData('wishbone', true)

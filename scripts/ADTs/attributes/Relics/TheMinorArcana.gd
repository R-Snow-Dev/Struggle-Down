extends Attribute
class_name MinorArcana

func _init() -> void:
	type = "passive"
	name = "The Minor Arcana"
	description = "An enchanted deck of cards.\n
	Gain a random upgrade every level."

func onPickup(target : Node):
	UpgradeList.setRData('arcana', true)

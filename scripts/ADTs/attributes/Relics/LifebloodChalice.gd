extends Attribute
class_name LChalice

func _init() -> void:
	type = "passive"
	name = "Lifeblood Chalice"
	description = "The blood of divinty, yours to consume.\n
	Gain 1 extra action to use when below 50% health."

func onPickup(target : Node):
	UpgradeList.setRData('chalice', true)

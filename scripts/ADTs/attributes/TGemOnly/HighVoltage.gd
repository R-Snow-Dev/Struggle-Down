extends Attribute
class_name HighVoltage

func _init() -> void:
	type = "passive"
	name = "High Voltage"
	description = "You are touched by the spirit of the storm.
	
	You deal 2 more shock damage for all lightning attacks."

func onPickup(target : Node):
	WeaponList.damages["shock"] += 2

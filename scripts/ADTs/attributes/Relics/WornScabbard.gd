extends Attribute
class_name WWScabbard

func _init() -> void:
	type = "passive"
	name = "Well Worn Scabbard"
	description = "Feels like an old friend.\n
	The start of every floor will always have a sword."

func onPickup(target : Node):
	UpgradeList.setRData('swords', true)

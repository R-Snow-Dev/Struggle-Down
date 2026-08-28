extends Attribute
class_name AMap

func _init() -> void:
	type = "passive"
	name = "Andesite Map"
	description = "Mysterious map carved in stone.\n
	Floors will be bigger."

func onPickup(target : Node):
	UpgradeList.setRData('decoys', 4)

extends Attribute
class_name CrystalShell

func _init() -> void:
	type = "onRoom"
	name = "Crystal Shell"
	description = ".
	
	Gain a shield that absorbs one attack every time you enter an undiscovered room."

func onPickup(target : Node):
	target.shields += 1

func effect(target : Node):
	target.shielded = true
	UpgradeList.cShields = UpgradeList.shields

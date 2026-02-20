extends Attribute
class_name BusterBash

func _init() -> void:
	type = "passive"
	name = "Buster Bash"
	description = "None shall resist. Smash even the immeterial. 

Your mace attacks ignore all physical resistances and immunities. 

Your might trumps even death."
	
func onPickup(target : Node):
	WeaponList.weapons[3].setIgnore(true)

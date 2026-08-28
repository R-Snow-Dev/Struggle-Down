extends Attribute
class_name WindMastery

func _init() -> void:
	type = "passive"
	name = "Wind Mastery"
	description = "You inherit the will of a Cardinal Wind.
	
	When attacking with a Wind Charm, deal an extra 3 slashing damage"
	
func onPickup(target : Node):
	WeaponList.weapons[11].addBaseDam(3)

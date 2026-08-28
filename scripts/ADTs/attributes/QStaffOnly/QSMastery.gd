extends Attribute
class_name QSMaster

func _init() -> void:
	type = "passive"
	name = "Quake Staff Mastery"
	description = "You inherit the will of a renouned Earth Sage.
	
	You deal 1 more shackwave damage when using a Quake Staff."

func onPickup(target : Node):
	WeaponList.weapons[8].addBaseDam(1)

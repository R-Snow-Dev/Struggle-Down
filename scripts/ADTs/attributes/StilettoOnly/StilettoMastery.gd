extends Attribute
class_name StilettoMastery

func _init() -> void:
	type = "passive"
	name = "Stiletto Mastery"
	description = "You inherit the will of an unnamed nobleman.
	
You deal 1 more piercing damage when using a stiletto."

func onPickup(target : Node):
	WeaponList.weapons[6].addBaseDam(1)

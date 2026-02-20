extends Attribute
class_name GSMastery

func _init() -> void:
	type = "passive"
	name = "Great Sword Mastery"
	description = "You inherit the will of an unnamed beserker.
	
	You deal 1 more slashing damage when using a great sword."

func onPickup(target : Node):
	WeaponList.weapons[2].addBaseDam(1)

extends Attribute
class_name Massive

func _init() -> void:
	type = "passive"
	name = "Get Massive"
	description = "This sword is a grower.
	
	Gain +5 slashing damage when using a greatsword, but increase the action cost by 1."

func onPickup(target : Node):
	WeaponList.weapons[2].addBaseDam(5)
	WeaponList.weapons[2].addCost(1)

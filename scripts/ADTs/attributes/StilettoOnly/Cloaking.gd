extends Attribute
class_name Cloaking

func _init() -> void:
	type = "passive"
	name = "Shrouded Strike"
	description = "From the shadows, a knife to the back.
	
	All magic weapons gain 1 extra piercing attack."

func onPickup(target : Node):
	pass
	#for x in range(7, 14):
		#WeaponList.weapons[x].addExtraAttack("pierce")

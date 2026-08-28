extends Attribute
class_name Luck

func _init() -> void:
	type = "passive"
	name = "Lucky Charm"
	description = "Gain a blessing from lady luck. 
	
	All status effects gain a bonus 5% activation chance."

func onPickup(target : Node):
	WeaponList.flatChance += 0.05

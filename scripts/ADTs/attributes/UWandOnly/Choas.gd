extends Attribute
class_name Chaos

func _init() -> void:
	type = "passive"
	name = "Chaos"
	description = "The spirit of entropy empowers you.
	
	Gain +5 to all damage types, but increase the action cost of all weapons by 1."

func onPickup(target : Node):
	for d in WeaponList.damages:
		d += 5
	for w:Weapon in WeaponList.weapons.slice(1,-1):
		w.addCost(1)

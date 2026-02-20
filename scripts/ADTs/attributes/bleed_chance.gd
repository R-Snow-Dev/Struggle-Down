extends Attribute
class_name BleedChance

func _init() -> void:
	type = "passive"
	name = "Savage Strike"
	description = "You gain the malice of the spirits imprisoned in the weapon. 
	
Your slashing and piercing damage gain a 5% chance to afflict bleed onto your enemies."
	
func onPickup(target : Node):
	WeaponList.addIEffect("slash", "bleed", 0.05)
	WeaponList.addIEffect("pierce", "bleed", 0.05)

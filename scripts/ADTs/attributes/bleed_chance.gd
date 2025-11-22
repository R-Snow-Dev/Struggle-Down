extends Attribute

func _init() -> void:
	type = "passive"
	name = "Savage Strike"
	description = "You gain the malice of the spirits imprisoned in the weapon. You slashing and
	piercing damage gain a 5% chance to afflict bleed onto your enemies."
	
func onPickup(target : Node):
	for x in range(1, WeaponList.weapons.size()):
		if WeaponList.weapons[x].getDamageType() == "pierce" or WeaponList.weapons[x].getDamageType() == "slash":
			WeaponList.weapons[x].addChance("bleeding", 0.05)

extends Attribute
class_name USymbol

func _init() -> void:
	type = "passive"
	name = "Untainted Symbol"
	description = "Holy symbol once worn by a devout believer. Remains defiant against Hell's will.\n
	Start the run with +3 holy damage and add an extra holy attack on all melee weapons."

func onPickup(target : Node):
	WeaponList.damages['holy'] += 3
	for x in range(1, 7):
		WeaponList.weapons[x].addExtraAttack("holy")

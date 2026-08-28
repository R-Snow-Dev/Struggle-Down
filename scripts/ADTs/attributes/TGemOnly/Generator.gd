extends Attribute
class_name Generator

func _init() -> void:
	type = "onHit"
	name = "Kinetic Generator"
	damageType = "special"
	description = "Energy is neither created nor destroyed, only changed. Such is law.
	
	All weapons are set to 2 damage. For every action you take, weapon damage is doubled. Once an attack is made, the damage resets to 2. Damage is reset when actions are used up.
	
	The laws of the universe are yours to weild."

func onPickup(target : Node):
	UpgradeList.chargeable = true
	for w:Weapon in WeaponList.weapons.slice(1,-1):
		w.setAtkDam(0)
		
func effect(target: Node) -> int:
	var total = 1
	damageType = WeaponList.weapons[WeaponList.held].getDamageType()
	for x in range(1,UpgradeList.charge + 1):
		total *= 2
	UpgradeList.charge = 0
	return total

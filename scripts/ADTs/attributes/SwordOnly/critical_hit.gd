extends Attribute
class_name CriticalHit


func _init() -> void:
	type = "onHit"
	name = "Critical Sword"
	damageType = "slash"
	description = "You inherit the skills an unnamed duelist.

Deal an extra 2 slashing damage when attacking a bleeding opponent when using a sword."
func effect(target: Node) -> int:
	for e in target.getEffects():
		if e is Bleed and WeaponList.held == 1:
			return 2
	return 0

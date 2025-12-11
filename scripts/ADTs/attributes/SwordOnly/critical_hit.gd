extends Attribute
class_name CriticalHit


func _init() -> void:
	type = "onHit"
	name = "Critical Sword"
	damageType = "slash"
	description = "You inherit the skills an unnamed duelist. Deal an extra 
	2 slashing damage when attacking a bleeding opponent."
func effect(target: Node) -> int:
	if "bleeding" in target.effects and WeaponList.held == 1:
		return 2
	return 0

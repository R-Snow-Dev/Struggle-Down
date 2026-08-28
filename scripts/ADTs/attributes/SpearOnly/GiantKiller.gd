extends Attribute
class_name GiantKiller

func _init() -> void:
	type = "onHit"
	name = "Giant Killer"
	damageType = "special"
	description = "Sharpen your sticks, light your fires, hide in caves no more. Fear the Giants no longer, for now our hate can reach them.
	
	When using spears, deal special damage equal to 33% of your total spear damage when attacking bosses.
	
	Fell the troll, fell the giant, fell the titan. Noble no longer."
	
func effect(target: Node) -> int:
	if target is Boss:
		var w: Weapon = WeaponList.weapons[1]
		var damage = w.getAtkDam()
		for x in w.getExtraAttacks():
			damage += WeaponList.damages[x]
		effectDone.emit()
		return int(damage * 0.33)
	effectDone.emit()
	return 0

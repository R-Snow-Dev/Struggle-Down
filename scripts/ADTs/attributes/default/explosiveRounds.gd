extends Attribute
class_name ExplosiveRounds

func effect(target: Node) -> int:
	if WeaponList.held == 9:
		var explosion: WildDamage = preload("res://scenes/DungeonParts/explosion.tscn").instantiate()
		explosion.setDam(7)
		explosion.setType('explosive')
		EventBus.summon.emit(target, explosion)
	effectDone.emit()
	return 0

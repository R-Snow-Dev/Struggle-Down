extends Attribute
class_name Overkill

func _init() -> void:
	type = "onKill"
	name = "Overkill"
	description = "You inherit the might of a titan.
	
	Enemies explode on death."

func effect(target: Node) -> int:
	var explosion: WildDamage = preload("res://scenes/DungeonParts/explosion.tscn").instantiate()
	explosion.setDam(3 + WeaponList.damages['explosive'])
	explosion.setType('explosive')
	EventBus.summon.emit(target, explosion)
	effectDone.emit()
	return 0
	

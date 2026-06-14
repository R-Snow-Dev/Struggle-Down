extends Attribute
class_name Overkill

func _init() -> void:
	type = "onKill"
	name = "Overkill"
	description = "You inherit the might of a titan.
	
	Enemies explode on death, dealing 3 explosive damage to everything around it."

func effect(target: Node) -> int:
	var explosion: WildDamage = preload("res://scenes/DungeonParts/explosion.tscn").instantiate()
	explosion.setDam(3)
	explosion.setType('explosive')
	EventBus.summon.emit(target, explosion)
	return 0
	

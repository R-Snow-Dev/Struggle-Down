extends Attribute
class_name Overkill

var explosion = preload("res://scenes/DungeonParts/explosion.tscn")

func _init() -> void:
	type = "onKill"
	name = "Overkill"
	description = "You inherit the might of a titan.
	
	Enemies explode on death, dealing 3 explosive damage to everything around it."

func effect(target: Node) -> int:
	EventBus.summon.emit(target, explosion, 3, "explosive")
	return 0
	

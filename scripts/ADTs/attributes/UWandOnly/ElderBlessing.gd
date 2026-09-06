extends Attribute
class_name ElderBlessing


func _init() -> void:
	type = "onRoom"
	name = "Elder Blessing"
	description = "Focused explosive energy suges through you. It yearns for an outlet.
	
	Every time you enter an undiscovered room, a random enemy will be struck by a powerful explosion. Nothing will happen if the room is empty.
	
	Deliver death."

func effect(target : Node):
	var explosion: WildDamage = preload("res://scenes/DungeonParts/explosion.tscn").instantiate()
	explosion.setDam(10)
	explosion.setType('explosive')
	var guys = Overseer.getObj()
	for g in guys:
		if g is Fiend:
			EventBus.summon.emit(g,explosion)
			return 0
	return 0

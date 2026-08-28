extends Attribute
class_name Fission

func _init() -> void:
	type = "onHit"
	name = "Fission"
	description = "Split the atom.
	
	Enemies explode when hit.
	
	I am become death, destroyer of worlds."

func effect(target: Node) -> int:
	var explosion: WildDamage = preload("res://scenes/DungeonParts/explosion.tscn").instantiate()
	explosion.setDam(1 + WeaponList.damages['explosive'])
	explosion.setType('explosive')
	EventBus.summon.emit(target, explosion)
	effectDone.emit()
	return 0
	

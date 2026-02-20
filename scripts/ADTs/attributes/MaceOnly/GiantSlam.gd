extends Attribute
class_name GiantSlam

var explosion = preload("res://scenes/DungeonParts/explosion.tscn")

func _init() -> void:
	type = "onHit"
	name = "Giant's Hammer"
	description = "You inherit the might of a giant. 

Create a shockwave that deals 10% of your weapon's max damage when you hit an enemy."

func effect(target: Node) -> int:
	
	var damage = 0
	var w:Weapon = WeaponList.weapons[WeaponList.held]
	var extras = w.getExtraAttacks()
	
	damage += w.getBaseDam()
	damage += WeaponList.damages[w.getDamageType()]
	for e in extras:
		damage += WeaponList.damages[e]
	
	damage = damage * 0.1	
	
	EventBus.summon.emit(target, explosion, damage, "shockwave")
	return 0
	

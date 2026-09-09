extends Attribute
class_name GiantSlam

func _init() -> void:
	type = "onHit"
	name = "Giant's Hammer"
	damageType = "none"
	description = "You inherit the might of a giant. 

Create a shockwave that deals 10% of your weapon's max damage when you hit an enemy."

func effect(target: Node) -> int:
	
	var explosion: AOE = preload("res://scenes/Projectiles/aoe.tscn").instantiate()
	var s = preload("res://scenes/Projectiles/Sprites/sample_anim.tscn").instantiate()
	var w:Weapon
	
	var damage = 0
	if WeaponList.held > 0:
		w = WeaponList.weapons[WeaponList.held]
	else:
		w = WeaponList.weapons[1]
		
	var extras = w.getExtraAttacks()
	
	damage += w.getBaseDam()
	damage += WeaponList.damages[w.getDamageType()]
	for e in extras:
		damage += WeaponList.damages[e]
	
	damage = damage * 0.1	
	
	if damage < 1:
		damage = 1
		
	explosion.setVars(s, Vector2(3,3), Vector2(0,0))
	explosion.setDam(damage)
	explosion.setType('shockwave')
	
	EventBus.summon.emit(target, explosion)
	effectDone.emit()
	return 0
	

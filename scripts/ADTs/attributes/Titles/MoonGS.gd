extends Attribute
class_name MoonGS
var rng = RandomNumberGenerator.new()

var s = preload("res://scenes/Projectiles/Sprites/ice.tscn").instantiate()
var j: Projectile 

func effect(target: Node) -> int:
	var mag = 2
	j = WeaponList.createNewProj(s, false, Vector2(0,100), true, Color(255,255,255,0.5), 'none', 4 + mag, 'slow', 0.4 + (0.1 * mag))
	return 0

func special(target: Node) -> int:
	return 0

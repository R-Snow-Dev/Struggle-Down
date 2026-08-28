extends Attribute
class_name HandOfGod
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	var rR: RoamingReticle = preload("res://scenes/DungeonParts/roaming_reticle.tscn").instantiate()
	var sp: Node2D = preload("res://scenes/Projectiles/Sprites/Smite.tscn").instantiate()
	sp.position.y -= 8
	rR.setId(13)
	rR.setLifespan(0.75)
	rR.setSprite(sp)
	rR.setParent(self)
	Overseer.control.add_child(rR)
	return 0

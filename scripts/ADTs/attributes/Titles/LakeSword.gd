extends Attribute
class_name LakeSword
var rng = RandomNumberGenerator.new()


func effect(target: Node) -> int:
	var s = preload("res://scenes/Projectiles/Sprites/sample_anim.tscn").instantiate()
	var j = WeaponList.createNewAOE(s, Vector2(3,1), Vector2(0,0), 'special', 0, 'stun', 0.5)
	EventBus.throwEffect.emit(j)
	return 0

func special(target: Node) -> int:
	return 0

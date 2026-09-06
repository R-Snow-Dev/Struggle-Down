extends Attribute
class_name InfernalHorn
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	return 0

func special(target: Node) -> int:
	var s = preload("res://scenes/Projectiles/Sprites/sample_anim.tscn")
	var j = WeaponList.createNewAOE(s.instantiate(), Vector2(22,22), Vector2(0,0), 'fire', 0, 'burn', 1.0)
	EventBus.throwEffect.emit(j)
	EventBus.updateActions.emit(-1)
	return 0

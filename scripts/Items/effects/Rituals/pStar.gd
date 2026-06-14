extends ItemEffect
class_name PStarEffect

var mag: int
var s = preload("res://scenes/Projectiles/Sprites/sample_anim.tscn").instantiate()
var j = WeaponList.createNewAOE(s, Vector2(22,22), Vector2(0,0), 'death', 0, 'none', 0)

func _init(m: int) -> void:
	mag = m
	
func test():
	return true
	
func run():
	EventBus.throwEffect.emit(j)

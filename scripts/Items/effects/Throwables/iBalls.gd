extends ItemEffect
class_name IronBallsEffect

var mag: int
var s = preload("res://scenes/Projectiles/Sprites/iBalls.tscn").instantiate()
var j = WeaponList.createNewAOE(s, Vector2(3,1), Vector2(0,1), 'blunt', 5, 'none', 0)

func _init(m: int) -> void:
	mag = m

func hover():
	EventBus.hoverProj.emit(j)
	
func offHover():
	EventBus.offHover.emit()
	
func test():
	return true
	
func run():
	EventBus.throwEffect.emit(j)

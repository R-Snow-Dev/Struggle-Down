extends ItemEffect
class_name JavelinEffect

var mag: int
var s = preload("res://scenes/Projectiles/Sprites/javelin.tscn").instantiate()
var j = WeaponList.createNewProj(s, false, Vector2(0,100), true, Color(255,255,255,0.5), 'pierce', 5, 'none', 0.0)

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

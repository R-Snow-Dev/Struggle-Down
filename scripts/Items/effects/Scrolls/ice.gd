extends ItemEffect
class_name IceScrollEffect

var mag: int
var s = preload("res://scenes/Projectiles/Sprites/ice.tscn").instantiate()
var j: Projectile 

func _init(m: int) -> void:
	mag = m
	j = WeaponList.createNewProj(s, false, Vector2(0,100), true, Color(255,255,255,0.5), 'none', 4 + mag, 'stun', 0.4 + (0.1 * mag))

func hover():
	EventBus.hoverProj.emit(j)
	
func offHover():
	EventBus.offHover.emit()
	
func test():
	return true
	
func run():
	EventBus.throwEffect.emit(j)

extends ItemEffect
class_name MagBombEffect

var bomb: BombEntity = preload("res://scenes/entities/bomb.tscn").instantiate()
var mag: int
var s: AnimatedSprite2D = preload("res://scenes/Projectiles/Sprites/sample_anim.tscn").instantiate()

func _init(m: int) -> void:
	mag = m
	bomb.setup(s,1,'death')
	
func test():
	return true
	
func run():
	EventBus.throwEntity.emit(bomb)

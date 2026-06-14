extends ItemEffect
class_name GreekFireEffect

var trap: TrapEntity = preload("res://scenes/entities/trap.tscn").instantiate()
var mag: int
var s: AnimatedSprite2D = preload("res://scenes/Items/ConsumableSprites/Traps/gFireE.tscn").instantiate()

func _init(m: int) -> void:
	mag = m
	trap.setup(s, 3, 'fire', 'none', 0)
	
func test():
	return Overseer.getBoard().wallInFront()
	
func run():
	EventBus.throwEntity.emit(trap)

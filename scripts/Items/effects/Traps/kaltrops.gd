extends ItemEffect
class_name KaltropsEffect

var trap: TrapEntity = preload("res://scenes/entities/trap.tscn").instantiate()
var mag: int
var s: AnimatedSprite2D = preload("res://scenes/Items/ConsumableSprites/Traps/kaltropsE.tscn").instantiate()

func _init(m: int) -> void:
	mag = m
	trap.setup(s, 3, 'pierce', 'none', 0)
	
func test():
	return Overseer.getBoard().wallInFront()
	
func run():
	EventBus.throwEntity.emit(trap)

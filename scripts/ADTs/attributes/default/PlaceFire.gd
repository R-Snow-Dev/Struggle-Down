extends Attribute
class_name PlaceFire
var rng = RandomNumberGenerator.new()

var mag: int
	
func test():
	return Overseer.getBoard().wallInFront()
	
func effect(target: Node) -> int:
	var s: AnimatedSprite2D = preload("res://scenes/Items/ConsumableSprites/Traps/gFireE.tscn").instantiate()
	var trap: TrapEntity = preload("res://scenes/entities/trap.tscn").instantiate()
	trap.setup(s, 5, 'fire', 'none', 0)
	if test():
		EventBus.throwEntity.emit(trap)
	effectDone.emit()
	return 0

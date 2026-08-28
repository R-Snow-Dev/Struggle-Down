extends Attribute
class_name WrathBlessing


func _init() -> void:
	type = "onHit"
	name = "Boon of Wrath"
	damageType = 'fire'
	description = "It is unknown if the Unholy King existed before we named him. As we first witnessed the fury of an unrestful earth, perhaps it was our description of the events that bore the great Demon. 

Enemies that are hit will be bathed in flames erupting from the earth.

Beneath the ground lies Wrath."

func effect(target: Node) -> int:
	var s: AnimatedSprite2D = preload("res://scenes/Items/ConsumableSprites/Traps/gFireE.tscn").instantiate()
	var trap: TrapEntity = preload("res://scenes/entities/trap.tscn").instantiate()
	trap.setup(s, 5, 'fire', 'none', 0)
	EventBus.summon.emit(target, trap)
	return 0

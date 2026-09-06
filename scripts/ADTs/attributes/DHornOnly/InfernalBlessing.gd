extends Attribute
class_name InfernalBlessing


func _init() -> void:
	type = "onMove"
	name = "Demonic Bloodline"
	description = "Rejoice! The Unholy Legions welcome you among their ranks!
	
	Spawn fire behind you as you move.
	
	One of us."
	
func effect(target : Node):
	var trap: TrapEntity = preload("res://scenes/entities/trap.tscn").instantiate()
	var s: AnimatedSprite2D = preload("res://scenes/Items/ConsumableSprites/Traps/gFireE.tscn").instantiate()
	trap.global_position = target.global_position - Vector2(0,6)
	trap.setup(s, 3, 'fire', 'none', 0)
	await EventBus.get_tree().process_frame
	Overseer.control.add_child(trap)

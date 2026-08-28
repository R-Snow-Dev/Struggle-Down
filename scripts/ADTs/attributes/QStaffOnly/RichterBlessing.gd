extends Attribute
class_name RichterBlessing

var s = preload("res://scenes/Projectiles/Sprites/quake.tscn")

func _init() -> void:
	type = "onMove"
	name = "Richter's Steps"
	description = "Where Richter stepped, the very earth moved in response. Such is the might of a Paragon. The ashes of his ancient weapon leave with you a fascimile of this power.
	
	When your next turn begins, damaging quakes will appear where the player moved the previous turn.
	
	Your legacy left in destruction."
	
func effect(target : Node):
	var dO: DelayedAOE = preload("res://scenes/DungeonParts/delayed_aoe.tscn").instantiate()
	dO.global_position = target.global_position
	dO.setSprite(s.instantiate())
	dO.setSize(Vector2(1,1))
	dO.setType('shockwave')
	dO.setDamage(3)
	Overseer.control.add_child(dO)

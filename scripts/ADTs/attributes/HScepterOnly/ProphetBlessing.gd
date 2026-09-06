extends Attribute
class_name ProphetBlessing

func _init() -> void:
	type = "passive"
	name = "Prophet's Blessing"
	description = "The Prophet leads the way, their followers gaining enlightenment and fortune. May the eyes of the shephard guide you to glory. 
	
	Special rooms are pre-discovered and revealed on the map.
	
	Pave the future"

func onPickup(target : Node):
	Overseer.getController().revealSpecial()

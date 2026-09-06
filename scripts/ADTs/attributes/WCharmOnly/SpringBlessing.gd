extends Attribute
class_name SpringBlessing


func _init() -> void:
	type = "active"
	name = "Spring's Blessing"
	description = "The Spring Court is known to the most mischievious of the Fey. One must be wary of their blessings, as they may very well end up being just as much a curse.
	
	Click this upgrade's icon located at the bottom of the screen to randomly displace regular enemies around the dungeon room. Costs 1 action.
	Somewhere, a child is laughing."


func pressed() -> void:
	Overseer.board.shuffle()
	

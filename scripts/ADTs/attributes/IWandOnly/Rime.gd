extends Attribute
class_name Rime

func _init() -> void:
	type = "passive"
	name = "Rime"
	description = "You witness a vision of the consuming cold.
	
	You deal 3 more frost damage for all frost attacks."

func onPickup(target : Node):
	WeaponList.damages["frost"] += 3

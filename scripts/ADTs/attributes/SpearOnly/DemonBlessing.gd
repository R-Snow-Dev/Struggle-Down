extends Attribute
class_name DemonBlessing

func _init() -> void:
	type = "passive"
	name = "Blessing of Pandemonium"
	description = "When Wrath breached the unholy veil, spilling into the Middle Planes, it brought with it a dark passion. When the creatures from below followed, they found the world had come to reflect their very own. You have returned a weapon of such a creature to its rightful place, and have become entangled with its energies. Melee weapons become free of cost when under the influence of Wrath."

func onPickup(target : Node):
	pass

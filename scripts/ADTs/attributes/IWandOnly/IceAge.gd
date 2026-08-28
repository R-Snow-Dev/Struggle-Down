extends Attribute
class_name IceAge

func _init() -> void:
	type = "hitMult"
	name = "Ice Age"
	description = "It was said that in the time before even the ancients, ice and snow ruled. In the lost time, even mana itself was frozen. 
	
You deal 50% more damage to magical enemies. 

May ice consume all once more."

func effect(target : Node):
	if target.magic:
		return 1.5
	else:
		return 1

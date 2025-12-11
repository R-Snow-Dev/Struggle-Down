extends Effect
class_name Bleed

func _init():
	activeTime = 1
	name = "Bleed"

func activate(target: Fiend):
	target.getData().updateHealth(-1)

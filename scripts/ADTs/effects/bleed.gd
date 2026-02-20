extends Effect
class_name Bleed

func _init():
	activeTime = 1
	name = "Bleed"

func activate(target: Fiend):
	print("Bleeding", target)
	target.getData().updateHealth(-1)

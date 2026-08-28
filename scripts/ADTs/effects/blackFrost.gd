extends Effect
class_name BlackFrost

func _init():
	activeTime = 0
	name = "Black Frost"

func activate(target: Fiend):
	print("Killing", target)
	target.updateHealth(-9999)

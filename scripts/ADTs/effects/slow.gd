extends Effect
class_name Slow

func _init():
	activeTime = 0
	name = "Slow"

func activate(target: Fiend):
	target.getData().setActions(target.getData().getActions() - 1)
	print("Stunning", target)

extends Effect
class_name ExChain

func _init():
	activeTime = 1
	name = "Explosion Chain"

func activate(target: Fiend):
	print("Chaining", target)

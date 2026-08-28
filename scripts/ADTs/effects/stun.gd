extends Effect
class_name Stun

func _init():
	activeTime = 1
	name = "Stun"

func activate(target: Fiend):
	print("Stunning", target)

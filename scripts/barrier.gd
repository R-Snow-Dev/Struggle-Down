extends Node2D
class_name Barrier

var pos: Vector2


func setup(p: Vector2):
	# Function that must be called after creating an instance, so that its characteristics may be given to it
	# param - p: The position of the wall in Vector2 form
	pos = p
	return self

	

# While a Barrier is an object, it cannot move, so it passes instead
func move():
	pass

func draw():
	pass

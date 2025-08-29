extends Node2D

@onready var spriteController = $spriteController

func updateSprite(sprite: Node):
	# Changes the currently displayed item
	for c in spriteController.get_children():
		spriteController.remove_child(c)
	spriteController.add_child(sprite)
	
func delSprite():
	# Removes the currently displayed item
	for c in spriteController.get_children():
		spriteController.remove_child(c)

"""
Code that tells how a tile positions itself, and gives itself a texture
"""

extends StaticBody2D
class_name Tile

var pos: Vector2 # It's given position as a Vector2
var sprite: PackedScene # The sprite it will be assigned.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Setting its x, y coordinates based off of it's "pos" variable
	position.x = (pos.y-1)*16
	position.y = ((pos.x-1)*16) 
	
	# Adding a texture to it's own scene based on the "sprite" variable it was assigned
	var texture = sprite.instantiate()
	add_child(texture)

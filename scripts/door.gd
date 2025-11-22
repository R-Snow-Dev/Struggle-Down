"""
Code that tells how a tile positions itself, and gives itself a texture
"""

extends Node2D 
class_name Door

var pos: Vector2 # It's given position as a Vector2
@onready var s = $Door
@onready var area = $Door/doorArea


func _enter_tree() -> void:
	s = $Door
	area = $Door/doorArea

func relock():
	s = $Door
	area = $Door/doorArea
	s.play("relock")
	area.monitoring = false

func unlock():
	s = $Door
	area = $Door/doorArea
	s.play("unlock")
	area.monitoring = true
	
func draw():
	position.x = pos.x*16
	position.y = pos.y*16 - 8
	self.z_index = (pos.y)

func move():
	pass

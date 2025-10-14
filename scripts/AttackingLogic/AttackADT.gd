extends RefCounted
class_name Attack

"""
Super class for all attacks types in the game
"""

# variables
var dam: int
var atckr: Node

# constructor
func _init(d: int, a: Node) -> void:
	dam = d
	atckr = a

# attack function that child classes override
func attack():
	pass

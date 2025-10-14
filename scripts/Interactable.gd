extends AnimatedSprite2D

"""
Class that represents any objects that changes states when the something is on
it's tile
"""

class_name Interactable

# Variables
var pos: Vector2 
@onready var behavior = $Behavior # Node that dictates what the ibject does when interacted with

func setup(p: Vector2):
	pos = p

func _on_area_2d_area_entered(_area: Area2D) -> void:
	# Performs it's "interacted" behavior when touched
	play("interact")
	behavior.interact()
	print("Interacted")
	
func move():
	pass

func draw():
	# code that converts the Vector2 position data into on-screen coordinates
	position.x = pos.x*16
	position.y = pos.y*16 - 6
	self.z_index = (pos.y + 1)
	
func getState():
	# Gets the state of the interactable
	behavior = $Behavior
	return behavior.getState()	
	
func _on_area_2d_area_exited(_area: Area2D) -> void:
	# Resets when an object leaves it's tile
	play("reset")
	behavior.reset()

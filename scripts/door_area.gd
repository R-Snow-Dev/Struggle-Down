"""
Area2D that defines where a doorway is
"""

extends Area2D

# It's postion that will be translated into on-screen coordinates
var pos: Vector2

# Code that sets the position of the door to a desired location on spawn in
func _ready() -> void:
	position.x = (pos.y-1)*16
	position.y = ((pos.x-1)*16) + 8

func _on_area_entered(area: Area2D) -> void:
	# Function that detects when the player has entered the doorway, and sends out a signal to the game controller to let it know
	EventBus.on_door.emit(true)
	
func _on_area_exited(area: Area2D) -> void:
	# Function that detects when the player has exited the doorway, and sends out a signal to the game controller to let it know
	EventBus.on_door.emit(false)
 

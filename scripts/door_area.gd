"""
Area2D that defines where a doorway is
"""

extends Area2D

# It's postion that will be translated into on-screen coordinates

# Code that sets the position of the door to a desired location on spawn in

func _on_area_entered(_area: Area2D) -> void:
	# Function that detects when the player has entered the doorway, and sends out a signal to the game controller to let it know
	EventBus.on_door.emit(true)
	print("Fella Found")

	
func _on_area_exited(_area: Area2D) -> void:
	# Function that detects when the player has exited the doorway, and sends out a signal to the game controller to let it know
	EventBus.on_door.emit(false)
 

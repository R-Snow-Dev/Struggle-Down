"""
This node acts as a stand in for the camera's position in the scene
"""

extends Node2D

# Runs the first time the node is activated in the scene
func _ready() -> void:
	# Defaults the camera to 0,0
	position.x = 0
	position.y = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Sets the camera to the center of the game board, regardless of the dimentions
	
	var controller = %Gamecontroller
	# Gets the center coordinates of the gameboard depending on it's grid dimentions, and sets the appropriate
	# x, y position of the camera to center the board in the screen
	position.x = ((controller.gridSize.x-1) / 2) * 16
	position.y = (((controller.gridSize.y-1) / 2) * 16) + 8


"""
Code that contains position info and movement functions for the 
plater character

The player character will be carried over in every game board, so there is no reason
to convert it into a class
"""
extends CharacterBody2D

# Initialises a Vector2 that will store the position data that is represented on the gameboard
var pos: Vector2
var actionsAvailable: int


func setPos(newPos: Vector2):
	# Function to artificially change the current position of the player character
	pos = newPos

func setActionsAvailable(actions: int):
	# Function to artificially set the number of available actions for the player
	actionsAvailable = actions

func moveUp():
	# Code to move the player character up
	pos.y -= 1

func moveDown():
	# Code to move the player character down
	pos.y += 1

func moveLeft():
	# Code to move the player character left
	pos.x -= 1

func moveRight():
	# Code to move the player character right
	pos.x += 1

func draw():
	# code that converts the Vector2 position data into on-screen coordinates
	position.x = pos.x*16
	position.y = pos.y*16
	self.z_index = (pos.y + 1)
	

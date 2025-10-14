extends Sprite2D
class_name Pushable

"""
Class that represents any object that can be moved by the player
"""

# Variables
var pos: Vector2 
var startPos: Vector2

# Setup function
func setup(p: Vector2):
	pos = p
	startPos = p
	
func move():
	pass

# Resets its position to its initial position (For reseting puzzles)
func reset():
	pos = startPos

func draw():
	# code that converts the Vector2 position data into on-screen coordinates
	position.x = pos.x*16
	position.y = pos.y*16 - 6
	self.z_index = (pos.y + 1)
	
func moveUp():
	# Code to move the pushable object right
	pos.y -= 1

func moveDown():
	# Code to move the pushable object right
	pos.y += 1

func moveLeft():
	# Code to move the pushable object right
	pos.x -= 1

func moveRight():
	# Code to move the pushable object right
	pos.x += 1

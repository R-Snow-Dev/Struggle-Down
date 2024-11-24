
"""
Code for the gameBoard class

Used in the game controller too keep track of which screen the 
player is currently on, and what the board actually looks like

The game controller keeps a 2D array of this class, each containing a unique board state so that
the player can leave and return to disconnected board states
"""

extends Node2D
class_name gameBoard

# Preloads the instance of this scene so that it can be used
const board: PackedScene = preload("res://scenes/game_board.tscn")

# Variables that will be defined by the constructor
var grid = []
var empty: Object = Object.new()
var width: int
var height: int
var player: Object
var enemies: Array
var walls: Array


static func gameBoard(width: int, height: int, player: Object):
	# Constructor function
	# param - width: the width of the desired gameboard. Must be positive
	# param - height: The hight of the desired gameboard. Must be positive.
	# param - player: Path to the player scene
	var new_board: gameBoard = board.instantiate() 
	new_board.width = width
	new_board.height = height
	new_board.player = player
	return new_board

func loadBoard():
	# Generates the current board as a 2D array based on given data
	for i in height:
		grid.append([])
		for j in width:
			grid[i].append(empty)
	
	# Default the player character to 0,0 if they are out of bounds
	if player.pos.x > width-1 or player.pos.y > height-1:
		player.setPos(Vector2(0,0))
	else: grid[player.pos.y][player.pos.x] = player
	
	# display all objects to the screen
	display()



func display():
	# Parses through the 2D array representation and calls each object on the 
	# board to show themselves in their corresponding locations on-screnn
	for y in grid:
		for x in y:
			if x != empty:
				x.draw()


func checkInputs():
	
	# This function simply checks for each individual input and then correctly handles each case
	# Definitly not the best way to do this, but it works
	
	# If up is pressed and you have the available resources to do it, move up
	if Input.is_action_just_pressed("move_up"):
		if player.pos.y > 0 and player.actionsAvailable > 0: # Did the player reach the edge of the map? Does it have actions to spend?
			player.actionsAvailable -= 1
			player.moveUp()
			# relaods the board once movement is complete
			loadBoard()
			
	# If down is pressed, and you have the available resources to do it, move down
	if Input.is_action_just_pressed("move_down"):
		if player.pos.y < (height - 1) and player.actionsAvailable > 0: 
			player.actionsAvailable -= 1
			player.moveDown()
			# relaods the board once movement is complete
			loadBoard()
	
	# etc...
	if Input.is_action_just_pressed("move_left"):
		if player.pos.x > 0 and player.actionsAvailable > 0:
			player.actionsAvailable -= 1
			player.moveLeft()
			# relaods the board once movement is complete
			loadBoard()
	
	# etc...
	if Input.is_action_just_pressed("move_right"):
		if player.pos.x < (width-1) and player.actionsAvailable > 0:
			player.actionsAvailable -= 1
			player.moveRight()
			# relaods the board once movement is complete
			loadBoard()
	
	

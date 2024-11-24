
"""
Main script that runs and keeps track of all classes, runs all necessary functions from the classes,
keeps track of the gamestate (Player HP, level, floor, items, stats, etc) and loads data from save data

The script that runs the game essentially. If something needs doing, it will be done in here.
The big boss.
"""
extends Node


# Basic data is loaded
var level = 1 # current level
var floor = 1# current floor (sub level essentially)
var gridSize = Vector2(11,11)# Dimentions of the current floor
var boards: gameBoard # 2D array of boards representing the floor map\
var floorScene = preload("res://scenes/floor.tscn").instantiate()

func drawBoard():
	# Function that checks to see if a dungeon floor is already rendered, 
	# removes it if one is, and generates a new one
	
	# Checking to see if a floor is already present
	if floorScene.is_inside_tree():
		# Removing the floor from the scene
		remove_child(floorScene)
	
	# Setting the floor type to teh appropriate level
	floorScene.spriteType = level
	# Creating a new floor
	add_child(floorScene) 
	
		

func setGrid(grid: Vector2):
	# Function that allows you to change the desired grid dimentions 
	# param - grid: A Vector2 representing the desired dimentions
	gridSize = grid

func _ready() -> void:
	# Excecutes code on startup
	var player = $Player # gets the path for the player scene
	player.setPos(Vector2(int(gridSize.x)/2 ,int(gridSize.y-1) / 2)) # Set player to the center of the board
	player.setActionsAvailable(100) # Sets available actions to a default number
	boards = gameBoard.gameBoard(gridSize.x, gridSize.y, player)# creates the gameboards
	floorScene.grid = gridSize 
	boards.loadBoard() # generates the gameboard and displays the objects in it to the screen for the first time

func _process(delta: float) -> void:
	# Ececutes code every frame
	boards.checkInputs() # checks to see if the user performs an action
	drawBoard() # Generates the dungeon floor
	

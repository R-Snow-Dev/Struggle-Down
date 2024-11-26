
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
var boards: Array # 2D array of boards representing the floor map\
var floorScene = preload("res://scenes/floor.tscn").instantiate()
var map = preload("res://scenes/map.tscn").instantiate()
var mapPos : Vector2
var pPos: Vector2
var rng = RandomNumberGenerator.new()
var door: bool

func drawBoard():
	print("yeah")
	# Function that checks to see if a dungeon floor is already rendered, 
	# removes it if one is, and generates a new one
	
	# Checking to see if a floor is already present
	if floorScene.is_inside_tree():
		# Removing the floor from the scene
		remove_child(floorScene)
	
	# Setting the floor type to the appropriate level
	floorScene.spriteType = level
	# Creating a new floor
	floorScene.load()
	add_child(floorScene) 
	

# Load the level from the map, and load the first room
func loadLevel():
	var player = %Player # gets the path for the player scene
	add_child(map)
	mapPos = map.startPos
	boards = map.mapGrid
	floorScene.mapPos = mapPos
	floorScene.path = map.path
	player.setPos(pPos) # Set player to the center of the board
	player.setActionsAvailable(10000) # Sets available actions to a default number
	for x in map.path:
		gridSize = Vector2(rng.randi_range(3,11), rng.randi_range(3,11))
		boards[x.x][x.y].append(gameBoard.gameBoard(gridSize.x, gridSize.y, player))# creates the gameboards
	gridSize = Vector2(boards[mapPos.x][mapPos.y][0].width, boards[mapPos.x][mapPos.y][0].height)
	pPos = Vector2(int(gridSize.x)/2 ,int(gridSize.y-1) / 2) # Sets the default player position to the center of the map
	floorScene.grid = gridSize 
	boards[mapPos.x][mapPos.y][0].loadBoard() # generates the gameboard and displays the objects in it to the screen for the first time
	drawBoard() # Generates the dungeon floor
	
	
	
func setGrid(grid: Vector2):
	# Function that allows you to change the desired grid dimentions 
	# param - grid: A Vector2 representing the desired dimentions
	gridSize = grid

func _ready() -> void:
	# Connect all signals to approprate functions
	EventBus.changeRooms.connect(_changeRooms)
	EventBus.on_door.connect(_on_door)
	# Excecutes code on startup
	var player = %Player # gets the path for the player scene
	loadLevel() # Loads the level up
	
func _on_door(on: bool):
	# Function that recieves a signal from the on_door signal
	# Param - on: The booelan recieved from the signal
	
	# Sets the door boolean to on
	door = on


func _changeRooms(changePos: Vector2, newPos: String):
	# Function that handles the action of switching to a new room after recieving the changeRoom signal
	# Param - changePos: A Vector2 recieved from the signal that tells how muxh the map position will change in both dimentions
	# Param - newPos: A String recieved from the signal that will be translated into a new starting position for the player in the new room
	
	var player = %Player # gets the path for the player scene
	
	# Changes the map position by the changePos Vector2
	mapPos = mapPos + changePos
	
	# newPos intepreter
	if newPos == "top": # if new pos is "top, set the player position to the top of the new room
		pPos = Vector2((int(boards[mapPos.x][mapPos.y][0].width)-1)/2, 0)
	elif newPos == "bottom": # etc
		pPos = Vector2((int(boards[mapPos.x][mapPos.y][0].width)-1)/2, int(boards[mapPos.x][mapPos.y][0].height-1))
	elif newPos == "right": # etc
		pPos = Vector2(int(boards[mapPos.x][mapPos.y][0].width-1), int(boards[mapPos.x][mapPos.y][0].height)/2)
	elif newPos == "left":# etc
		pPos = Vector2(0, int(boards[mapPos.x][mapPos.y][0].height)/2)
	else:
		pPos = Vector2(0,0) # Defaults position to 0,0 if an invalid newPos is given
	
	# Sets the current gridSize to the new room's dimentions
	gridSize = Vector2(boards[mapPos.x][mapPos.y][0].width, boards[mapPos.x][mapPos.y][0].height)
	
	player.setPos(pPos) # Sets player position to the newly aquired starting position
	player.setActionsAvailable(10000) # Sets available actions to a default number
	floorScene.mapPos = mapPos # gives floorScene the new map position to load new doorways
	floorScene.grid = gridSize  # Sets floorScene's grid size to the new grid size
	boards[mapPos.x][mapPos.y][0].loadBoard() # generates the gameboard and displays the objects in it to the screen for the first time
	drawBoard() # Generates the dungeon floor

func _process(delta: float) -> void:
	# Ececutes code every frame
	boards[mapPos.x][mapPos.y][0].door = door
	boards[mapPos.x][mapPos.y][0].checkInputs() # checks to see if the user performs an action
	

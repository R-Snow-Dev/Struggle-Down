
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
var oppControl = preload("res://scenes/opp_controller.tscn").instantiate()
var map = preload("res://scenes/map.tscn").instantiate()
var fiend = preload("res://scenes/Opps/fiend.tscn")
var mapPos : Vector2
var pPos: Vector2
var rng = RandomNumberGenerator.new()
var door: bool

func drawBoard():
	# Function that checks to see if a dungeon floor is already rendered, 
	# removes it if one is, and generates a new one
	
	# Checking to see if a floor is already present
	if floorScene.is_inside_tree():
		# Removing the floor from the scene
		remove_child(floorScene)
		
	
	if oppControl.get_child_count() > 0:
		for i in oppControl.get_children():
			oppControl.remove_child(i)
	
	# Setting the floor type to the appropriate level
	floorScene.spriteType = level
	# Creating a new floor
	floorScene.load()
	add_child(floorScene) 
	# Adding enemies/walls/items to the floor
	if boards[mapPos.x][mapPos.y][0].fiends != []:
		for f in boards[mapPos.x][mapPos.y][0].fiends:
			floorScene.add_child(f[0])

	


func loadObjects(grid: Vector2):
	# Function that genrates obstacles in a given room. Starts with walls, then fiends, then items
	# param -  grid: A Vector2 containing the dimensions of the room where the obstacles will be generated
	# Returns: An array of objects to be added to the floor, along with their positions
	
	# The list to be returned
	var fiends = []
	
	# Coordinates on the floor that are available to spawn an object
	var gridCoords = []
	
	# Adds all open tiles that are not door tiles gridCoords
	for i in grid.x:
		for j in grid.y:
			# Checks to see if the current tile is not a possible door tile
			if (i == 0 and j == int(grid.y-1)/2) or (i == grid.x-1 and j == int(grid.y-1)/2) or (i == int(grid.x)/2 and j == 0) or (i == int(grid.x)/2 and j == grid.y-1):
				pass
			else:
				gridCoords.append([i,j])
				
	# The length of gridCoords immediatly after all tile coordinates are appended
	var availableCoords = len(gridCoords)
	
	#Print info to the console
	print("XXX")
	print(gridCoords)
	print(availableCoords)
	
	# Checks all avaialable spawn tiles for a percent chance to spawn a fiend
	for i in range(0, availableCoords):
		if rng.randf() > (1.01 - (0.05*sqrt((level*level)+((floor/5)*(floor/5))))): # Chance gets higher as tower level increases
			var chosenFiend = fiend.instantiate()
			var chosen = rng.randi_range(0, len(gridCoords) - 1) # Picks an available spawn tiles
			chosenFiend.setup(Vector2(gridCoords[chosen][0], gridCoords[chosen][1]), preload("res://scenes/Opps/slime.tscn"), 10) # Adds all relevant information to the newly spawned fiend
			fiends.append([chosenFiend, chosenFiend.pos]) # Adds the new fiend, along with it's position, to the fiends array, which will be returned at the end
			# Print info to the console
			print("Updated")
			print(gridCoords[chosen])
			gridCoords.remove_at(chosen) # Removes the location the fiend spawned at from the gridCoords array, so ot cannot be chosen again
			# Print info to the console
			print(gridCoords)
			print("GUG")
	# Returns the fiends array, containing the instances of the spawned fiends in the room, along with tier positions
	return fiends
			

func genMapData(path: Array):
	# Genrates the map data for each noew floor, including their dimensions, and the obstacles they have
	# param - path: An array of coordinates correlating to every position of a room on the map
	
	var player = %Player # gets the path for the player scene
	
	# Repeat this for every room in the map
	for x in path:
		# List of fiends is initialised
		var fiendList: Array
		# Checks to see if the floor being generated is the starting floor or not
		if x != map.startPos: # If it isn't randomly generate unique data for the floor
			gridSize = Vector2(rng.randi_range(3,11), rng.randi_range(3,11))
			fiendList = loadObjects(gridSize)
			print(fiendList)
		else: # If it is the starting position, generate a 5x5 room with no obstacles
			gridSize = Vector2(5,5)
			fiendList = []
		boards[x.x][x.y].append(gameBoard.gameBoard(gridSize.x, gridSize.y, player, fiendList)) # Appends the genrated board to the "boards" array, representing the floor map

# Load the level from the map, and load the first room
func loadLevel():
	var player = %Player # gets the path for the player scene
	add_child(map)
	mapPos = map.startPos
	boards = map.mapGrid
	floorScene.mapPos = mapPos
	floorScene.path = map.path
	player.setActionsAvailable(10000) # Sets available actions to a default number
	# creates the gameboards
	genMapData(map.path)
	gridSize = Vector2(boards[mapPos.x][mapPos.y][0].width, boards[mapPos.x][mapPos.y][0].height)
	pPos = Vector2(int(gridSize.x)/2 ,int(gridSize.y) / 2) # Sets the default player position to the center of the map
	player.setPos(pPos) # Set player to the center of the board
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
	# Param - changePos: A Vector2 recieved from the signal that tells how much the map position will change in both dimensions
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
	

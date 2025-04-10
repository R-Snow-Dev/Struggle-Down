
"""
Code for the gameBoard class

Used in the game controller too keep track of which screen the 
player is currently on, and what the board actually looks like

The game controller keeps a 2D array of this class, each containing a unique board state so that
the player can leave and return to disconnected board states
"""

extends Node2D
class_name gameBoard


# Variables that will be defined by the constructor
var grid: Array
var objects: Array
var width: int
var height: int
var player: Object
var walls: Array
var door: bool

func _init(w: int, h: int, p: Object, o: Array):
	# Constructor function
	# param - width: the width of the desired gameboard. Must be positive
	# param - height: The hight of the desired gameboard. Must be positive.
	# param - player: Path to the player scene

	grid = []
	width = w
	height = h
	player = p
	door = true
	objects = o
	EventBus.object_ded.connect(_object_ded)
	

func _object_ded(object: Object):
	var index = objects.find(object)
	objects.remove_at(index)
	object.queue_free()
	checkInputs()


func loadBoard():
	# Generates the current board as a 2D array based on given data
	
	grid = []
	
	for i in height:
		grid.append([])
		for j in width:
			grid[i].append([])
	
	# Add enemies to the board
	if objects != []:
		for f in objects:
			grid[f.pos.y][f.pos.x] = f
	
	# Default the player character to 0,0 if they are out of bounds 
	grid[player.pos.y][player.pos.x] = player
	
	# display all objects to the screen
	display()


func display():
	# Parses through the 2D array representation and calls each object on the 
	# board to show themselves in their corresponding locations on-screnn
	for y in grid:
		for x in y:
			if x is Object:
				x.draw()

func fiendsTurn():
	# This function calls all monsters to act after the player has used up all their actions. If there are no monsters on the 
	# board, the player will emmidiatly regain their actions. If not, every monster will be called to take their turns, and only afterwards does the player
	# regain the ability to take another action
	
	var fien = 0 # default monster count is 0
	
	# Iterate through the game board array
	for x in objects:
		if x is Fiend or x is Boss:
			fien += 1
				
	if fien < 1: # If the fiend counter remains at 0, then immediatly return the players actions to them.
		player.setActionsAvailable(2)
	else: # If not, call all enemies on the floor to take their actions
		EventBus.fiend_phase.emit(fien) # Tells the game controller that it is not the enemy's turn to take actions
		for y in objects:
			if y is Fiend or y is Boss:
				loadBoard()
				y.move(grid, player.pos)
				loadBoard()
		

func checkInputs():

	# This function simply checks for each individual input and then correctly handles each case
	# Definitly not the best way to do this, but it works
	
	# If up is pressed and you have the available resources to do it, move up
	
	if Input.is_action_just_pressed("move_up"):
		loadBoard()
		if player.actionsAvailable > 0: #  Does the player have have actions to spend?
			if player.pos.y > 0: # Did the player reach the edge of the map?
				if grid[player.pos.y-1][player.pos.x] is not Wall and grid[player.pos.y-1][player.pos.x] is not Fiend:# Is the player walking into a spawned wall or enemy?
					EventBus.updateActions.emit(-1)
					player.moveUp()
					# relaods the board once movement is complete
					loadBoard()
			elif door == true: # If the player is in a doorway at the top of the map
				EventBus.changeRooms.emit(Vector2(0,1), "bottom") # change rooms upwards
				
			
	# If down is pressed, and you have the available resources to do it, move down
	if Input.is_action_just_pressed("move_down"):
		loadBoard()
		if player.actionsAvailable > 0:  #  Does the player have have actions to spend?
			if player.pos.y < (height - 1):# Did the player reach the edge of the map? 
				if grid[player.pos.y+1][player.pos.x] is not Wall and grid[player.pos.y+1][player.pos.x] is not Fiend: # Is the player walking into a spawned wall or enemy?
					EventBus.updateActions.emit(-1)
					player.moveDown()
					# relaods the board once movement is complete
					loadBoard()
			elif door == true: # If the player is in a doorway at the bottom of the map
				EventBus.changeRooms.emit(Vector2(0,-1), "top")# change rooms downwards
		
	
	# etc...
	if Input.is_action_just_pressed("move_left"):
		loadBoard()
		if player.actionsAvailable > 0: #  Does the player have have actions to spend?
			if player.pos.x > 0: # Did the player reach the edge of the map?
				if grid[player.pos.y][player.pos.x-1] is not Wall and grid[player.pos.y][player.pos.x-1] is not Fiend:# Is the player walking into a spawned wall or enemy?
					EventBus.updateActions.emit(-1)
					player.moveLeft()
					# relaods the board once movement is complete
					loadBoard()
			elif door == true: # If the player is in a doorway at the left of the map
				EventBus.changeRooms.emit(Vector2(-1,0), "right")# change rooms to the left
			
	
	# etc...
	if Input.is_action_just_pressed("move_right"):
		loadBoard()
		if player.actionsAvailable > 0: #  Does the player have have actions to spend?
			if player.pos.x < (width-1): # Did the player reach the edge of the map?
				if grid[player.pos.y][player.pos.x+1] is not Wall and grid[player.pos.y][player.pos.x+1] is not Fiend: # Is the player walking into a spawned wall or enemy?
					EventBus.updateActions.emit(-1)
					player.moveRight()
					# relaods the board once movement is complete
					loadBoard()
			elif door == true: # If the player is in a doorway at the right of the map
				EventBus.changeRooms.emit(Vector2(1,0), "left")# change rooms to the right
				

	
	

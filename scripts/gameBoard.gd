
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
var barriers = preload("res://scenes/Tiles/barrier.tscn")
var data: Dictionary
var doorData: Array
var doors: Array = [[],[],[],[]]
var type: int
var unloaded = true
var firstDoor = -1
var lockedDoors = false
var button = -1
var tempDead: Array = []
var solved: bool = false

func findID(obj, list:Array):
	# Helper function that replaces the "find" method for arrays
	for n in range(0, list.size()):
		if list[n] == obj:
			return n
	return -1

func lockDoors():
	# Lock the doors
	for n in range(0,4):
		if doors[n] is Door and n+1 != firstDoor:
			doors[n].relock()
			
func unlockDoors():
	# Unlock the doors
	for n in range(0,4):
		if doors[n] is Door:
			doors[n].unlock()

func _init(w: int, h: int, p: Object, o: Array, dD: Array, t: int):
	# Constructor function
	# param - width: the width of the desired gameboard. Must be positive
	# param - height: The hight of the desired gameboard. Must be positive.
	# param - player: Path to the player scene

	grid = []
	width = w
	height = h
	player = p
	door = false
	objects = o
	doorData = dD
	type = t
	

func getGrid():
	# Returns the current grid of the game board
	return grid

func loadDoors():
	# Function that loads doors onto the board based on the doorMatrix of the 
	# floor
	
	for i in doorData: #Loop through every coordinate pair in the doorData array
		
		# Depending on the value of the door, place it in it's respective spot
		if i == 3:
			var t = preload("res://scenes/Tiles/door_up.tscn").instantiate()
			t.pos = Vector2((width-1)/2, height-1)
			doors[i-1] = t
				
		elif i == 1:
			var t = preload("res://scenes/Tiles/door_down.tscn").instantiate()
			t.pos = Vector2((width-1)/2,0)
			doors[i-1] = t
				
		elif i == 2:
			var t = preload("res://scenes/Tiles/door_r.tscn").instantiate()
			t.pos = Vector2(width-1, (height)/2)
			doors[i-1] = t
			
		elif i == 4:
			var t = preload("res://scenes/Tiles/door_l.tscn").instantiate()
			t.pos = Vector2(0, (height)/2)
			doors[i-1] = t
	# Add the doors onto the grid, and add them into the objects array for later use
	for d in doors:
		if d is Door:
			for x in grid[d.pos.y][d.pos.x]: # Delete any objects sharing the door's tile
				objects.remove_at(objects.find(x))
			grid[d.pos.y][d.pos.x] = []
			objects.append(d)
			grid[d.pos.y][d.pos.x].append(d)
			
	# Check to see if there are any buttons in the room
	for o in objects:
		if o is Interactable:
			button = o
	
	# This boolean tells the board whether or not the room has been loaded once already
	# as this function should only be called on the first rendering of the floor
	unloaded = false

func loadGrid():
	# Function that updates the grid
	grid = []
	for i in height:
		grid.append([])
		for j in width:
			grid[i].append([])
			
	# Add enemies to the board
	if objects != []:
		for f in objects:
			if f is Boss:
				for i in range(0,f.size):
					for j in range(0,f.size):
						grid[f.pos.y + i][f.pos.x + j].append(barriers.instantiate())
				grid[f.pos.y][f.pos.x].append(f)
			else:
				grid[f.pos.y][f.pos.x].append(f)
	
	display()

func object_ded(object: Object):
	# Delete an object from the board, unless it's a puzzle, 
	# in which case temporarily remove it
	var index = findID(object, objects)
	if index != -1:
		objects.remove_at(index)
		if type!=1:
			tempDead.append(object)
			object.reset()
			object.visible = false
		else:
			object.queue_free()
		loadGrid()
	if type == 1:
		tempDead = []


func loadBoard():
	# Generates the current board as a 2D array based on given data
	loadGrid()
	if unloaded:
		loadDoors()
		
	
	# Default the player character to 0,0 if they are out of bounds 
	if player.pos.x < 0 or player.pos.x >= width or player.pos.y < 0 or player.pos.y >= height:
		player.pos = Vector2(0,0)
	grid[player.pos.y][player.pos.x].append(player)
	
	# Locks the doors if the situation requires it
	if lockedDoors:
		lockDoors()
	else:
		unlockDoors()
	
	# display all objects to the screen
	display()

func heal():
	# Heals all enemies to full whenever entering the room
	for x in objects:
		if x is Fiend or x is Boss:
			if x is Fiend:
				x.getData().setHealth(x.getData().getTotHealth())
			else:
				x.health = x.totHP

func reset():
	# If the board is a puzzle, and it hasn't been solved, 
	# reset all elements to their default states when the room is entered
	checkInputs()
	if !solved:
		for o in objects:
			if o is Pushable:
				o.reset()
		if tempDead.size()>0:		
			for o in tempDead:
				o.visible = true
				objects.append(o)
	loadGrid()
		

func display():
	# Parses through the 2D array representation and calls each object on the 
	# board to show themselves in their corresponding locations on-screnn
	for y in grid:
		for x in y:
			for e in x:
				if e is Object:
					e.draw()
	EventBus.unpause.emit()

func fiendsTurn(pActions: float):
	# This function calls all monsters to act after the player has used up all their actions. If there are no monsters on the 
	# board, the player will emmidiatly regain their actions. If not, every monster will be called to take their turns, and only afterwards does the player
	# regain the ability to take another action
	EventBus.pause.emit()
	if objects.size() > 0:
		for y in objects:
			if y is Fiend or y is Boss:
				loadBoard()
				y.restoreActions()
				y.move(self, player)
				loadBoard()
				await EventBus.doneAttacking
	player.setActionsAvailable(pActions)
	EventBus.fiend_phase.emit()
	EventBus.unpause.emit()

		
func checkPush(obj: Pushable, dir: Vector2):
	# Checks to see if a "Pushable" object can be pushed into
	# a tile based on it's direction
	if dir.x == 0:
		if obj.pos.y > 0 and obj.pos.y < height-1:
			var thang = grid[obj.pos.y + dir.y][obj.pos.x + dir.x]
			if thang.size() < 2:
				if thang.size() < 1:
					return true
				elif thang[0] is Interactable:
					return true
				else:
					return false
	elif dir.y == 0:
		if obj.pos.x > 0 and obj.pos.x < width-1:
			var thang = grid[obj.pos.y + dir.y][obj.pos.x + dir.x]
			if thang.size() < 2:
				if thang.size() < 1:
					return true
				elif thang[0] is Interactable:
					return true
				else:
					return false
	return false

func updateOnDoor(d: bool):
	# Updates to whether or not the player is on a door tile
	door = d

func checkPassable(obj):
	# Checks to see if a a player can move onto a tile or not
	if obj is Item or obj is Interactable or obj is Ladder or obj is Door:
		return true
	return false

func checkInputs():
	# This function simply checks for each individual input and then correctly handles each case
	# Definitly not the best way to do this, but it works
	
	# Check to see if the room has a button that unlocks/locks doors
	if button is Interactable:
		# If so, set the doors to either locked or unlocked. depending on
		# Whether or not the button is pressed
		lockedDoors = !button.getState()
	else:
		lockedDoors = false
		
	if lockedDoors:
		lockDoors()
	else:
		unlockDoors()
	
	# If up is pressed and you have the available resources to do it, move up
	
	if Input.is_action_just_pressed("move_up"):
		loadBoard()
		if player.actionsAvailable > 0: #  Does the player have have actions to spend?
			if player.pos.y > 0: # Did the player reach the edge of the map?
				if grid[player.pos.y-1][player.pos.x].size() < 2:					
					if grid[player.pos.y-1][player.pos.x].size() < 1:				
						EventBus.updateActions.emit(-1)
						player.moveUp()
						# relaods the board once movement is complete
						EventBus.pause.emit()
						loadBoard()
					elif grid[player.pos.y-1][player.pos.x][0] is Pushable:
						if checkPush(grid[player.pos.y-1][player.pos.x][0], Vector2(0,-1)):
							EventBus.updateActions.emit(-1)
							grid[player.pos.y-1][player.pos.x][0].moveUp()
							player.moveUp()
							# relaods the board once movement is complete
							EventBus.pause.emit()
							loadBoard()
					elif checkPassable(grid[player.pos.y-1][player.pos.x][0]):
						EventBus.updateActions.emit(-1)
						player.moveUp()
						# relaods the board once movement is complete
						EventBus.pause.emit()
						loadBoard()
			elif door == true: # If the player is in a doorway at the top of the map
				if not lockedDoors:
					solved = true
				EventBus.changeRooms.emit(Vector2(0,1), 3) # change rooms upwards
				
			
	# If down is pressed, and you have the available resources to do it, move down
	if Input.is_action_just_pressed("move_down"):
		loadBoard()
		if player.actionsAvailable > 0:  #  Does the player have have actions to spend?
			if player.pos.y < (height - 1):# Did the player reach the edge of the map? 
				if	grid[player.pos.y+1][player.pos.x].size() < 2: 
					if grid[player.pos.y+1][player.pos.x].size() < 1:				
						EventBus.updateActions.emit(-1)
						player.moveDown()
						# relaods the board once movement is complete
						EventBus.pause.emit()
						loadBoard()
					elif grid[player.pos.y+1][player.pos.x][0] is Pushable:
						if checkPush(grid[player.pos.y+1][player.pos.x][0], Vector2(0, 1)):
							EventBus.updateActions.emit(-1)
							grid[player.pos.y+1][player.pos.x][0].moveDown()
							player.moveDown()
							# relaods the board once movement is complete
							EventBus.pause.emit()
							loadBoard()
					elif checkPassable(grid[player.pos.y+1][player.pos.x][0]):
						EventBus.updateActions.emit(-1)
						player.moveDown()
						# relaods the board once movement is complete
						EventBus.pause.emit()
						loadBoard()
			elif door == true: # If the player is in a doorway at the bottom of the map
				if not lockedDoors:
					solved = true
				EventBus.changeRooms.emit(Vector2(0,-1), 1)# change rooms downwards
		
	
	# etc...
	if Input.is_action_just_pressed("move_left"):
		print(door)
		loadBoard()
		if player.actionsAvailable > 0: #  Does the player have have actions to spend?
			if player.pos.x > 0: # Did the player reach the edge of the map?
				if grid[player.pos.y][player.pos.x-1].size() < 2:					
					if grid[player.pos.y][player.pos.x-1].size() < 1:				
						EventBus.updateActions.emit(-1)
						player.moveLeft()
						# relaods the board once movement is complete
						EventBus.pause.emit()
						loadBoard()
					elif grid[player.pos.y][player.pos.x-1][0] is Pushable:
						print("That guy is pretty Pushable!")
						if checkPush(grid[player.pos.y][player.pos.x-1][0], Vector2(-1,0)):
							EventBus.updateActions.emit(-1)
							grid[player.pos.y][player.pos.x-1][0].moveLeft()
							player.moveLeft()
							# relaods the board once movement is complete
							EventBus.pause.emit()
							loadBoard()
					elif checkPassable(grid[player.pos.y][player.pos.x-1][0]):
						EventBus.updateActions.emit(-1)
						player.moveLeft()
						# relaods the board once movement is complete
						EventBus.pause.emit()
						loadBoard()
			elif door == true: # If the player is in a doorway at the left of the map
				if not lockedDoors:
					solved = true
				EventBus.changeRooms.emit(Vector2(-1,0), 2)# change rooms to the left
			
	
	# etc...
	if Input.is_action_just_pressed("move_right"):
		loadBoard()
		if player.actionsAvailable > 0: #  Does the player have have actions to spend?
			if player.pos.x < (width-1): # Did the player reach the edge of the map?
				if grid[player.pos.y][player.pos.x+1].size() < 2:
					if grid[player.pos.y][player.pos.x+1].size() < 1:				
						EventBus.updateActions.emit(-1)
						player.moveRight()
						# relaods the board once movement is complete
						EventBus.pause.emit()
						loadBoard()
					elif grid[player.pos.y][player.pos.x+1][0] is Pushable:
						if checkPush(grid[player.pos.y][player.pos.x+1][0], Vector2(1,0)):
							EventBus.updateActions.emit(-1)
							grid[player.pos.y][player.pos.x+1][0].moveRight()
							player.moveRight()
							# relaods the board once movement is complete
							EventBus.pause.emit()
							loadBoard()
					elif checkPassable(grid[player.pos.y][player.pos.x+1][0]):
						EventBus.updateActions.emit(-1)
						player.moveRight()
						# relaods the board once movement is complete
						EventBus.pause.emit()
						loadBoard()
			elif door == true: # If the player is in a doorway at the right of the map
				if not lockedDoors:
					solved = true
				EventBus.changeRooms.emit(Vector2(1,0), 4)# change rooms to the right
				

	
	

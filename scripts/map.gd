"""
Code that generates a starting and ending position in a 2D array,
 and generates a randomized dungeon between the two points
"""

extends Node2D

# Variables to be initialised
const mapSize = 9 # Default map size
var mapGrid = [] # The empty map grid
var rng = RandomNumberGenerator.new()
var startPos: Vector2 # Starting position in the form of x,y coordinates on the grid
var exitPos: Vector2# Starting position in the form of x,y coordinates on the grid
var path : Array # An array of Vector2s full of coordinates representing the optimal path between the starting and ending positions
var tPath : Array
var doorMatrix : Array


func genPath(start: Vector2, end: Vector2, prevP: Vector2, diff: int, gridsize: int, p: Array):
	# Function that generates a random path between points on a 2D array recursively
	# Param - start: A Vector2 representing the point that we need to find the next best move from
	# Param - end: A Vector2 representing the point that we are calculating the best route towards
	# Param - prevP: A Vector2 representing the last point on the array that was processed
	# Param - diff: The total number of spaces away the two points on a 2D array are.
	# Param - gridSize: An integer representing the length and height of the map grid. Determines the limits of generation.
	# Param - p: And array that conatins Vector2 coordinates for the optimal path toward the desire end point
	# Return: The complete path Array
	
	# Base case. The start point is the end point
	if start == end:
		return p
	else:
		# Logic to determine which way we will go to get closer to the endpoint
		
		# All possible points you can move to
		var pPos = [Vector2(start.x - 1, start.y), Vector2(start.x + 1, start.y), Vector2(start.x, start.y-1), Vector2(start.x, start.y+1)]
		var fPos = []
		# Remove options from the possible options based on if they move to far away, were just visited, or are out of bounds
		for item in pPos:
			var iDiff = abs((end - item).x) + abs((end - item).y)
			if item.x >= gridsize or item.x < 0 or item.y >= gridsize or item.y < 0:
				null
			elif iDiff > diff:
				null
			elif item == prevP:
				null
			else:
				fPos.append(item)
		# If there are no possible choices, lower the diff by one and go back to the previous point on the array
		var choice : Vector2  
		if fPos.size() < 1:
			choice = prevP
			return genPath(prevP, end, start, diff-1, 9, p)
		# Otherwise, choose a random option from the remaining possible points, and recursively loop with it
		else:
			choice = fPos[rng.randi_range(0, fPos.size() - 1)]
			if p.find(choice, 0) == -1:
				p.append(choice)
			else:
				print("Repeat")
			return genPath(choice, end, start, (abs((end - start).x) + abs((end - start).y)), 9, p)
		
func setDoors(pa: Array):
	# Function that generates the doors between each point in an array
	# Param - pa: an array containing all the points on a graph that may connect to one another
	
	# For each point in the path, check if any adjacent points are also in the path, and set an edge between the two, whose
	# value depends on the derection the two points are connected. 
	for start in pa:
		var pPos = [Vector2(start.x - 1, start.y), Vector2(start.x + 1, start.y), Vector2(start.x, start.y-1), Vector2(start.x, start.y+1)]
		for p in pPos:
			var diff = start-p
			if pa.find(p, 0) != -1:
				if diff.x != 0:
					if diff.x > 0:
						doorMatrix[(start.x) + (start.y * 9)][(p.x) + (p.y * 9)] = 4
						doorMatrix[(p.x) + (p.y * 9)][(start.x) + (start.y * 9)] = 2
					else:
						doorMatrix[(start.x) + (start.y * 9)][(p.x) + (p.y * 9)] = 2
						doorMatrix[(p.x) + (p.y * 9)][(start.x) + (start.y * 9)] = 4
				else:
					if diff.y > 0:
						doorMatrix[(start.x) + (start.y * 9)][(p.x) + (p.y * 9)] = 3
						doorMatrix[(p.x) + (p.y * 9)][(start.x) + (start.y * 9)] = 1
					else:
						doorMatrix[(start.x) + (start.y * 9)][(p.x) + (p.y * 9)] = 1
						doorMatrix[(p.x) + (p.y * 9)][(start.x) + (start.y * 9)] = 3

func truePath(p: Array, cur: Vector2, start: Vector2, end: Vector2, tP: Array):
	# A function that finds a random path between two points using a limited set of points.
	# Param - p: The set of points the path will be made from
	# Param - cur: The current point being processed
	# Param - start: The initial starting point. Doesn't change
	# Param - end: The target point. Doesn't change
	# Param - tP: An array containing the points of the generated path
	# Returns: tP
	
	if cur == end: # Base case. The current point is the end point.
		return tP
	else:
		# List of possible points adjacent to the current point
		var pPos = [Vector2(cur.x - 1, cur.y), Vector2(cur.x + 1, cur.y), Vector2(cur.x, cur.y-1), Vector2(cur.x, cur.y+1)]
		var fPath = []
		# Remove from the list of possible points, checking if a point is in the list of allowed points and if we haven't already visited it.
		for i in pPos:
			if p.find(i, 0) != -1 and tP.find(i, 0 ) == -1:
				fPath.append(i)
		print(fPath)
		# If there are no possible points to move to, restart from the beginning
		if fPath.size() < 1:
			print("redo")
			return truePath(p, start, start, end, [start])
		else: 
			# Otherwise, choose a point among the remaining possible points to continue the recursive loop from
			print("go")
			var choice = fPath[rng.randi_range(0, fPath.size() - 1)]
			print(choice)
			tP.append(choice)
			return truePath(p, choice, start, end, tP)

func doorCleanUp(t, p):
	# Function that goes through the edges connecting each point in the generated path, and has a 
	# chance to delete doors between rooms if they are not part of the path to the exit room
	# Param - t: The path to the exit room representred by an array of points. Prevents edges connecting the 
	# 			points from this array being effected by the door removal, ensuring there will always be a 
	#			possible way throught the dungeon
	# Param - p: The array conatining all the generated points in the current dungeon.
	for i in p:
		var mX = (i.x) + (i.y*9)
		for j in p:
			var mY = (j.x) + (j.y *9)
			if (t.find(i) == -1 or t.find(j) == -1) and doorMatrix[mX][mY] != 0:
				if rng.randf() < 0.33:
					doorMatrix[mX][mY] = 0
					doorMatrix[mY][mX] = 0
func pathCleanup(p):
	# Function that takes the current list of points in the dungeon, and removes any points that do not connect to any other point
	# Param - the list of points generated for the current dungeon.
	# Returns: A new list of points, with unconnected points removed
	var nPath = []
	for i in p:
		var mX = (i.x) + (i.y*9)
		var sum = 0
		for j in doorMatrix[mX]: # Checks to see if the current point has any edges to other points
			sum += j
		if sum > 0: # If they do, add them to the new list of points. Otherwise, do not.
			nPath.append(i)
	print("cleaned")
	return nPath
			

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.on_death.connect(_on_death)
	for i in range(0, 81):
		doorMatrix.append([])
		for j in range(0,81):
			doorMatrix[i].append(0)
			
func gen_points(s: int):
	
	rng.set_seed(s)
	
	# Randomly generating a starting point to start the path
	startPos = Vector2(rng.randi_range(0,mapSize-1), rng.randi_range(0,mapSize-1))
	
	# Generating an endpoint that is not equal to the starting point
	while true:
		exitPos = Vector2(rng.randi_range(0,mapSize-1), rng.randi_range(0,mapSize-1))
		if startPos != exitPos:
			break
	
	# Adding the starting point to the final pathe array
	path =[Vector2(startPos.x, startPos.y)]
	tPath = [Vector2(startPos.x, startPos.y)]
	# Generates decoy pathways between two other fake end points
	for i in range(0,1):
		var ranPos = Vector2(rng.randi_range(0,mapSize-1), rng.randi_range(0,mapSize-1))
		path = genPath(startPos, ranPos, startPos,  (abs((ranPos-startPos).x) + abs((ranPos-startPos).y)) + 1, 9, path)
	# Generates the real pathway between the start and exit point
	path = genPath(startPos, exitPos, startPos, (abs((exitPos-startPos).x) + abs((exitPos-startPos).y)) + 1, 9, path)
	# Finds a new, random path between the start and end points using all the possible points generated in the path array
	tPath = truePath(path, startPos, startPos, exitPos, tPath)
	# Sets the doors between each room
	setDoors(path)
	# Cuts down on some doors, to give the dungeon a more labrynth feel
	doorCleanUp(tPath, path)
	# Cleans up the array of points by removing points that had all their connections removed, thus making them pointless
	path = pathCleanup(path)
	
	# Creating the 2D array that the rooms will be stored in by the game controller
	for y in mapSize:
		mapGrid.append([])
		for x in mapSize:
			mapGrid[y].append([])
	

func _on_death():
	queue_free()

"""
Code that generates a starting and ending position in a 2D array,
 then calculates the ideal path between them
"""

extends Node2D

# Variables to be initialised
const mapSize = 9 # Default map size
var mapGrid = [] # The empty map grid
var rng = RandomNumberGenerator.new()
var startPos: Vector2 # Starting position in the form of x,y coordinates on the grid
var exitPos: Vector2# Starting position in the form of x,y coordinates on the grid
var path : Array # An array of Vector2s full of coordinates representing the optimal path between the starting and ending positions

func genPath(start: Vector2, end: Vector2, path: Array):
	# Function that generates the optimal path between points on a 2D array recursively
	# Param - start: A Vector2 representing the point that we need to find the next best move from
	# Param - end: A Vector2 representing the point that we are calculating the best route towards
	# Param - path: And array that conatins Vector2 coordinates for the optimal path toward the desire end point
	# Return: The complete path Array
	
	# Base case. The start point is the end point
	if start == end:
		return path
	else:
		# Logic to determine which way we will go to get closer to the endpoint
		if abs(start.x - end.x) >= abs(start.y - end.y):
			if (start.x - end.x) > 0:
				path.append(Vector2(start.x -1, start.y)) # Adding the new position to the path
				return genPath(Vector2(start.x -1, start.y), end, path) # Setting the start point to the newly calculated point, and recursively calling the function
			else:
				path.append(Vector2(start.x +1, start.y))
				
				return genPath(Vector2(start.x +1, start.y), end, path)
		else:
			if (start.y - end.y) > 0:
				path.append(Vector2(start.x, start.y-1))
				return genPath(Vector2(start.x, start.y-1), end, path)
			else:
				path.append(Vector2(start.x, start.y+1))
				return genPath(Vector2(start.x, start.y+1), end, path)
		
	


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.on_death.connect(_on_death)
	# Randomly generating a starting point to start the path
	startPos = Vector2(rng.randi_range(0,mapSize-1), rng.randi_range(0,mapSize-1))
	
	# Generating an endpoint that is not equal to the starting point
	while true:
		exitPos = Vector2(rng.randi_range(0,mapSize-1), rng.randi_range(0,mapSize-1))
		if startPos != exitPos:
			break
	
	# Adding the starting point to the final pathe array
	path =[Vector2(startPos.x, startPos.y)]
	# Generating the optimal path between the start and end points, and adding them to the final path array
	path = genPath(startPos, exitPos, path)
	
	# Creating the 2D array that the rooms will be stored in by the game controller
	for y in mapSize:
		mapGrid.append([])
		for x in mapSize:
			mapGrid[y].append([])

func _on_death():
	queue_free()

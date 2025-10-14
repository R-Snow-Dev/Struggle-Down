extends RefCounted
class_name PushPuzzleSolo

"""
Code that generates coordinates to spawn walls when given a start and end point
of a push puzzle consisting of one button and one box
"""

# Variables
var startPos: Vector2
var endPos: Vector2
var path: Array = []
var directions: Array = []
var walls: Array = []
var gridSize: Vector2
var rng = RandomNumberGenerator.new()
var loops: int = 0

#constructor
func _init(g: Vector2) -> void:
	gridSize = g

# Helper function to replace the funky built in "find" method
func findIn(obj, list: Array):
	for n in range(0, list.size()):
		if list[n] == obj:
			return n
	return -1

# Sets the rng seed
func setSeed(s):
	rng.set_seed(s)	

# Defines the starting point of the puzzle (Where the box spawns)
func setStart(s: Vector2):
	startPos = s

# Defines the end point of the puzzle (the button)
func setEnd(e: Vector2):
	endPos = e	

# BEgin generating a path
func go():
	loops += 1
	directions = []
	return genPath(startPos, endPos, startPos, (abs((endPos - startPos).x) + abs((endPos - startPos).y)), gridSize, [startPos])

# Recursive walker function that randomly creates a path between the start and end point
# storing each step in a "path" array to be used later
func genPath(start: Vector2, end: Vector2, prevP: Vector2, diff: int, gridsize: Vector2, p: Array):
	
	# Base case. The start point is the end point
	if start == end:
		return p
	else:
		# Logic to determine which way we will go to get closer to the endpoint
		
		# All possible points you can move to
		var pPos = []
		if not(start.x >= gridsize.x -1 or start.x < 1 or start.y >= gridsize.y-1 or start.y < 1):
			pPos = [Vector2(start.x - 1, start.y), Vector2(start.x + 1, start.y), Vector2(start.x, start.y-1), Vector2(start.x, start.y+1)]
		elif start.x >= gridsize.x -1 or start.x < 1:
			pPos = [Vector2(start.x, start.y -1), Vector2(start.x, start.y + 1)]
		else:
			pPos = [Vector2(start.x -1, start.y), Vector2(start.x + 1, start.y)]
		var fPos = []
		# Remove options from the possible options based on if they move to far away, were just visited, or are out of bounds
		for item in pPos:
			var iDiff = abs((end - item).x) + abs((end - item).y)
			if item.x >= gridsize.x or item.x < 0 or item.y >= gridsize.y or item.y < 0:
				pass
			elif iDiff > diff:
				pass
			elif item == prevP:
				pass
			else:
				fPos.append(item)
		# If there are no possible choices, retry
		var choice : Vector2  
		if fPos.size() < 1:
			if loops < 4:
				return go()
			else:
				p = []
				return p
		# Otherwise, choose a random option from the remaining possible points, and recursively loop with it
		else:
			choice = fPos[rng.randi_range(0, fPos.size() - 1)]
			if p.find(choice, 0) == -1:
				p.append(choice)
			else:
				print("Repeat")
			return genPath(choice, end, start, (abs((end - start).x) + abs((end - start).y)), gridsize, p)

# Using the "path" array from the genPath() function, decide where walls should
# be placed around the room to make appropriate obstacles
func genWalls():
	var untouchables = []
	path = go()	
	if path.size() > 1:
		print(path, "\n")
		for n in range(0, path.size()):
			if n == path.size()-1:
				directions.append(Vector2(0,0))
			else:
				directions.append(path[n+1] - path[n])
		var cDir = directions[0]
		var pDir = directions[0]
		for n in range(0, path.size()):
			if not cDir == pDir:
				if path[n].x > 0 and path[n].x < gridSize.x-1 and path[n].y > 0 and path[n].y < gridSize.y-1 and cDir != Vector2(0,0):
					if not (path[n] + pDir in path):
						var attempt = path[n] + pDir
						if not (attempt + Vector2(1,1) in walls or attempt + Vector2(-1,1) in walls or attempt + Vector2(1,-1) in walls or attempt + Vector2(-1,-1) in walls):
							walls.append(attempt)
			pDir = cDir
			if n < path.size()-1:
				cDir = directions[n + 1]
		untouchables = checkImpossible(path, untouchables)
		for w in walls:
			untouchables.append(w)
		untouchables.append(startPos)
		untouchables.append(endPos)
		untouchables.append(startPos - directions[0])
		genMore(untouchables, gridSize)
	else:
		walls = []
	return walls

# Checks to make sure the path isn't accidentally blocked off
func checkImpossible(p: Array, uTouch: Array):
	var cDir = directions[0]
	var pDir = directions[0]
	for n in range(0, p.size()):
		if not cDir == pDir:
			if (p[n] - cDir) in walls:
				walls.remove_at(findIn((p[n] - cDir),walls))
		uTouch.append(p[n]- cDir)
		pDir = cDir
		if n < p.size()-1:
				cDir = directions[n + 1]
	return uTouch

# Generates random walls coordinates in spots that won't make the puzzle impossibel
func genMore(untouchables: Array, gridsize: Vector2):
	for n in range(0, gridsize.x * gridsize.y):
		if rng.randf() > 0.5:
			var attempt = Vector2(rng.randi_range(1, gridsize.x-2), rng.randi_range(1,gridsize.y-2))
			if not (attempt in untouchables or attempt in path):
				if not (attempt + Vector2(1,1) in untouchables or attempt + Vector2(-1,1) in untouchables or attempt + Vector2(1,-1) in untouchables or attempt + Vector2(-1,-1) in untouchables):
					if not attempt in walls:
						walls.append(attempt)
				

extends Behavior
class_name SlimeBehavior

"""
AI class that calculates how and when a Slime enemy attacks or moves
"""

# Function that decides whether or not to attack or move
func think() -> void:
	# Variables
	var t = getTarget()
	var m = getMyself()
	var mPos = m.getData().getPos()
	var tPos = t.pos
	
	# Faces towards the player
	findFacing()
	
	var facing = m.getData().getFacing()
		
	if (mPos + facing) == tPos: # If the slime is within one tile, attack
		attack()
			
	else: # Otherwise, move
		move()	


# Function that decides what direction to face, to always be facing the player
func findFacing():
	# Variables
	var t = getTarget()
	var m = getMyself()
	var mPos = m.getData().getPos()
	var tPos = t.pos
	
	
	var bestCase = tPos - mPos
	
	if abs(bestCase.x) >= abs(bestCase.y):
		m.getData().setFacing(Vector2(getSign(bestCase.x), 0))
	else:
		m.getData().setFacing(Vector2(0, getSign(bestCase.y)))	

# Function that decides where the slime will move to. Tries to go directly to the player 
# when possible
func move() -> void:
	# Variables
	getMyself().getData().setActions(getMyself().getData().getActions()-1)
	var g = getGrid().getGrid()
	var b = getGrid()
	var t = getTarget()
	var m = getMyself()
	var mPos = m.getData().getPos()
	var tPos = t.pos
	var chosen = Vector2(0,0)
	
	# Initialise a list of possible positions, and an array representing
	# The final options of positions to move to
	var pPos = [mPos + Vector2(1,0), mPos + Vector2(-1,0), mPos + Vector2(0,1), mPos + Vector2(0,-1)]
	var fPos = []
	
	# Finds what direction the player is in, and what direction it needs to move to get there
	var bestCase = tPos - mPos
	
	if bestCase.x == bestCase.y:
		bestCase = [mPos + Vector2(getSign(bestCase.x), 0), mPos + Vector2(0, getSign(bestCase.y))]
	elif abs(bestCase.x) > abs(bestCase.y):
		bestCase = [mPos + Vector2(getSign(bestCase.x), 0)]
	else:
		bestCase = [mPos + Vector2(0, getSign(bestCase.y))]
	
	# Check each possible position to see if the tile isn't occupied, and
	# is within the grid
	for p in pPos:
		if p.y > -1 and p.y < b.height and p.x > -1 and p.x < b.width:
			var add = true
			for obj in g[p.y][p.x]:
				if !checkPassable(obj):
					add = false
			if add:
				fPos.append(p)
	
	# Check to see if any ideal tiles are a part of the
	# final options. If not, pick a random tile form the list of choices
	if fPos.size() > 0:
		for x in bestCase:
			if x in fPos:
				chosen = x
			else:
				chosen = fPos[rng.randi_range(0, fPos.size()-1)]
				
	# Update the Rat's position, and direction it is facing
	getMyself().getData().setPos(chosen)	
	getMyself().draw()
	getMyself().add_child(preload("res://scenes/Particles/slimey_step.tscn").instantiate())
	getMyself().setDelay(0.1)

# Function that performs the attack operations	
func attack() -> void:
	findFacing()
	getMyself().getData().setActions(getMyself().getData().getActions()-1) # Decrese actions by 1
	var atk = SlimeAttack.new(1, getMyself()) # Load the class that contains the attack code
	atk.attack() # The Attack class performs it's code
	getMyself().setDelay(0.5)

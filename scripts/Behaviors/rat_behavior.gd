extends Behavior
class_name RatBehavior

"""
AI class that performs the necessary calculation forr the rat enemy to decide 
whether it can attack or not. If it can, it performs a basic melee attack. If 
not, it calculates the best tile to move to get closer to the player
"""

func think() -> void:
	# Function that decides if the rat can attack, based on if the rat is
	# next to the player, and facing the player
	var t = getTarget()
	var m = getMyself()
	var mPos = m.getData().getPos()
	var tPos = t.pos
	var facing = m.getData().getFacing()
	
	if (mPos + facing) == tPos:
		attack() # Attack
	else:
		move() # Reposition
	
# Function that checks if the rat is in a tile next to the player
func isNext(mPos: Vector2, tPos: Vector2) -> bool:
	var dif = tPos - mPos
	if abs(dif.x +dif.y) == 1:
		return true
	return false
		

# Function that tells the rat where it should move to
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
	
	# Calculate what direction to move to be closer to the player.
	var bestCase = tPos - mPos
	var nextBest = []
	
	
	if isNext(mPos, tPos):
		bestCase = [(tPos - mPos) * -1]
		
	else:
		if bestCase.x == bestCase.y:
			bestCase = [Vector2(getSign(bestCase.x), 0), Vector2(0, getSign(bestCase.y))]
		elif abs(bestCase.x) > abs(bestCase.y):
			nextBest = [Vector2(0, getSign(bestCase.x))]
			bestCase = [Vector2(getSign(bestCase.x), 0)]
		else:
			nextBest = [Vector2(getSign(bestCase.x), 0)]
			bestCase = [Vector2(0, getSign(bestCase.y))]
		
	
	# Check each possible position to see if the tile isn't occupied, and
	# is within the grid
	for p in pPos:
		if p.y > -1 and p.y < b.height and p.x > -1 and p.x < b.width:
			var add = true
			for obj in g[p.y][p.x]:
				if !checkPassable(obj):
					add = false
			if add:
				fPos.append(p) # If they are, add them to the list of final options
	
	 # Check to see if any ideal tiles or next-best tiles are a part of the
	# final options. If not, pick a random tile form the list of choices
	if fPos.size() > 0:
		for x in bestCase:
			if x + mPos in fPos:
				chosen = x
			else:
				if nextBest.size() > 0:
					for y in nextBest:
						if y in fPos:
							chosen = y
						else:
							chosen = fPos[rng.randi_range(0, fPos.size()-1)] - mPos
				else:
					chosen = fPos[rng.randi_range(0, fPos.size()-1)] - mPos
	
	# Update the Rat's position, and direction it is facing
	getMyself().getData().setPos(chosen + mPos)	
	getMyself().getData().setFacing(chosen)
	getMyself().chooseState()
	getMyself().draw()
	getMyself().add_child(preload("res://scenes/Particles/slimey_step.tscn").instantiate())
	getMyself().setDelay(0.3)

# Function that performs the attack operations
func attack() -> void:
	getMyself().getData().setActions(getMyself().getData().getActions()-1) # Decrese actions by 1
	var atk = SlimeAttack.new(1, getMyself()) # Load the class that contains the attack code
	atk.attack() # The Attack class performs it's code
	getMyself().setDelay(0.5) 

extends "res://scripts/Behaviors/EnemyBehavior.gd"
class_name SlimeAI

func pathFind(gB: Array, curPos: Vector2, targetPos: Vector2, fiend: Object):
	# Function that determines the best move the slime can make to get closer to the player
	# param - gB: The grid holding the positions of every object on the floor
	# param - curPos: The Current position of the slime
	# param - targetPos: Position of the player that the slime is trying to move towards
	# returns: A Vector two containing a 1 or -1 in therespective axis of movement the slime will move in
	
	# Initialise the array of possible coordinates the slime can move to
	var possibleMoves = []
	
	# Add the up, down, left, and right coordinates respective of the curent position, if these are within the bounds of the game board
	if curPos.x-1 > 0:
		possibleMoves.append(Vector2(curPos.x-1, curPos.y))
	if curPos.x < len(gB[0])-1:
		possibleMoves.append(Vector2(curPos.x+1, curPos.y))
	if curPos.y-1 > 0:
		possibleMoves.append(Vector2(curPos.x, curPos.y-1))
	if curPos.y < len(gB)-1:
		possibleMoves.append(Vector2(curPos.x, curPos.y+1))
	
	# Initialise the minMove Vector2, which will be returns, and the finalOptions array, that will the store coordinates from 
	# the possibleMoves array that are not occupied by other objects
	var minMove = Vector2(0,0)
	var finalOptions = []
	
	# Checks to make sure there are moves that can be made, otherwise return (0,0)
	if len(possibleMoves) > 0:
		for x in possibleMoves:
			if gB[x.y][x.x] is Array: # Adds non occupied coordinates to finalOptions
				finalOptions.append(x)
				
	# Checks to make sure there are options in finalOptions, otherwise return (0,0)
	if len(finalOptions) > 0:
		var smallestDiff = -1 # Sets the smallest difference between option and target to a default of -1
		var tempDiff: Vector2 # Initialises a variable to store the difference between two Vector2s as a Vector2
		for x in finalOptions:
			if smallestDiff == -1:
				tempDiff = abs(x-targetPos) # If the smallest difference is its default "-1", set it to the difference between the first coordinate in the array,and the target
				if tempDiff.x == 0:
					tempDiff.x = 1
				if tempDiff.y ==0:
					tempDiff.y = 1
				smallestDiff = tempDiff.x * tempDiff.y
			
			# get the difference between the current option coordinate and the target coordinate. Set all 0s to 1s
			tempDiff = abs(x-targetPos)
			if tempDiff.x == 0:
				tempDiff.x = 1
			if tempDiff.y ==0:
				tempDiff.y = 1
			
			# Set the evaluated difference to the product between the x and y components of the newly calculated diffenrence
			var curDiff = tempDiff.x * tempDiff.y 
			if curDiff <= smallestDiff: # Set the minMove to the coordinate that has the lowest evaluated difference between target and it's postions
				smallestDiff = curDiff
				minMove = x - curPos
	findFacing(curPos + minMove, targetPos, fiend)
	return minMove # Return a Vector2() containing either a 1 or -1 in the respective axis of movement, decided by the algorithm
	
func findFacing(curPos: Vector2, targetPos: Vector2, fiend: Object):
	# find the direction the slime should be "facing" so it faces the player
	# param - curPos: the current position of the slime
	# param - targetPos: The position of the player
	# param - fiend: The instance of the slime that is trying to update it's facing direction
	
	# If teh difference between the player's y and the slime's y is greter or equal to the differences between their Xs:
	if abs(curPos.y - targetPos.y) >= abs(curPos.x-targetPos.x):
		if curPos.y - targetPos.y > 0: # Update to down if the slime is above the player
			fiend.facing = "down"
		else:
			fiend.facing = "up" # Update to up if the slime is below the player
	# Otherwise:
	else:
		if curPos.x - targetPos.x > 0 :
			fiend.facing = "left" # Update to left if the slime if to the left of the palyer
		else:
			fiend.facing = "right"# Update to right if the slime is to the right of the player

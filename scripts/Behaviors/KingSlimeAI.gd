extends "res://scripts/Behaviors/bossAI.gd"
class_name KingSlimeAI

var rng = RandomNumberGenerator.new()
var moveData = {2: []}

func updateView(board: Array, pPos: Vector2, boss: Object):
	# Function that updates the vision board of the boss. Places the player on
	# Possible locations in the vision board based on their position in the real
	# game board
	# @param board - The vision board being updated
	# @param pPos - The player's position on the REAL gameboard
	# returns - An array containing three arrays. The first is the updated vision board. The second
	# conatining all the possible x positons of the player, and the third conatining all the 
	# possible y positions of the player
	
	# Set the player position into variables
	var x = pPos.x                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
	var y = pPos.y
		
	
	if x < 0:
		x = [x]
	elif x > 9:
		x = [x-1]
	else:
		x = [x, x-1]
		
	if y < 0:
		y = [y]
	elif y > 9:
		y = [y-1]
	else:
		y = [y, y-1]

	
	# Remove the old position of the player from the vision board
	for i in range(0,10):
		for j in range(0,10):
			if board[i][j] == 2 or board[i][j] == 3:
				board[i][j] = 0
	
	# Add the new player position to the vision board
	for i in x:
		for j in y:
			if board[j][i] == 0: 
				board[j][i] = 2
	
	board[boss.pos.y][boss.pos.x] = 3
	
	# Return the updated vision board
	return [board, x, y]


func decide(boss: Object, pPos: Vector2, board: Array, gBoard: Array):
	# Logic that determines what the boss will do next turn
	# @param boss - An object that refers bass to the instance of the boss using the function
	# @param pPos - the position of the player on the gameboard
	# @param board - The vision board of the boss. NOT the gameboard
	
	# Updates the vision board to ensure its up to date
	var temp = updateView(board, pPos, boss)
	for l in temp[0]:
		print(l)
	# Gets the current id of the boss's next attack
	var nMove = boss.nextMove
	print(nMove)
	# If that ID is 0, prepare a next attack.
	if nMove == 0:
		var facing = findFacing(temp[1], temp[2], boss)
		if facing == Vector2(0,0):
			if(rng.randi_range(1,2) == 1): # Sets the next move to be the summon ability
				boss.nextMove = 2
				moveData[2] = []
				for x in range(rng.randi_range(0,1),11,2):
					for y in range(rng.randi_range(0,1),11,2):
						if gBoard[x][y] is Array:
							moveData[2].append(Vector2(x,y))
			else:
				boss.nextMove = 3 # Sets the next move to be the jump attack
		else: # Sets the next attack to be the charge
			boss.nextMove = 1
			boss.facing = facing
	# If that ID is not zero, excecute the attack, then prepare a new one
	else:
		if nMove == 1:
			slideAtk(boss, [temp[1], temp[2]], board)
			boss.nextMove = 0 
			decide(boss, pPos, board, gBoard)
		elif nMove == 2:
			spawnAdds(boss, pPos, board, moveData[nMove])
			boss.nextMove = 0 
			decide(boss, pPos, board, gBoard)
		else:
			bounce(boss)
			boss.nextMove = 0
			decide(boss, pPos, board, gBoard)
	boss.updateView(pPos)


func returnClosest(v: Array, num: float):
	# Function that finds the closest number out of an array of 2 numbers to some given value
	# @param v - an array of values to be compared. Must have two values
	# @param num - the value that the array will be compared to
	# return - An array containing the closer number. If its even, the array will return both
	var a = abs(v[0] - num)
	var a1 = abs(v[1]- num)
	
	if a < a1:
		return [v[0]]
	elif a1 < a:
		return [v[1]]
	else:
		return v

func findFacing(pX: Array, pY: Array, boss: Object):
	# Function that finds what direction the bos should face to look at the player
	# @param pX - An array of int values, containg all the x-positions the player occupies on the vision board
	# @param py - An array of int values, containg all the y-positions the player occupies on the vision board
	# @param boss - A reference to the original boss object that is being acted upon
	var obj = []
	for x in pX:
		for y in pY:
			var temp = Vector2(x,y) - boss.pos
			if temp.x * temp.y == 0:
				obj.append(Vector2(x,y))
	if len(obj) > 0:
		var t = obj[0] - boss.pos
		if t.x == 0:
			t.y = (1*t.y)/abs(t.y)
		else:
			t.x = (1*t.x)/abs(t.x)
		return t
	else:
		return Vector2(0,0)
		
		
	
	

func slideAtk(boss: Object, pPos: Array, board: Array):
	# Code that performs the slide attack of the slime king boss
	# @param boss - Reference to the Boss Object of the slime king
	# @param pPos:  An array of all the possible player locations in the vision board
	# @param board - The vision board of the slime king
	
	# Set up all variables
	var dir = [boss.facing.x, boss.facing.y]
	var bP = [boss.pos.x, boss.pos.y]
	var targetCoord = [0,0]
	var oIndex = 1
	var index = 0
	var closestCoord: int
	
	# Set the index of whichever number was zero in the facing vector to the variable "index"
	# And the index of the number that had a value of either 1 or -1 to the variable "oIndex"
	if dir[1] == 0:
		index = 1
		oIndex = 0
	
	# If the player is in the line of fire, only move as far as the player, then stop
	if pPos[index][0] == bP[index] or pPos[index][1] == bP[index]:
		if len(pPos[oIndex]) > 1:
			closestCoord = returnClosest([pPos[oIndex][0], pPos[oIndex][1]], bP[oIndex])[0]
		else:
			closestCoord = pPos[oIndex][0]
		targetCoord[index] = bP[index]
		targetCoord[oIndex] = closestCoord - dir[oIndex]
		targetCoord = Vector2(targetCoord[0], targetCoord[1])
		charge(boss, targetCoord, abs(closestCoord - bP[oIndex]))
	
	# If not, charge untill you hit the nearest wall
	else:
		# Set variables
		var tValue = bP[oIndex]
		var testV = [0,0]
		
		# Depending on the direction, find the nearest wall you will hit, and set the target
		# coordinate to one before that
		if(dir[oIndex] > 0):
			while(tValue < 9):
				print(tValue)
				testV[oIndex] = tValue
				testV[index] = bP[index]
				if board[testV[0]][testV[1]] == 1:
					tValue = (tValue - dir[oIndex])
					break
				tValue += dir[oIndex]
		elif(dir[oIndex] < 0):
			while(tValue > 0):
				print(tValue)
				testV[oIndex] = tValue
				testV[index] = bP[index]
				if board[testV[0]][testV[1]] == 1:
					tValue = (tValue - dir[oIndex])
					break
				tValue += dir[oIndex]

		# Turn the targetCoord array into a vector, and play the correct animation
		targetCoord[index] = bP[index]
		targetCoord[oIndex] = tValue
		targetCoord = Vector2(targetCoord[0], targetCoord[1])
		print(targetCoord)
		charge(boss, targetCoord, abs(tValue - bP[oIndex]))
		
		
	
func spawnAdds(boss: Object, pPos: Vector2, board: Array, data: Array):
	print("adds Spawned")
	
func bounce(boss: Object):
	boss.pos = Vector2(rng.randi_range(4,5), rng.randi_range(4,5))
	boss.draw()

func charge(boss: Object, t: Vector2, diff: int):
	# Function that alters the charge animation based on certain parameters.
	# @param boss - Reference back to the Boss Object of the king slime
	# @param t - The Vector of the target destination to charge to
	# @param diff - The differnce between the target destination and the current one
	
	# Set needed variables
	var animPlayer = boss.animPlayer
	var charge = animPlayer.get_animation("charge")
	var time = 0.5 - (diff/10) # Sets the amount of time the animation will take based on the distance needed to travel
	var targ = t * 16
	var s = boss.pos * 16
	s += Vector2(8,8)
	targ += Vector2(8,8)
	# Modifies the key frames in the animation so that the boss moves in the correct direction 
	# Foe the correct amount of time
	charge.track_set_key_value(0,0,s)
	charge.track_set_key_value(0,1,targ)
	charge.track_set_key_time(0,1,time)
	charge.track_set_key_time(1,0,time)
	# Play the animation
	animPlayer.play("charge")
	boss.timer.wait_time += time # Make the player wait extra time so the animation finishes
	
	
	
	
	
	

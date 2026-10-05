extends Behavior
class_name RCBehavior

var nextAttack: Attack
var p: Vector2
var position: Vector2 = Vector2(0,0)
var ideal: Vector2 = Vector2(0,0)

var summon: bool = false

var rangeResult: Dictionary = {}

func think() -> void:
	# Function that decides if the rat can attack, based on if the rat is
	# next to the player, and facing the player
	if getMyself().getData().getActions() == getMyself().getData().getMaxActions():
		getMyself().getData().setActions(getMyself().getData().getActions()-1)
		if nextAttack:
			attack()
		else:
			p = getMyself().getPos()
	elif getMyself().getData().getActions() == getMyself().getData().getMaxActions() -1:
		findTarget()
		move()
	elif getMyself().getData().getActions() > 1:
		move()
	else:
		warn()

func getIdeal() -> Vector2:
	return ideal

func findTarget() -> void:
	rangeResult = myRange()
	var final = []
	for x in rangeResult:
		if len(final) > 0:
			if rangeResult[x] == rangeResult[final[0]]:
				final.append(x)
			elif rangeResult[x] > rangeResult[final[0]]:
				final = [x]
		else:
			final = [x]
	var chosen = final[rng.randi_range(0, len(final)-1)]
	position = chosen
	
func myRange() -> Dictionary:
	var actionTotal = getMyself().getData().getActions()-1
	var possiblePoints = []
	var final = {}
	for x in range(actionTotal,-(actionTotal+1),-1):
		var y = actionTotal - abs(x)
		possiblePoints.append(Vector2(x,y))
		if y > 0:
			possiblePoints.append(Vector2(x,-y))
	for c in possiblePoints:
		var try = p + c
		if Overseer.checkValid(try):
			var t = 0
			var d: Vector2 = try - getTarget().getPos()
			if abs(d.x +d.y) == 1:
				if (WeaponList.held == 11 or Vector2i(d) == getTarget().facing) and not WeaponList.held == 8:
					t = 2
				else:
					t = getMyself().getData().getMaxActions() + 2
			elif d.y == 0 or d.x == 0:
				t = abs(d.x +d.y) + 2
				if Vector2i(d.normalized()) == getTarget().facing:
					t -= 3
			else:
				t = abs(d.x +d.y)
				if abs(d.x +d.y) > getMyself().getData().getMaxActions() - 1:
					t = 0
				elif abs(d.x +d.y) >= getMyself().getData().getMaxActions() - 2:
					t -= 1
			final[try] = t
	final[getMyself().getPos()] = 0
	return final

func findLoco(targ: Vector2) -> Vector2:
	var d = targ - getMyself().getPos()
	var final = Vector2((d.x+0.5)/abs(d.x+0.5), (d.y+0.5)/abs(d.y+0.5))
	if abs(d.y) > abs(d.x):
		final = Vector2(0,1) * final
	else:
		final = Vector2(1,0) * final
	return final
	
func findLocoInv(targ: Vector2) -> Vector2:
	var d = targ - getMyself().getPos()
	var final = Vector2((d.x+0.5)/abs(d.x+0.5), (d.y+0.5)/abs(d.y+0.5))
	if abs(d.y) < abs(d.x):
		final = Vector2(0,1) * final
	else:
		final = Vector2(1,0) * final
	return final


func warn() -> void:
	var t = 0
	if getMyself().getPos() in rangeResult.keys():
		t = rangeResult[getMyself().getPos()]
	var lim = getMyself().pActions
	var d = getTarget().getPos() - getMyself().getPos()
	p = getMyself().getPos()
	getMyself().getData().setActions(1)
	if summon:
		nextAttack = RatSummon.new(0, getMyself())
		summon = false
	elif getTarget().getPos() - getMyself().getPos() == getMyself().getData().getFacing():
		nextAttack = RatSlash.new(2,getMyself())
	elif t < lim and t > 0:
		print('retreat!')
		var f = findLocoInv(Vector2(5,5))
		var loco = Vector2(abs(f.x), abs(f.y))
		var math = Vector2(pow(6/(getMyself().getPos().x+1),loco.x), pow(6/(getMyself().getPos().y+1),loco.y))
		print(6/getMyself().getPos().y+1)
		print('math ', math)
		getMyself().getData().setFacing(findLocoInv(Vector2(5,5)))
		ideal = Vector2i(((getMyself().getPos() + Vector2(1,1)) * math) - Vector2(1,1) + getMyself().getData().getFacing())
		var s = Overseer.closestLOS(Vector2i(getMyself().getPos()), Vector2i(getMyself().getData().getFacing()),Vector2i(0,0), 'fiend')
		var m1 = Vector2(ideal) - getMyself().getPos()
		var m2 = Vector2(s) - getMyself().getPos()
		m1 = sqrt(pow(m1.x,2)+pow(m1.y,2))
		m2 = sqrt(pow(m2.x,2)+pow(m2.y,2))
		if m2 < m1 and s != Vector2i(0,0):
			ideal = Vector2(s) + getMyself().getPos()
			print("AAAAH: ", ideal)
		print(ideal)
		p = ideal
		p -= getMyself().getData().getFacing()
		nextAttack = RatCharge.new(1,getMyself())
	elif t > lim and (d.x == 0 or d.y == 0):
		ideal = getTarget().getPos()
		getMyself().getData().setFacing(findLoco(getTarget().getPos()))
		var s = Overseer.closestLOS(Vector2i(getMyself().getPos()), Vector2i(getMyself().getData().getFacing()),Vector2i(0,0), 'fiend')
		var m1 = Vector2(ideal) - getMyself().getPos()
		var m2 = Vector2(s)
		m1 = sqrt(pow(m1.x,2)+pow(m1.y,2))
		m2 = sqrt(pow(m2.x,2)+pow(m2.y,2))
		if m2 < m1 and s != Vector2i(0,0):
			print('RED FLAG')
			print(s)
			ideal = Vector2(s) + getMyself().getPos()
		p = ideal
		p -= getMyself().getData().getFacing()
		print('p ',p)
		nextAttack = RatCharge.new(1,getMyself())
	else:
		getMyself().getData().setFacing(findLoco(getTarget().getPos()))
		nextAttack = RatSlash.new(2,getMyself())
	nextAttack.warn()
	getMyself().getData().setActions(0)
	getMyself().chooseState()
	getMyself().draw()
	getMyself().setDelay(0.3)

# Function that checks if the rat is in a tile next to the player
func isNext(mPos: Vector2, tPos: Vector2) -> bool:
	var dif = tPos - mPos
	if abs(dif.x +dif.y) == 1:
		return true
	return false
		

# Function that tells the rat where it should move to
func move() -> void:
	# Variables
	print('starting position', getMyself().getPos())
	getMyself().getData().setActions(getMyself().getData().getActions()-1)
	var g = getGrid().getGrid()
	var b = getGrid()
	var m = getMyself()
	var mPos = m.getPos()
	var tPos = position
	var chosen = Vector2(0,0)
	
	# Initialise a list of possible positions, and an array representing
	# The final options of positions to move to
	var pPos = [mPos + Vector2(1,0), mPos + Vector2(-1,0), mPos + Vector2(0,1), mPos + Vector2(0,-1)]
	var fPos = []
	
	# Calculate what direction to move to be closer to the target.
	var bestCase = tPos - mPos
	var nextBest = []
		
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
	chooseFX()
	getMyself().getData().setFacing(chosen)
	getMyself().chooseState()
	getMyself().draw()
	getMyself().add_child(preload("res://scenes/Particles/slimey_step.tscn").instantiate())
	getMyself().setDelay(0.75)

func chooseFX():
	AudioManager.play_sound('TinyStep' + str(rng.randi_range(1,3)))

# Function that performs the attack operations
func attack() -> void:
	getMyself().setDelay(1.75)
	nextAttack.attack() # The Attack class performs it's code 
	EventBus.stop_warn.emit()

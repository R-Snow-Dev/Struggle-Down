extends RefCounted
class_name PushPuzzleMulti

var b = preload("res://scenes/DungeonParts/button.tscn")
var w = preload("res://scenes/Tiles/Wall.tscn")
var p = preload("res://scenes/DungeonParts/pushable.tscn")
var rng: RandomNumberGenerator
var extras = []
var numE: int
var gridSize: Vector2
var obj = []
var startPos: Vector2
var endPos: Vector2
var avoidables = []
var finalPath = []

func _init(r: RandomNumberGenerator) -> void:
	rng = r
	numE = rng.randi_range(2,4)
	gridSize = Vector2(3+numE, 3+numE)
	genWalls()
	placeExtras()
	try()
	adjust()
	finish()
	
func isAdjacent(cPos: Vector2) -> bool:
	for x in range(-1,2):
		for y in range(-1,2):
			if checkAtPos(cPos + Vector2(x,y)):
				return true
	return false
	
func genWalls() -> void:
	for x in numE * 2:
		var pos
		var toggle = true
		while toggle:
			pos = Vector2(rng.randi_range(0,gridSize.x - 1), rng.randi_range(0,gridSize.y - 1))
			toggle = isAdjacent(pos)
		var wall = w.instantiate()
		wall.setup(pos)
		avoidables.append(pos)
		obj.append(wall)
			

func placeExtras() -> void:
	for x in numE - 1:
		var pos
		var toggle = true
		while toggle:
			pos = Vector2(rng.randi_range(1,gridSize.x - 3), rng.randi_range(1,gridSize.y - 3))
			toggle = checkAtPos(pos)
			if not isWithin(pos, gridSize):
				toggle = true
		var extra = p.instantiate()
		extra.setup(pos)
		avoidables.append(pos)
		extras.append(extra)

func try() -> void:
	var toggle = true
	while toggle:
		startPos = Vector2(rng.randi_range(1,gridSize.x - 2), rng.randi_range(1,gridSize.y - 2))
		toggle = checkAtPos(startPos)
		if not isWithin(startPos, gridSize):
			toggle = true
	toggle = true
	while toggle:
		endPos = Vector2(rng.randi_range(0,gridSize.x - 1), rng.randi_range(0,gridSize.y - 1))
		toggle = checkAtPos(endPos)
		if not isWithin(startPos, gridSize):
			toggle = true
	
	toggle = false
	var amount = 0
	while amount < 10 and toggle == false:
		finalPath = [startPos]
		toggle = test(startPos, endPos, startPos)
		amount += 1
	if amount > 9 and toggle == false:
		try()
		

func test(sP: Vector2, eP: Vector2, pP: Vector2):
	if eP == sP:
		if finalPath.size() < 3:
			return false
		var button = b.instantiate()
		var s = p.instantiate()
		s.setup(startPos)
		button.setup(endPos)
		obj.append(button)
		obj.append(s)
		return true
	else:
		var moves = possibleMoves(sP, pP)
		if moves.size() < 1:
			return false
		elif moves.size() == 1 and moves[0] == pP:
			return false
		else:
			var newMove = moves[rng.randi_range(0, moves.size()-1)]
			if sP + newMove == startPos:
				return false
			else:
				finalPath.append(sP + newMove)
				return test(sP + newMove, endPos, sP)
		
func possibleMoves(cPos: Vector2, pPos) -> Array:
	var adjacents = [Vector2(0,1), Vector2(0,-1), Vector2(1,0), Vector2(-1,0)]
	var moves = []
	for x in adjacents:
		if not checkAtPos(cPos + x) and not checkAtPos(cPos - x) and isWithin(cPos+x, gridSize) and isWithin(cPos-x, gridSize) and (cPos + x) != pPos:
			moves.append(x)
	return moves

func pAdjust(cPos:Vector2) -> Array:
	var adjacents = [Vector2(0,1), Vector2(0,-1), Vector2(1,0), Vector2(-1,0)]
	var moves = []
	for x in adjacents:
		if not(checkAtPos(cPos + x) or checkAtPos(cPos + x + x)) and isWithin(cPos + x, gridSize):
			moves.append(x)
	return moves

func adjust() -> void:
	for x in extras:
		var totalMoves = []
		var pos = x.pos
		var moves = pAdjust(pos)
		if moves.size() > 0:
			for m in moves:
				var nMoves = pAdjust(pos + m)
				for i in range(0, nMoves.size()):
					nMoves[i] = nMoves[i] + m
				totalMoves += nMoves
		if totalMoves.size() > 0:
			x.pos = totalMoves[rng.randi_range(0, totalMoves.size()-1)]
		obj.append(x)
				
func finish() -> void:
	for o in obj:
		o.pos += Vector2(1,1)
		
	
func getSign(n) -> int:
	if n < 0:
		return -1
	else:
		return 1

func getObj() -> Array:
	return obj

func isWithin(v1: Vector2, v2: Vector2) -> bool:
	if v1.x >= 0 and v1.x < v2.x and v1.y >= 0 and v1.y < v2.y:
		return true
	return false

func checkAtObj(pos: Vector2) -> bool:
	for i in avoidables:
		if i == pos:
			return true
	return false

func checkAtPos(pos: Vector2) -> bool:
	for i in avoidables:
		if i == pos:
			return true
	return false

extends Node2D

var grid: Array
var objects: Array
var board: gameBoard
var control: DungeonController

func setObj(obj: Array) -> void:
	objects = obj

func setController(c: DungeonController) -> void:
	control = c

func setBoard(b: gameBoard) -> void:
	board = b

func setGrid(g:Array) -> void:
	grid = g
	
func getGrid() -> Array:
	return grid

func getController() -> DungeonController:
	return control

func getObj() -> Array:
	return objects

func getBoard() -> gameBoard:
	return board

func getDiff(pos1: Vector2i, pos2: Vector2i) -> Vector2i:
	return pos1 - pos2

func getAbsSum(pos: Vector2i) -> int:
	return abs(pos.x) + abs(pos.y)

func hasInt(pos: Vector2i, i: int) -> bool:
	if pos.x == i or pos.y == i:
		return true
	return false

func closestLOS(sPos: Vector2i, dir: Vector2i = Vector2i(0,0), bounds: Vector2i = Vector2i(0,0), ignore: String = "none"):
	var closest: Vector2i = Vector2i(100,100)
	for x in range(bounds.x, bounds.y+1):
		for obj in getObj():
			var c = Vector2i(obj.getPos())
			var diff = getDiff(c, sPos)
			if hasInt(diff, x) and c != sPos and obj is not Barrier and obj is not Door and ((diff.x + diff.y) * (dir.x+dir.y) > 0) and obj.myName() != ignore:
				if getAbsSum(dir) != 0:
					if getAbsSum(closest) >= (getAbsSum(diff) - abs(x)) and hasInt(Vector2i(diff + dir), x):
						closest = diff
				else:
					if getAbsSum(closest) >= (getAbsSum(diff) - abs(x)) :
						closest = diff
	if closest == Vector2i(100,100):
		return Vector2i(0,0)
	else:
		return closest

func closestByTarget(t: String, sPos: Vector2i) -> Vector2i:
	var closest = Vector2i(100,100)
	for obj in getObj():
		if obj.myName() == t:
			var c = Vector2i(obj.getPos())
			var diff = getDiff(c, sPos)
			if getAbsSum(closest) >= getAbsSum(diff):
				closest = diff
	if closest == Vector2i(100,100):
		return Vector2i(0,0)
	else:
		return closest
			
	

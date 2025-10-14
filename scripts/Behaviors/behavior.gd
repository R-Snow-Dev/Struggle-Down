extends RefCounted
class_name Behavior

'''
Super class for all enemy AI
'''

# Variables
var target: Player
var myself: Node
var grid: gameBoard
var rng = RandomNumberGenerator.new()

# Helper functions
func getSign(num: int):
	if num == 0:
		return 1
	return num/abs(num)
	
func checkPassable(obj) -> bool:
	if obj is Item or obj is Interactable or obj is Ladder or obj is Door:
		return true
	return false

# Constructor
func _init() -> void:
	pass
# "set" functions for all the variables
func setMyself(s: Node):
	myself = s
	
func setTarget(p: Player):
	target = p

func setGrid(g: gameBoard) -> void:
	grid = g

# "get" functions for all the variables
func getMyself() -> Node:
	return myself
	
func getTarget() -> Player:
	return target
	
func getGrid() -> gameBoard:
	return grid

# Functions that will bee overriden by child classes
func think() -> void:
	pass

func move() -> void:
	pass
	
func attack() -> void:
	pass
	

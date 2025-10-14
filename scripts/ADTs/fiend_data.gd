extends RefCounted
class_name FiendData

"""
Class that contains all the necessary data of a Fiend
"""

# Variables
var pos: Vector2 # Position off the Fiend on the gameBoard
var startPos: Vector2 # Initial position of the Fiend on the gameBoard
var health: int # HP of the Fiend
var totHealth: int # Max HP of the fiend
var goldRange: Vector2 # A Vector2 conating the minimum and maximum possible gold drop amount
var dam: int # The amount of dammage the Fiend deals to the player on hit
var behavior: RefCounted # The AI calculations governing the Fiend's actions
var facing: Vector2 # The direction the Fiend is facing, in Vector2 format
var actions: int # The amount of action the fiend takes before ending it's turn
var maxActions: int # The max amount of action the fiend has before moving

# Constructor
func _init(p: Vector2, h: int, a: int, gR: Vector2, d: int, f: Vector2, b: RefCounted) -> void:
	pos = p
	startPos = p
	health = h
	totHealth = h
	goldRange = gR
	dam = d
	facing = f
	behavior = b
	actions = a
	maxActions = a

# Set's the Fiend back to it's inital position and HP (for puzzles)
func reset():
	setPos(getStartPos())
	setHealth(getTotHealth())
	
# Resets the Fiend's available actions back to the max
func restoreActions():
	setActions(getMaxActions())

# "get" and "set" functions for the variables
func getPos() -> Vector2:
	return pos
	
func setPos(p: Vector2) -> void:
	pos = p

func getStartPos() -> Vector2:
	return startPos

func getHealth() -> int:
	return health

func updateHealth(num: int) -> void:
	health += num

func setHealth(num: int) -> void:
	health = num

func fullHeal() -> void:
	health = totHealth
	
func getTotHealth() -> int:
	return totHealth	

func getActions() -> int:
	return actions
	
func setActions(num: int) -> void:
	actions = num
	
func getMaxActions() -> int:
	return maxActions
	
func setMaxActions(num: int) -> void:
	maxActions = num
	
func getGoldRange() -> Vector2:
	return goldRange

func setGoldRange(r: Vector2) -> void:
	goldRange = r
	
func getDam() -> int:
	return dam
	
func setDam(amount: int) -> void:
	dam = amount
	
func getFacing() -> Vector2:
	return facing
	
func setFacing(dir: Vector2) -> void:
	facing = dir
	
func getBehavior() -> RefCounted:
	return behavior
	
func setBehavior(b: RefCounted) -> void:
	behavior = b

# This function calls the goven behavior to do it's calculations based on a 
# given game board and player position
func think(grid: gameBoard, target: Player) -> void:
	getBehavior().setTarget(target)
	getBehavior().setGrid(grid)
	getBehavior().think()
	

	
	

extends Node2D
class_name Fiend

"""
Super class for all Fiend data types
"""

# Variables
var data: FiendData
var states: Array
var curState: String
var rng = RandomNumberGenerator.new()
var delay: float = 0
var pos: Vector2

# "set" and "get" functions for the variables
func setDelay(time:float) -> void:
	delay = time

func getDelay() -> float:
	return delay

func setData(p: Vector2, h: int, a: int, gR: Vector2, d: int, f: Vector2, b: RefCounted) -> void:
	data = FiendData.new(p, h, a, gR, d, f, b)

func setStates(s: Array) -> void:
	states = s
	
func setCurState(s: String) -> void:
	curState = s
	
func setPos(p: Vector2) -> void:
	pos = p	
	
func getData() -> FiendData:
	return data

func getPos() -> Vector2:
	return pos

func getStates() -> Array:
	return states
	
func getCurState() -> String:
	return curState

# Resets the available actions of the Fiend to the max amount
func restoreActions():
	getData().restoreActions()

# Checks to see if the Fiend's hp is less than 1
func isDead() -> bool:
	if getData().getHealth() < 1:
		return true
	return false

# Functions to be overridden by the child classes
func chooseState() -> void:
	pass
	
func move(_grid: gameBoard, _target: Player) -> void:
	pass


# Draws the Fiend to the game board
func draw() -> void:
	# code that converts the Vector2 position data into on-screen coordinates
	position.x = getData().getPos().x*16
	position.y =getData().getPos().y*16 - 4
	self.z_index = (getData().getPos().y + 1)

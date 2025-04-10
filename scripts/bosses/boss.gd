'''
Default Class for all boss-types
'''

extends Node2D
class_name Boss

# Variables
var pos: Vector2 # The position of the boss
var prevPos = pos
var facing: Vector2
var vision: Array # What grid the boss sees
var brain: bossAI # What types of attacks the boss may perform, and what determines it
var HP: int # The amount of hitpoints the boss has
var sprite: Node # The sprite of the boss
var nextMove = 0
var size: int
@onready var timer = $Timer # Timer 
@onready var animPlayer = $AnimationPlayer # Animation Player

func setup(p: Vector2, vis: Array, b: bossAI, hp: int, s: PackedScene, sz: int):
	pos = p
	vision = vis
	brain = b
	HP = hp
	sprite = s.instantiate()
	size = sz
	
	sprite.position.y -= 4
	add_child(sprite)
	return self

func _process(delta: float) -> void:
	sprite.facing = facing
	if HP < 1:
		die()	
		
func updateView(playerPos: Vector2):
	return brain.updateView(vision, playerPos, self)[0]
	
func move(board: Array, playerPos: Vector2):
	timer.wait_time = 0.5
	vision = updateView(playerPos)
	brain.decide(self, playerPos, vision, board)
	timer.start()
	
func draw():
	position.x = pos.x*16 + size*4
	position.y = pos.y*16 + (size*4 + 2)
	self.z_index = (pos.y + 1)

func die():
	EventBus.object_ded.emit(self)
	
func positionToPos():
	# Converts on-screen position to internal position
	var newP = position - Vector2(8,8)
	newP = newP / 16
	pos = newP
	draw()
	
func _on_timer_timeout() -> void:
	timer.stop()
	EventBus.doneAttacking.emit() # Tells the Game controller that it is finished moving

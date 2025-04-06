extends Node2D
class_name Fiend

var pos: Vector2
var atk: AttackBehavior
var health: int
var brain: Object
var facing: String
var sprite = Node
@onready var timer = $Timer

func setup(p: Vector2, s: PackedScene, hp: int, b: EnemyBehavior, a: AttackBehavior):
	# Function that must be called after creating an instance, so that its characteristics may be given to it
	# param - p: The position of the fiend in Vector2 form
	# param - s: The sprite of the fiend, in packedScene form
	# param - hp: The amount of hit points the fiend will have
	pos = p
	sprite = s.instantiate()
	health = hp
	sprite.health = health
	brain = b
	atk = a

	# Adds the sprite to the scene tree, giving the fiend a sprite
	sprite.position.y -= 4
	add_child(sprite)

func _process(delta: float) -> void:
	health = sprite.health
	if health < 1:
		EventBus.object_ded.emit(self)
	
func checkFacing(targetPos: Vector2):
	# Function that checks to make sure the way it is facing is toward the player
	# param - targetPos: The player's coordinates in Vector2 format
	# returns: true or false
	if facing == "up":
		if (abs(pos.y - targetPos.y) >= abs(pos.x-targetPos.x)) and (pos.y - targetPos.y < 0):
			return true
	elif facing == "down":
		if (abs(pos.y - targetPos.y) >= abs(pos.x-targetPos.x)) and (pos.y - targetPos.y > 0):
			return true
	elif facing == "right":
		if (abs(pos.y - targetPos.y) < abs(pos.x-targetPos.x)) and (pos.x - targetPos.x < 0):
			return true
	elif facing == "left":
		if (abs(pos.y - targetPos.y) < abs(pos.x-targetPos.x)) and (pos.x - targetPos.x > 0):
			return true
	else:
		return false

func move(gameBoard: Array, playerPos: Vector2):
	var stepParticles = preload("res://scenes/Particles/slimey_step.tscn").instantiate() # Instantiates the particles for moving
	# Function that changes the fiend's position based on it's given AI pathfinding
	
	# If the slime is already next to the player, ATTACK!!!
	if (abs(pos - playerPos).x <= 1 and abs(pos - playerPos).y == 0) or (abs(pos - playerPos).x == 0 and abs(pos - playerPos).y <= 1):
		brain.findFacing(pos, playerPos, self)# Double check it's facing the correct way, only works if the fiends have a imtegrated findFacing() method
		if checkFacing(playerPos): # If the fiend is facing towards the player
			atk.attack(self) # Attck him
			timer.wait_time = 0.5 # Make the player wait 0.5 second before moving after you move
			timer.start()
		else:
			EventBus.doneAttacking.emit() # if not, do nothing. Will change in the futur
		
		
	else:
		pos += brain.pathFind(gameBoard, pos, playerPos, self) # Change your position based on your given A
		add_child(stepParticles) # Make the stepping particles
		stepParticles.z_index -= 1
		stepParticles.restart()
		timer.wait_time = 0.5 # Make the player wait 0.5 second before moving after you move
		timer.start()
	
func draw():
	sprite.dam = atk.dam
	# code that converts the Vector2 position data into on-screen coordinates
	position.x = pos.x*16
	position.y = pos.y*16
	self.z_index = (pos.y + 1)
	


func _on_timer_timeout() -> void:
	# function that triggers after the player has waited for 0.5 seconds after the fiend performs their actions
	timer.stop()
	EventBus.doneAttacking.emit() # Tells the Game controller that it is finished moving

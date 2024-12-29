extends Area2D
class_name Fiend

var pos: Vector2
var atk: AttackBehavior
var health: int
var brain: Object
var facing: String
var sprite = Node
@onready var timer = $Timer
@onready var step = $slimeyStep

func setup(p: Vector2, s: PackedScene, hp: int, b: EnemyBehavior):
	# Function that must be called after creating an instance, so that its characteristics may be given to it
	# param - p: The position of the fiend in Vector2 form
	# param - s: The sprite of the fiend, in packedScene form
	# param - hp: The amount of hit points the fiend will have
	pos = p
	sprite = s.instantiate()
	health = hp
	brain = b

	# Adds the sprite to the scene tree, giving the fiend a sprite
	add_child(sprite)
	
	
func move(gameBoard: Array, playerPos: Vector2):
	var stepParticles = preload("res://scenes/Particles/slimey_step.tscn").instantiate() # Instantiates the particles for moving
	# Function that changes the fiend's position based on it's given AI pathfinding
	
	# If the slime is already next to the player, do not move
	if (abs(pos - playerPos).x <= 1 and abs(pos - playerPos).y == 0) or (abs(pos - playerPos).x == 0 and abs(pos - playerPos).y <= 1):
		EventBus.doneAttacking.emit()
	else:
		pos += brain.pathFind(gameBoard, pos, playerPos) # Change your position based on your given A
		add_child(stepParticles) # Make the stepping particles
		stepParticles.z_index -= 1
		stepParticles.restart()
		timer.wait_time = 0.5 # Make the player wait 0.5 second before moving after you move
		timer.start()
	
func draw():
	# code that converts the Vector2 position data into on-screen coordinates
	position.x = pos.x*16
	position.y = pos.y*16 + 4
	self.z_index = (pos.y + 1)
	


func _on_timer_timeout() -> void:
	# function that triggers after the player has waited for 0.5 seconds after the fiend performs their actions
	timer.stop()
	EventBus.doneAttacking.emit() # Tells the Game controller that it is finished moving

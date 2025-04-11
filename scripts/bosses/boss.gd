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
var maxHP: int
@onready var timer = $Timer # Timer 
@onready var animPlayer = $AnimationPlayer # Animation Player
@onready var bP = $BashParts
@onready var cP = $ChargeParts
@onready var hurtbox = $body/Hurtbox

func setup(p: Vector2, vis: Array, b: bossAI, hp: int, s: PackedScene, sz: int):
	pos = p
	vision = vis
	brain = b
	HP = hp
	maxHP = HP
	sprite = s.instantiate()
	size = sz
	EventBus.healSK.connect(heal)
	
	sprite.position.y -= 4
	add_child(sprite)
	return self

func heal(num: int):
	# Heals the boss when called. Fails to heal if already at Full HP
	if HP < maxHP:
		if maxHP - HP > 4:
			HP += num
		else:
			HP += maxHP - HP

func _process(delta: float) -> void:
	hurtbox.scale = Vector2(size,size)
	if HP < 1:
		die()	
		
func updateView(playerPos: Vector2):
	return brain.updateView(vision, playerPos, self)[0]
	
func move(board: Array, playerPos: Vector2):
	# Function that tells the given AI to perform the boss's move
	# @param board - The current gameBoard
	# @param playerPos - The index of the player of the game board
	timer.wait_time = 0.5
	vision = updateView(playerPos)
	brain.decide(self, playerPos, vision, board)
	timer.start()
	
func draw():
	# Function that takes the pos variable of the boss and converts it into
	# on-screen coordinates
	position.x = pos.x*16 + size*4
	position.y = pos.y*16 + (size*4 + 4)
	self.z_index = (pos.y + 1)

func toggleSprite():
	# Function that turns on or off the sprite when needed
	sprite.visible = !sprite.visible

func die():
	# Function that emits all necessary signals upon death
	EventBus.create_stairs.emit(Vector2(5,5))
	EventBus.object_ded.emit(self)
	
func positionToPos():
	# Converts on-screen position to internal position
	var newP = position - Vector2(size*4,size*4 + 4)
	newP = newP / 16
	pos = newP
	draw()
	
func charge():
	# Function that is called during a boss's charge attack
	# Toggles the charge hitbox, and emits the charge particles
	sprite.toggleCDetection()
	cP.emitting = !cP.emitting
	
func jump():
	# Function that is called during a boss's jump attack
	# Toggles the charge jump hitbox.
	sprite.toggleJDetection()

func spread():
	# Function that is called if a boss needs a spread hitbox
	# Toggles the spread hitbox
	sprite.toggleSDetection()

func crash():
	# Function that is called to emit the crash particles
	bP.emitting = true

func s_jump():
	# Function that is called to play the boss prite's jump animation
	sprite.jump()

func _on_timer_timeout() -> void:
	# When the timer runs out, that means the boss has finishe dtheir turn, and to
	# broacast that theu have finished moving to the dungeon controller
	timer.stop()
	EventBus.doneAttacking.emit() # Tells the Game controller that it is finished moving


func _on_body_area_entered(area: Area2D) -> void:
	# Function that handles the boss being hit by a weapon
	if area is Hurtbox: # If it made contact with something else, that means it has been attacked
		crash()
		HP -= area.damage

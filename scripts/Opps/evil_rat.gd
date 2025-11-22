extends Fiend
class_name EvilRat

"""
The Rat enemy
"""

# Variables
@onready var aParticles = $AttackParticles
@onready var anim = $Rat/AnimationPlayer
@onready var rat = $Rat

func playAnim(a: String):
	# Function that calla the animation player to play an animation
	# bsed on the given string "a"
	anim.play(a)

func _process(_delta: float) -> void:
	pos = getData().getPos()
	if isDead():
		EventBus.updateGold.emit(rng.randi_range(getData().getGoldRange().x, getData().getGoldRange().y))
		EventBus.object_ded.emit(self)
	
func move(grid: gameBoard, target: Player) -> void:
	# Function that gets the "behavior" from the given FiendData type
	# and calls it to do the AI calculations
	getData().getBehavior().setMyself(self) # sets the target of the calculations to itself
	getData().think(grid, target) # Performs the calcs
	getData().getBehavior().getGrid().loadGrid() # Reloads the board grid
	await get_tree().create_timer(getDelay()).timeout # Waits a 'lil bit
	playAnim("idle") # Reset the animation
	if getData().getActions() > 0: # Check to see if there anre any more actions it can take
		move(grid, target)
	else:
		EventBus.doneAttacking.emit() # Tell the board it is finished moving
		

func doSpriteAnim(a: String):
	# Function that sets the animations for the sprite
	rat = $Rat
	rat.play(a)

func chooseState() -> void:
	# Chooses what animations to play based on the direction it is facing
	var f = getData().getFacing()
	if f == Vector2(1,0):
		setCurState("s")
		rat.flip_h = false
	elif f == Vector2(-1,0):
		setCurState("s")
		rat.flip_h = true
	elif f == Vector2(0,1):
		setCurState("d")
		rat.flip_h = false
	elif f == Vector2(0,-1):
		setCurState("u")
		rat.flip_h = false
	else:
		rat.flip_h = false

func draw() -> void:
	super()
	doSpriteAnim(getCurState())
		
func _on_hit_box_area_entered(area: Area2D) -> void:
	# Function that either damages the player, or deals damage to itself depending
	# on what it collides with
	if area is Player:
		EventBus.update_hp.emit(-getData().getDam())
	elif area is Hurtbox:
		getData().updateHealth(-area.getWeaponData().getBaseDam())
	aParticles.emitting = true

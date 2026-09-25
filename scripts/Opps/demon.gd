extends Fiend
class_name Demon

"""
The Demon enemy
"""

# Variables
@onready var aParticles = $AttackParticles
@onready var anim = $Demon/AnimationPlayer
@onready var demon = $Demon

func playAnim(a: String):
	# Function that calla the animation player to play an animation
	# bsed on the given string "a"
	anim.play(a)

func _process(_delta: float) -> void:
	pos = getData().getPos()
	if isDead():
		if !paid:
			paid = true
			if UpgradeList.maxDrops:
				EventBus.updateGold.emit(getData().getGoldRange().y)
			else:
				EventBus.updateGold.emit(rng.randi_range(getData().getGoldRange().x, getData().getGoldRange().y))
		Overseer.getBoard().nextGuy()
		Overseer.getController().unlockRelic(14)
		EventBus.object_ded.emit(self)

func move(grid: gameBoard, target: Player) -> void:
	# Function that gets the "behavior" from the given FiendData type
	# and calls it to do the AI calculations
	activateEffects(0)
	if getData().getActions() > 0: # Check to see if there are any actions it can take
		getData().getBehavior().setMyself(self) # sets the target of the calculations to itself
		getData().think(grid, target) # Performs the calcs
		getData().getBehavior().getGrid().loadGrid() # Reloads the board grid
		await EventBus.get_tree().create_timer(getDelay()).timeout # Waits a 'lil bit
		activateEffects(1)
		if getData().getActions() > 0: # Check to see if there anre any more actions it can take
			move(grid, target)
		else:
			Overseer.getBoard().nextGuy() # Tell the board it is finished moving
	else:
		Overseer.getBoard().nextGuy() # Tell the board it is finished moving
		
func chooseState() -> void:
	# Chooses what animations to play based on the direction it is facing
	var f = getData().getFacing()
	if f == Vector2(1,0):
		setCurState("s")
		demon.play('s')
		demon.flip_h = true
	elif f == Vector2(-1,0):
		setCurState("s")
		demon.play('s')
		demon.flip_h = false
	elif f == Vector2(0,1):
		setCurState("d")
		demon.play('d')
		demon.flip_h = false
	elif f == Vector2(0,-1):
		setCurState("u")
		demon.play('u')
		demon.flip_h = false
	else:
		demon.flip_h = false

func draw() -> void:
	super()
	position.y -= 14


func _on_hit_box_area_entered(area: Area2D) -> void:
	# Function that either damages the player, or deals damage to itself depending
	# on what it collides with
	onHit(area)
	aParticles.emitting = true

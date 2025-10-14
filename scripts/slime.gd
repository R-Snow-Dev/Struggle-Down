extends Fiend
class_name Slime

"""
Class that represents a Slime
"""

# Variables
@onready var aParticles = $AttackParticles
@onready var step = $slimeyStep
@onready var anim = $Slime/atkAnims

# Runs every process frames
func _process(_delta: float) -> void:
	pos = getData().getPos()
	if isDead():
		EventBus.updateGold.emit(rng.randi_range(getData().getGoldRange().x, getData().getGoldRange().y))
		EventBus.object_ded.emit(self)

# Function taht plays an animation based on the given String
func playAnim(a: String):
	anim.play(a)
	
# Function that performs the necessary AI calculation forr the slime to move
func move(grid: gameBoard, target: Player) -> void:
	getData().getBehavior().setMyself(self) # Sets the targetyt of the AI calculations to itself
	getData().think(grid, target) # Tells the AI class to perform it's operations
	getData().getBehavior().getGrid().loadGrid() # Redraws the grid
	await get_tree().create_timer(getDelay()).timeout # Waits a lil bit
	if getData().getActions() > 0: # Chhecks to see if it has any actions left to perform
		move(grid, target) # If so, do it again
	else:
		EventBus.doneAttacking.emit() # Otherwise, tell the board that ur done


func chooseState() -> void:
	pass

# Function that eiterh deals damage to the player, or damages itself, based on
# what the slime collided with
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Player:
		EventBus.update_hp.emit(-getData().getDam())	
	elif area is Hurtbox:
		getData().updateHealth(-area.getDamage())
	aParticles.emitting = true

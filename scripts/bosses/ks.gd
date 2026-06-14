extends BossNew
class_name KS

@onready var aParticles: CPUParticles2D = $BashParts
@onready var step: CPUParticles2D = $ChargeParts
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var hbox: Area2D =  $hitbox
@onready var eBox: Area2D = $eatbox
@onready var sprite: AnimatedSprite2D = $Kingslime


func _ready() -> void:
	setHbox(hbox)
	EventBus.healSK.connect(heal)

func _process(_delta: float) -> void:
	pos = getData().getPos()
	if isDead():
		if !paid:
			paid = true
			if UpgradeList.maxDrops:
				EventBus.updateGold.emit(getData().getGoldRange().y)
			else:
				EventBus.updateGold.emit(rng.randi_range(getData().getGoldRange().x, getData().getGoldRange().y))
		EventBus.doneAttacking.emit()
		EventBus.create_stairs.emit(Vector2(5,5))
		EventBus.object_ded.emit(self)


func heal():
	getData().updateHealth(5)

# Function taht plays an animation based on the given String
func playAnim(a: String):
	anim.play(a)

func slam() -> void:
	AudioManager.play_sound('KSLand')
	var wave: Area2D = preload("res://scenes/Opps/slam_wave.tscn").instantiate()
	add_child(wave)
	await get_tree().create_timer(0.1).timeout
	remove_child(wave)
	wave.queue_free()

func crash() -> void:
	AudioManager.stop_sound('KSCharge')
	AudioManager.play_sound('KSCrash')
	aParticles.emitting = true

func toggleCharge() -> void:
	step.emitting = !step.emitting

# Function that performs the necessary AI calculation forr the slime to move
func move(grid: gameBoard, target: Player) -> void:
	activateEffects(0)
	if getData().getActions() > 0:
		getData().getBehavior().setMyself(self) # Sets the target of the AI calculations to itself
		getData().think(grid, target) # Tells the AI class to perform it's operations
		getData().getBehavior().getGrid().loadGrid() # Redraws the grid
		await get_tree().create_timer(getDelay()).timeout # Waits a lil bit
		if getData().getActions() > 0: # Chhecks to see if it has any actions left to perform
			move(grid, target) # If so, do it again
		else:
			EventBus.doneAttacking.emit() # Otherwise, tell the board that ur done
			activateEffects(1)
	else:
			EventBus.doneAttacking.emit() # Otherwise, tell the board that ur done
			activateEffects(1)

func j() -> void:
	sprite.play("jump")
	AudioManager.play_sound('KSJump')
	await sprite.animation_finished
	sprite.play("Idle")
	

func toggleEat() -> void:
	eBox.monitoring = !eBox.monitoring
	eBox.monitorable = !eBox.monitorable

func chooseState() -> void:
	pass

# Function that eiterh deals damage to the player, or damages itself, based on
# what the slime collided with
func _on_hitbox_area_entered(area: Area2D) -> void:
	onHit(area)
	aParticles.emitting = false
	crash()

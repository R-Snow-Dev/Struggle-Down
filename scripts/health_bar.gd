"""
Code that renders a heathbar in the top right of the GUI
"""

extends Label

# Variables
var totalHP: int = 0
var yPos = 2100
var curHP: int = 0
var rng = RandomNumberGenerator.new()
@onready var health_bar_faded: Label = $HealthBarFaded
@onready var animation_player: AnimationPlayer = $AnimationPlayer
	
func updateTotalHP(data: int) -> void:
	totalHP += data
	setHealthBar(totalHP)
	

func setHealthBar(tHP: int):
	# Function that places the healthbar in a position that centers the amount of hearts you have in the top right
	# param - tHP: the total amount of HP the player has
	totalHP = tHP
	curHP = totalHP
	if totalHP < 10:
		position.x = -290 - ((10*9) - (totalHP*9))
	else:
		position.x = -290 - ((10*9) - (10*9))
	# Create a shadowed version of the health bar below the main onw, so taht when hp is lost, you can see how much you lost
	health_bar_faded.loadHearts(totalHP)
	
	
func _update_hp(amount: int):
	# Function that updates the heath bar upon damage or healing
	chooseFX()
	if amount + curHP <= 0:
		curHP = 0
	else:
		curHP += amount
	animation_player.play("shake")
	
func chooseFX():
	var n = rng.randi_range(1,3)
	AudioManager.play_sound('Hit' + str(n))

func displayHP():
	# Creates the amount of hearts depending on how much current HP the player has
	var displayedHearts = ""
	for i in range(curHP/2):
		displayedHearts += "AB"
	if curHP%2 != 0:
		displayedHearts += "A"
	self.text = displayedHearts
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.update_hp.connect(_update_hp)
	EventBus.update_total_hp.connect(updateTotalHP)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Always render the updated healthbar
	displayHP()

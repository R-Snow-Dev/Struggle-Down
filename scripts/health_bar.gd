"""
Code that renders a heathbar in the top right of the GUI
"""

extends Label

# Variables
var defaultX = -390
var yPos = 2100
var curHP: int = 0
@onready var health_bar_faded: Label = $HealthBarFaded
@onready var animation_player: AnimationPlayer = $AnimationPlayer



func setHealthBar(totalHP: int):
	# Function that places the healthbar in a position that centers the amount of hearts you have in the top right
	# param - totalHP: the total amount of HP the player has
	curHP = totalHP
	# If total HP is above 10, just default it back to 10 as at that point the rendered hearts will wrap around the text box
	if totalHP >= 10:
		defaultX += 10.5 * 10
	else:
		defaultX += 10.5 * totalHP
	# Create a shadowed version of the health bar below the main onw, so taht when hp is lost, you can see how much you lost
	health_bar_faded.loadHearts(totalHP)
	
	
func _update_hp(amount: int):
	# Function taht updates the heath bar upon damage or healing
	if amount + curHP <= 0:
		curHP = 0
	else:
		curHP += amount
	animation_player.play("shake")

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
	position.x = defaultX
	position.y = yPos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Always render the updated healthbar
	displayHP()
	position.x = defaultX
	position.y = yPos

'''
Code that displays the amount of gold the player has.
'''

extends Label

var  curDisplayed = SaveController.getData("gold") # Default amount displayed
@onready var animationPlayer = $TextShaker# Preps the animation player

# Connects to all the Event Bus signals that it requires
func _ready() -> void:
	self.text = str(curDisplayed) # Updates the label's text
	EventBus.save_data.connect(_save_gold)
	EventBus.updateGold.connect(_updateGold)
	
func _updateGold(amount:int):
	# Function that changes how much the current number displayed is. Then playes a short animation.
	# param - amount: An integer given when the updateAction signal is emitted. Its the amount the displayed number will change. Typically negative
	
	print("done Deal")
	curDisplayed += amount # Changes the current number displayed
	self.text = str(curDisplayed) # Updates the label's text
	animationPlayer.play("Change Number") # Plays a sort "bounce" animation for emphasis

func _save_gold():
	SaveController.updateData("gold", curDisplayed)

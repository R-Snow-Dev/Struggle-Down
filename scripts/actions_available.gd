extends Label
class_name ActionLabel

var  curDisplayed = 0 # Default amount displayed
@onready var animationPlayer = $"Text Shaker" # Preps the animation player

# Connects to all the Event Bus signals that it requires
func _ready() -> void:
	EventBus.updateActions.connect(_updateActions)
	EventBus.actionsReset.connect(_resetActions)
	
func _updateActions(amount:int):
	# Function that changes how much the current number displayed is. Then playes a short animation.
	# param - amount: An integer given when the updateAction signal is emitted. Its the amount the displayed number will change. Typically negative
	
	curDisplayed += amount # Changes the current number displayed
	self.text = str(curDisplayed) # Updates the label's text
	animationPlayer.play("Change Number") # Plays a sort "bounce" animation for emphasis
	
func _resetActions(amount: int):
	# Function that sets the displayed number to a desired number, then plays a short animation
	# param - amount: The amount the displayed numeber will be set to. Given when the "actionsReset" signal is emitted.
	
	curDisplayed = amount # Sets the displayed number to a desired amount
	self.text = str(curDisplayed) # Updates the label's text
	animationPlayer.play("Change Number") # Plays a sort "bounce" animation for emphasis

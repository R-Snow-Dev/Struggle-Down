'''
Code that handles the logic of the pouch menu. Curreently just has a button to start a new run.
Will implement more features later.
'''


extends Node2D

# Initialise variables
var isHovering = false
@onready var goCord = $goCord
@onready var goBox = $goCord/Area2D/CollisionShape2D
@onready var guy = $guy
@onready var pouch = $pouch_sprite
@onready var timing = $timing
@onready var consumeables = $ConsumableMenu

func _ready() -> void:
	# Play the opening animation on load
	goCord.visible = false
	consumeables.visible = false
	timing.play("open")
	
func _process(_delta: float) -> void:
	
	# If the cursor is hovering the button, and is left clicked, the button is pressed, so 
	# play the closing animation
	if isHovering:
		goCord.position.x = -150
		goBox.scale.y = 1.3
		goBox.position.x = 7
		if Input.is_action_just_pressed("select"):
			timing.play("close")
	else:
		goCord.position.x = -128
		goBox.scale.y = 1
		goBox.position.x = -8
			
			
func _on_area_2d_mouse_entered() -> void:
	# Update isHovering when the cursor is hovering over the "Go" button
	isHovering = true
	

func _on_area_2d_mouse_exited() -> void:
	# Update isHovering when the cursor stops hovering over the "Go" button
	isHovering = false
	
func close():
	# Function that makes the two animated sprites playb their closing animations at the same time
	guy.play("close")
	pouch.play("close")
	
func toggleCord():
	# Toggles the visibility of the "Go" button
	goCord.visible = !goCord.visible

func toggleMenus():
	consumeables.visible = !consumeables.visible

func go():
	# Tells the game to load the dungeon scene
	EventBus.go.emit()
	

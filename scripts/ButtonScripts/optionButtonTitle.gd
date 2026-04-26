"""
Script that handles the title screen's option button
"""

extends TileMapLayer
@onready var c = $buttonCollider/buttonColliderShape
# Variable that tracks when the mouse is hovering the button. Default is false
var isHovering = false

# Checks every frame if the button is hovered and if the mouse id clicked. If so, open options
func _process(_delta: float) -> void:
	if isHovering == true:
		if Input.is_action_just_pressed("select"):
			AudioManager.play_sound('Select')
			OptionMenu.visible = true
			c.position.y = 0
			position.y = 24

func _on_button_collider_mouse_entered() -> void:
	# Function that sets "isHovering" to true if the mouse touches the bounds of the button
	AudioManager.play_sound('Hover')
	isHovering = true
	c.position.y = 2
	position.y = 22
	

func _on_button_collider_mouse_exited() -> void:
	# Function that sets "isHovering" to false once the mouse leaves the bounds of the button
	isHovering = false
	c.position.y = 0
	position.y = 24

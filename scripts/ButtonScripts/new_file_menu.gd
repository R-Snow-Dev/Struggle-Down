"""
Script that handles the title screen's start button
"""

extends TileMapLayer

# Variable that tracks when the mouse is hovering the button. Default is false
var isHovering = false

# Checks every frame if the button is hovered and if the mouse id clicked. If so, start the game
func _process(delta: float) -> void:
	if isHovering == true:
		if Input.is_action_just_pressed("select"):
			EventBus.file_create.emit()

func _on_button_collider_mouse_entered() -> void:
	# Function that sets "isHovering" to true if the mouse touches the bounds of the button
	isHovering = true


func _on_button_collider_mouse_exited() -> void:
	# Function that sets "isHovering" to false once the mouse leaves the bounds of the button
	isHovering = false

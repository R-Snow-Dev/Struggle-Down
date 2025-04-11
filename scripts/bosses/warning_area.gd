"""
Class that creates flashing warning zones when a large attack calls for it
"""

extends Polygon2D

@onready var animPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animPlayer.play("flash")
	
func setBounds(p1: Vector2, p2:Vector2):
	# Sets the location and size of the warning zone based on a starting and end point
	# @param p1 - the first point of the warning zone in Vector2 format
	# @param p2 - the second point of the warning zone in Vector2 format
	var stretch = (p2-p1)
	var yS = Vector2(p1.y, p2.y)
	stretch *= 16
	self.z_index = findMinY(yS)
	position = p1 * 16
	scale = stretch
	
func findMinY(yS: Vector2):
	# Helper function that finds the smaller of two values on a Vector2
	# @param yS - the Vector2 containing two values
	if yS.x <= yS.y:
		return yS.x
	else:
		return yS.y
	
	

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
	
	await EventBus.get_tree().process_frame
	var stretch = abs(p1-p2) + Vector2(1,1)
	global_position = ((p1)+(p2))/2 * 16
	scale = stretch
	self.z_index = 0




func findMinY(yS: Vector2):
	# Helper function that finds the smaller of two values on a Vector2
	# @param yS - the Vector2 containing two values
	if yS.x <= yS.y:
		return yS.x
	else:
		return yS.y
	
	

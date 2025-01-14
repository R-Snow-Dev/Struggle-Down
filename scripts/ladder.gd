"""
Code for the ladder object that spawns in the exit rooms
"""

extends Sprite2D
class_name Ladder

# The coordinates of the ladder on the floor in Vector2 form
var pos: Vector2
var curLevel: int
var curFloor: int


func setup(p: Vector2, currentLevel: int, currentFloor: int):
	# Function that must be called after creating an instance, so that its characteristics may be given to it
	# param - p: The position of the ladder in Vector2 form
	pos = p
	curLevel = currentLevel
	curFloor = currentFloor

	

# While a ladder is an object, it cannot move, so it passes instead
func move():
	pass
	
func draw():
	# code that converts the Vector2 position data into on-screen coordinates
	position.x = pos.x*16
	position.y = pos.y*16
	self.z_index = (pos.y + 1)

func _on_ladder_trigger_area_entered(area: Area2D) -> void:
	EventBus.new_level.emit(curLevel, curFloor)

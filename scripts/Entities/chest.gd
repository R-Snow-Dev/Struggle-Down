extends Node2D
class_name Chest

@onready var sprite = $Display/Sprite2D

var pos: Vector2
var middle: Vector2

var opened: int = 0

func _ready() -> void:
	sprite.region_enabled = true
	draw()

func setup(p: Vector2, m: Vector2):
	# Function that must be called after creating an instance, so that its characteristics may be given to it
	# param - p: The position of the wall in Vector2 form
	pos = p
	middle = m
	
	return self

func myName() -> String:
	return "Chest"

func getPos() -> Vector2:
	return pos

# While a Wall is an object, it cannot move, so it passes instead
func move():
	pass

func open():
	if opened < 16:
		opened = 16
		Overseer.rollChest()
		draw()

func draw():
	# code that converts the Vector2 position data into on-screen coordinates
	sprite = $Display/Sprite2D
	position.x = pos.x*16
	position.y = pos.y*16 - 4
	self.z_index = (pos.y + 2)
	
	var dist = pos - middle
	var absDist = Vector2(abs(dist.x), abs(dist.y))
	
	if absDist.x >= absDist.y:
		if dist.x <= 0:
			sprite.region_rect = Rect2(Vector2(128 + opened, 64), Vector2(16,16))
		else:
			sprite.region_rect = Rect2(Vector2(128 + opened, 80), Vector2(16,16))
	else:
		if dist.y <= 0:
			sprite.region_rect = Rect2(Vector2(128 + opened, 48), Vector2(16,16))
		else:
			sprite.region_rect = Rect2(Vector2(128 + opened, 96), Vector2(16,16))

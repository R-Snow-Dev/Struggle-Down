extends Sprite2D
class_name Wall

var pos: Vector2

var rV 

func setup(p: Vector2):
	# Function that must be called after creating an instance, so that its characteristics may be given to it
	# param - p: The position of the wall in Vector2 form
	pos = p
	EventBus.rotateH.connect(_rotateH)
	EventBus.rotateV.connect(_rotateV)
	return self

func myName() -> String:
	return "wall"

func getPos() -> Vector2:
	return pos

# While a Wall is an object, it cannot move, so it passes instead
func move():
	pass
	
func draw():
	# code that converts the Vector2 position data into on-screen coordinates
	position.x = pos.x*16
	position.y = pos.y*16 - 8
	self.z_index = (pos.y + 2)
	
func _rotateV() -> void:
	pos = Vector2(pos.y, pos.x)

func _rotateH() -> void:
	pos = Vector2(pos.y, pos.x)

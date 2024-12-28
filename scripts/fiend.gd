extends Area2D
class_name Fiend

var pos: Vector2
var atk: AttackBehavior
var health: int
var brain: EnemyBehavior
var facing: String
var sprite = Node

func setup(p: Vector2, s: PackedScene, hp: int):
	# Function that must be called after creating an instance, so that its characteristics may be given to it
	# param - p: The position of the fiend in Vector2 form
	# param - s: The sprite of the fiend, in packedScene form
	# param - hp: The amount of hit points the fiend will have
	pos = p
	sprite = s.instantiate()
	health = hp

	# Adds the sprite to the scene tree, giving the fiend a sprite
	add_child(sprite)
	
	
func move():
	# Function that changes the fiend's position based on it's given AI pathfinding
	pos += brain.pathFind()
	
func draw():
	# code that converts the Vector2 position data into on-screen coordinates
	position.x = pos.x*16
	position.y = pos.y*16 + 4
	self.z_index = (pos.y + 1)
	

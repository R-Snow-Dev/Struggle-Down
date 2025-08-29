"""
This class represents all items that can be spawned on the board, NOT items that are bought from the shop
"""

extends Area2D
class_name Item

# Creates varibles for the class
const allItems: Array = [null, 
preload("res://scenes/Items/sword_1.tscn"), 
preload("res://scenes/Items/great_sword.tscn"),
preload("res://scenes/Items/mace.tscn"),
preload("res://scenes/Items/spear.tscn"),
preload("res://scenes/Items/halberd.tscn"),
preload("res://scenes/Items/stiletto.tscn")] # An array storing every possible item that can be found on the board

var sprite: Node
var pos: Vector2
var itemId:int

func setup(p: Vector2, Id: int):
	# Function that assigns all the variables their appropriate values, so the desired item spawns
	# param - p: The position of the spawned Item on the board, in Vector 2 format
	# param - Id: The item Id, also known as the index of the item in the "allItems" constant
	sprite = allItems[Id].instantiate()
	pos = p
	itemId = Id
	
	add_child(sprite)
	
# While a Item is an object, it cannot move, so it passes instead
func move():
	pass
	
func draw():
	# code that converts the Vector2 position data into on-screen coordinates
	position.x = pos.x*16
	position.y = pos.y*16 - 6
	self.z_index = (pos.y + 1)
	
# Code taht runs upon the player landing on the item object
func _on_area_entered(_area: Area2D) -> void:
	# Because the only items that spawn on the board currently are weapons, directly call the weapon slot to update what it displays
	EventBus.swap_weapon.emit(itemId)
	# Delete this instace of an Item
	EventBus.object_ded.emit(self)

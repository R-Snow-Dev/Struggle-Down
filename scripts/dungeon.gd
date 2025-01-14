'''
The Root node for the dungeon scene. All it needs to do is delete itself upon death
'''

extends Node2D

@onready var gamecontroller: Node = %Gamecontroller
var level = 1
var floor = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.on_death.connect(_on_death)
	gamecontroller.level = level
	gamecontroller.floor = floor
	
func _on_death():
	# Removes itself from any tree upon death
	queue_free()

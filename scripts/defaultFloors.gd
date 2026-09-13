'''
Class that containes all the default floor that are used in special places, such as boss rooms 
or vaults
'''

extends Node

var wall = preload("res://scenes/Tiles/Wall.tscn")

var v1 = preload("res://scenes/DungeonParts/RButtonV.tscn").instantiate()
var v2 = preload("res://scenes/DungeonParts/RButtonV.tscn").instantiate()
var h1 = preload("res://scenes/DungeonParts/RButtonH.tscn").instantiate()
var h2 = preload("res://scenes/DungeonParts/RButtonH.tscn").instantiate()

func _init() -> void:
	v1.setup(Vector2(2,0))
	v2.setup(Vector2(4,6))
	h1.setup(Vector2(0,4))
	h2.setup(Vector2(6,2))

# Sets up the King Slime Arena
var kSlime = [wall.instantiate().setup(Vector2(0,0)), wall.instantiate().setup(Vector2(0,1)), wall.instantiate().setup(Vector2(0,2)), wall.instantiate().setup(Vector2(0,3))
, wall.instantiate().setup(Vector2(1,0)), wall.instantiate().setup(Vector2(1,1)), wall.instantiate().setup(Vector2(1,2)), wall.instantiate().setup(Vector2(1,3))
, wall.instantiate().setup(Vector2(2,0)), wall.instantiate().setup(Vector2(2,1)), wall.instantiate().setup(Vector2(2,2)), wall.instantiate().setup(Vector2(2,3))
, wall.instantiate().setup(Vector2(3,0)), wall.instantiate().setup(Vector2(3,1)), wall.instantiate().setup(Vector2(3,2)),wall.instantiate().setup(Vector2(10,0))
, wall.instantiate().setup(Vector2(10,1)), wall.instantiate().setup(Vector2(10,2)), wall.instantiate().setup(Vector2(10,3))
, wall.instantiate().setup(Vector2(9,0)), wall.instantiate().setup(Vector2(9,1)), wall.instantiate().setup(Vector2(9,2)), wall.instantiate().setup(Vector2(9,3))
, wall.instantiate().setup(Vector2(8,0)), wall.instantiate().setup(Vector2(8,1)), wall.instantiate().setup(Vector2(8,2)), wall.instantiate().setup(Vector2(8,3))
, wall.instantiate().setup(Vector2(7,0)), wall.instantiate().setup(Vector2(7,1)), wall.instantiate().setup(Vector2(7,2)), wall.instantiate().setup(Vector2(0,10))
, wall.instantiate().setup(Vector2(0,9)), wall.instantiate().setup(Vector2(0,8)), wall.instantiate().setup(Vector2(0,7))
, wall.instantiate().setup(Vector2(1,10)), wall.instantiate().setup(Vector2(1,9)), wall.instantiate().setup(Vector2(1,8)), wall.instantiate().setup(Vector2(1,7))
, wall.instantiate().setup(Vector2(2,10)), wall.instantiate().setup(Vector2(2,9)), wall.instantiate().setup(Vector2(2,8)), wall.instantiate().setup(Vector2(2,7))
, wall.instantiate().setup(Vector2(3,10)), wall.instantiate().setup(Vector2(3,9)), wall.instantiate().setup(Vector2(3,8)), wall.instantiate().setup(Vector2(10,10))
, wall.instantiate().setup(Vector2(10,9)), wall.instantiate().setup(Vector2(10,8)), wall.instantiate().setup(Vector2(10,7))
, wall.instantiate().setup(Vector2(9,10)), wall.instantiate().setup(Vector2(9,9)), wall.instantiate().setup(Vector2(9,8)), wall.instantiate().setup(Vector2(9,7))
, wall.instantiate().setup(Vector2(8,10)), wall.instantiate().setup(Vector2(8,9)), wall.instantiate().setup(Vector2(8,8)), wall.instantiate().setup(Vector2(8,7))
, wall.instantiate().setup(Vector2(7,10)), wall.instantiate().setup(Vector2(7,9)), wall.instantiate().setup(Vector2(7,8))]

var altarRoom = [preload("res://scenes/Tiles/altar.tscn").instantiate().setup(Vector2(2,2)), preload("res://scenes/Tiles/barrier.tscn").instantiate().setup(Vector2(1,1)),
preload("res://scenes/Tiles/barrier.tscn").instantiate().setup(Vector2(3,3)), preload("res://scenes/Tiles/barrier.tscn").instantiate().setup(Vector2(1,3)),
preload("res://scenes/Tiles/barrier.tscn").instantiate().setup(Vector2(3,1))]

var vault = [preload("res://scenes/Tiles/chest.tscn").instantiate().setup(Vector2(0,1),Vector2(2,2)),preload("res://scenes/Tiles/chest.tscn").instantiate().setup(Vector2(0,3),
Vector2(2,2)),preload("res://scenes/Tiles/chest.tscn").instantiate().setup(Vector2(1,0),Vector2(2,2)), preload("res://scenes/Tiles/chest.tscn").instantiate().setup(Vector2(3,0),Vector2(2,2)),
preload("res://scenes/Tiles/chest.tscn").instantiate().setup(Vector2(4,1),Vector2(2,2)),preload("res://scenes/Tiles/chest.tscn").instantiate().setup(Vector2(4,3),
Vector2(2,2)),preload("res://scenes/Tiles/chest.tscn").instantiate().setup(Vector2(1,4),Vector2(2,2)), preload("res://scenes/Tiles/chest.tscn").instantiate().setup(Vector2(3,4),Vector2(2,2)),]

var rotating1 = [preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(0,0)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(1,0)),v1,preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(5,0)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(6,0)),
				preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(0,1)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(1,1)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(5,1)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(6,1)),
				preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(1,2)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(5,2)),h2,
				preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(1,3)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(5,3)),
				h1,preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(1,4)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(5,4)),
				preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(0,5)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(1,5)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(5,5)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(6,5)),
				preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(0,6)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(1,6)),v2,preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(5,6)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(6,6)),]
				
var rotating2 = [preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(0,0)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(1,0)),v1,preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(5,0)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(6,0)),
				preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(0,1)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(1,1)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(2,1)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(3,1)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(4,1)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(5,1)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(6,1)),
				h1,
				h2,
				preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(0,5)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(1,5)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(2,5)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(3,5)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(4,5)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(5,5)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(6,5)),
				preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(0,6)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(1,6)),preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(5,6)),v2,preload("res://scenes/Tiles/Void.tscn").instantiate().setup(Vector2(6,6)),]

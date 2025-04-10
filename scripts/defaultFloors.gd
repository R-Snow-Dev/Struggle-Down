extends Node

var wall = preload("res://scenes/Tiles/Wall.tscn")
var boss = preload("res://scenes/Opps/boss.tscn")
var kSlimeVision =[[1,1,1,1,0,0,1,1,1,1],
				[1,1,1,1,0,0,1,1,1,1],
				[1,1,1,1,0,0,1,1,1,1],
				[1,1,1,0,0,0,0,1,1,1],
				[0,0,0,0,0,0,0,0,0,0],
				[0,0,0,0,0,0,0,0,0,0],
				[1,1,1,0,0,0,0,1,1,1],
				[1,1,1,1,0,0,1,1,1,1],
				[1,1,1,1,0,0,1,1,1,1],
				[1,1,1,1,0,0,1,1,1,1]]


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
, wall.instantiate().setup(Vector2(7,10)), wall.instantiate().setup(Vector2(7,9)), wall.instantiate().setup(Vector2(7,8)), boss.instantiate().setup(Vector2(5,5) 
, kSlimeVision, preload("res://scripts/Behaviors/KingSlimeAI.gd").new(), 50, preload("res://scenes/Opps/king_slime.tscn"), 2)]

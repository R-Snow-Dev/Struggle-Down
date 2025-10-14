"""
Code that generates a visual representation of the dungeon floor.
"""

extends Node2D

var grid: Vector2 # dimentions of the floor
var tile : PackedScene = preload("res://scenes/Tiles/tile.tscn") # preloading the tile scene, what the floor is made of
var spriteType : int # determining what type of floor wil be generated
var sprite : PackedScene #  A variable that will eventually be assigned a desired sprite scene, that the generated tile will then display
var mapPos: Vector2 # Given by the game controller
var path : Array 
var doors : Array
var doorCollider = preload("res://scenes/DungeonParts/door_area.tscn")

# Called when the floor needs to be loaded onto the screen.
func load(): 
	# Delete any old floor copies
	if self.get_child_count() > 0:
		for i in self.get_children():
			self.remove_child(i)
	for x in grid.x + 2: # Nested loop to generate the tiles
		for y in grid.y + 2:
			var t = tile.instantiate() # creates a unique instance of a tile
			t.sprite = chooseTile(x, y) # function that chooses the appropriate sprite to be assigned to the unique tile
			t.pos = Vector2(y,x) # assignes the on-screen position for the tile
			add_child(t) # adds the unoque child to the scene tree, thus displaying it to the screen
	
				
			
func chooseTile(y: int, x: int):
	# A function that decides what the appropriate texture for a tile would be depending on
	# its type of tile and its position.
	# param - x: The x position of the tile.
	# param - y: the y position of the tile
	# returns: A PackedScene of the appropriate sprite
	
	# checking to see if the tile is at the top edge of the grid
	if x == 0:
		# this if-else statement checks to see if the tile is a top corner piece
		if y == 0:
			# Top left corner
			sprite = preload("res://scenes/Tiles/tl_corner.tscn")
		elif y == grid.x+1:
			# Top right corner
			sprite = preload("res://scenes/Tiles/tr_corner.tscn")
		else:
			# If the tile is not a corner piece, it must be a back wall, of a certain type
			if spriteType == 1:
				sprite = preload("res://scenes/Tiles/b_wall_1.tscn")
			elif spriteType == 2:
				sprite = preload("res://scenes/Tiles/b_wall_2.tscn")
			else:
				sprite = preload("res://scenes/Tiles/b_wall_3.tscn")
				
	# Checking to see if the Tile is at the bottom of the grid
	elif x == grid.y + 1:
		# Like before, this if-else statements checks to see if the tile id in the bottom corner of the grid
		if y == 0:
			# Bottom left corner
			sprite = preload("res://scenes/Tiles/bl_corner.tscn")
		elif y == grid.x + 1:
			# bottom right corner
			sprite = preload("res://scenes/Tiles/br_corner.tscn")
		else:
			# If its not a corner, it must then be a front wall, of a certain type
			if spriteType == 1:
				sprite = preload("res://scenes/Tiles/f_wall_1.tscn")
			elif spriteType == 2:
				sprite = preload("res://scenes/Tiles/f_wall_2.tscn")
			else:
				sprite = preload("res://scenes/Tiles/f_wall_3.tscn")
	
	# Now we check to see if the tile is on either left or right edge, assigning it's respective side wall if so
	elif y == 0:
		# Left wall
		sprite = preload("res://scenes/Tiles/l_wall.tscn")
	elif y == grid.x + 1:
		# Right wall
		sprite = preload("res://scenes/Tiles/r_wall.tscn")
		
	# If the Tile is not on any extreme, we assign it a floor tyle of a specific type
	else:
		if spriteType == 1:
			# Type 1 floor
			sprite = preload("res://scenes/Tiles/floor_1.tscn")
		elif spriteType == 2:
			# Type 2 floor
			sprite = preload("res://scenes/Tiles/floor_2.tscn")
		else:
			# type 3 floor
			sprite = preload("res://scenes/Tiles/floor_3.tscn")
			
	# Return the chosen sprite
	return sprite
		
		
		

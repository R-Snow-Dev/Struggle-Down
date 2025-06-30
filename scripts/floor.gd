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
	add_doors(mapPos.x, mapPos.y, path) # Add doorways on top of the floor
			
func add_doors(x: int, y: int, pathway: Array):
	# Function that adds doors based on any adjascent rooms in the map
	# Param - x: The x position of the room on the map
	# Param = y: The y position of the room on the map
	# Param - pathway: An array of Vector2s that tell the x and y position of every room on the map
	
	for i in path: #Loop through every coordinate pair in the path array
		
		# If the absolute difference between a y value in the list and the current y value is exactly 1
		# AND the x values are the same, put a door in the appropriate position
		if abs(i.y - y) == 1 and i.x == x:
			# If the difference is -1, put it at the top of the room
			if i.y-y == -1:
				var t = tile.instantiate()
				var collider = doorCollider.instantiate()
				t.sprite = preload("res://scenes/Tiles/door_up.tscn") # Sprite for a top facing doorway
				t.pos = Vector2((grid.y)+2, (int(grid.x)+1)/2)
				collider.pos = Vector2((grid.y), (int(grid.x)+1)/2)
				add_child(t)
				add_child(collider)
				
			# Otherwise, put it at the bottom
			else:
				var t = tile.instantiate()
				var collider = doorCollider.instantiate()
				t.sprite = preload("res://scenes/Tiles/door_down.tscn") # Sprite for a bottom facing doorway
				t.pos = Vector2(-1, (int(grid.x)+1)/2)
				collider.pos = Vector2(1, (int(grid.x)+1)/2)
				add_child(t)
				add_child(collider)
				
		# If the absolute difference between a x value in the list and the current x value is exactly 1
		# AND the y values are the same, put a door in the appropriate position
		elif abs(i.x - x) == 1 and i.y == y:
			# If the difference is 1, put it at the right of the room
			if i.x-x == 1:
				var t = tile.instantiate()
				var collider = doorCollider.instantiate()
				t.sprite = preload("res://scenes/Tiles/door_r.tscn") # Sprite for a right facing doorway
				t.pos = Vector2((int(grid.y)/2)+0.6, grid.x+1.5)
				collider.pos = Vector2((int(grid.y)/2)+1, grid.x)
				add_child(t)
				add_child(collider)
			
			# Otherwise, put it on the left
			else:
				var t = tile.instantiate()
				var collider = doorCollider.instantiate()
				t.sprite = preload("res://scenes/Tiles/door_l.tscn") # Sprite for a left facing doorway
				t.pos = Vector2((int(grid.y)/2)+0.6, -0.5)
				collider.pos = Vector2((int(grid.y)/2)+1, 1)
				add_child(t)
				add_child(collider)
				
				
			
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
		
		
		

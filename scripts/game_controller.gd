extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Function that loads an initial scene to the game
	EventBus.on_death.connect(_on_death)
	EventBus.new_level.connect(_new_level)
	EventBus.start.connect(_start)
	var titleScreen = preload("res://scenes/title_screen.tscn").instantiate() # In this case, it will be a basic dungeon
	add_child(titleScreen)
	
func _on_death():
	# Loads another scene upon death, after removing any children that may somehow still be under this node
	if self.get_child_count() > 0:
		for i in self.get_children():
			self.remove_child(i)
	var titleScreen = preload("res://scenes/title_screen.tscn").instantiate() # In this case, it will be the title screen
	add_child(titleScreen)

func _new_level(curLevel: int, curFloor: int):
	# Loads another dungeon upon loading a new level, after removing any children that may somehow still be under this node
	if self.get_child_count() > 0:
		for i in self.get_children():
			self.remove_child(i)
	var dungeon = preload("res://scenes/dungeon.tscn").instantiate() # Once again, this case it will just be a basic dungeon again
	
	# If you beat floor 5, move on to the next level, and reset your floors to 1
	if curFloor > 4:
		dungeon.floor = 1
		dungeon.level = curLevel + 1
	else: # Otherwise, move onto the next floor
		dungeon.floor = curFloor + 1
	
	add_child(dungeon)

func _start():
	# Loads another dungeon upon loading a new level, after removing any children that may somehow still be under this node
	if self.get_child_count() > 0:
		for i in self.get_children():
			self.remove_child(i)
	var dungeon = preload("res://scenes/dungeon.tscn").instantiate() # Loads a new, default level dungeon
	add_child(dungeon)

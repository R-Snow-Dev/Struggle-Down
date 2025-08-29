extends Node2D

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Function that loads an initial scene to the game
	EventBus.on_death.connect(_on_death)
	EventBus.new_level.connect(_new_level)
	EventBus.start.connect(_start)
	EventBus.file_select.connect(_file_select)
	EventBus.go.connect(_go)
	var titleScreen = preload("res://scenes/menus/title_screen.tscn").instantiate() # In this case, it will be a basic dungeon
	add_child(titleScreen)
	
func _on_death():
	# Loads to the pouch upon death
	loadPouch()
	
func _new_level():
	# Loads another dungeon upon loading a new level, after removing any children that may somehow still be under this node
	
	# Gets the current saved data
	var data = SaveController.loadData()
	if self.get_child_count() > 0:
		for i in self.get_children():
			self.remove_child(i)
	var dungeon = preload("res://scenes/menus/dungeon.tscn").instantiate() # Once again, this case it will just be a basic dungeon again
	
	# If you beat floor 5, move on to the next level, and reset your floors to 1
	if data["floor"] > 4:
		SaveController.updateData("floor", 1)
		SaveController.updateData("level", data["level"] + 1)
	else: # Otherwise, move onto the next floor
		SaveController.updateData("floor", data["floor"] + 1)
	add_child(dungeon)

func _file_select():
	# Opens the file selection menu upon selecting it from the main menu
	if self.get_child_count() > 0:
		for i in self.get_children():
			self.remove_child(i)
	var dungeon = preload("res://scenes/menus/file_select.tscn").instantiate() # Loads a new, default level dungeon
	add_child(dungeon)
	
func loadPouch():
	# Delete all current children, and go to the pouch menu
	
	if self.get_child_count() > 0:
		for i in self.get_children():
			self.remove_child(i)
	# Reset all run-dependant info
	SaveController.updateData("floor", 1)
	SaveController.updateData("level", 1)
	SaveController.updateData("weapon", 0)
	SaveController.updateData("inrun", false) # Set your status to "outside of a run"
	rng.randomize()
	var s = rng.seed # Generate a new seed to randomize the next run with
	SaveController.updateData("seed", s)
	var pouch = preload("res://scenes/menus/pouch_menu.tscn").instantiate()
	add_child(pouch)
	
	
func _go():
	# Code that is executed from the pouch menu's start button. Loads the player into a new dungeon
	
	if self.get_child_count() > 0:
		for i in self.get_children():
			self.remove_child(i)
	SaveController.updateData("inrun", true)
	var dungeon = preload("res://scenes/menus/dungeon.tscn").instantiate() # Loads a new, first level dungeon
	add_child(dungeon)

func _start():
	# Loads another dungeon upon loading a new level, after removing any children that may somehow still be under this node
	if self.get_child_count() > 0:
		for i in self.get_children():
			self.remove_child(i)
	if SaveController.getData("inrun"):
		var dungeon = preload("res://scenes/menus/dungeon.tscn").instantiate() # Loads a dungeon from the save data, if there was an ongoing run
		add_child(dungeon)
	else:
		loadPouch() # If the player exited in the pouch, take them to the pouch instead

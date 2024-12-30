extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Function that loads an initial scene to the game
	EventBus.on_death.connect(_on_death)
	var dungeon = preload("res://scenes/dungeon.tscn").instantiate() # In this case, it will be a basic dungeon
	add_child(dungeon)
	
func _on_death():
	# Loads another scene upon death, after removing any children that may somehow still be under this node
	if self.get_child_count() > 0:
		for i in self.get_children():
			self.remove_child(i)
	var dungeon = preload("res://scenes/dungeon.tscn").instantiate() # Once again, this case it will just be a basic dungeon again
	add_child(dungeon)

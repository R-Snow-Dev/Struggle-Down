"""
Button in the bottom right of the GUI that displays what weapon you currently have, where the weapon is currently able to attack when
hovered over, and excecuting the attack if clicked.
"""

extends Node2D


# Constant containing the sprites of every weapon in the game
var allWeapons: Array
var ID: int
var sprite: Node
var mouseOn = false

@onready var gamecontroller: Node = %Gamecontroller
@onready var data = SaveController.loadData()
@onready var collider = $Area2D/CollisionShape2D

# Connect to necessary signals upon creation
func _ready() -> void:
	EventBus.playerDoneAttacking.connect(_playerDoneAttacking)
	EventBus.swap_weapon.connect(_swap_weapon)
	EventBus.save_weapon.connect(_save_weapon)
	# allWeapons format is as follows: The ID of each item represents it's index on the main array. 
	# Each sub array is divided into index 0-7. 0 is the sprite of the weapon, 1 is it's horizontal rage, 2
	# is it's vertical range, 3 is it's point of origin where the attack will come from, 5 is the attack type which dtermines the animation 
	# that plays, 6 is the damage it will deal, and 7 is how many actions it costs to use. All elements must be present for an Item to function correctly
	allWeapons = [[],[preload("res://scenes/Items/sword_1_item.tscn"), 3,1,Vector2(0,0),"slashing", 5,1]]
	ID = data["weapon"]
	_swap_weapon(ID)

func _process(delta: float) -> void:
	if mouseOn:
		if ID != 0:
			if Input.is_action_just_pressed("select") and gamecontroller.paused == false and gamecontroller.player.actionsAvailable >= allWeapons[ID][6]:
				EventBus.pause.emit()
				EventBus.updateActions.emit(-1)
				EventBus.attack.emit(allWeapons[ID])

func _playerDoneAttacking():
	EventBus.unpause.emit()

func _swap_weapon(id: int):
	# Function that displays a different sprite upon the player swapping weapons.
	# param - id: the ID of the weapon being swapped to, corresponding to the weapon's index in the allWeapons constant
	
	# Checks to see if it's already displaying a weapon, then deletes it
	if sprite in self.get_children():
		remove_child(sprite)
		
	# Finds the correct sprite node from allWeapons using the ID, then displays it by adding it as a child node
	ID = id
	if ID > 0:
		sprite = allWeapons[ID][0].instantiate()
		add_child(sprite)
	
func _save_weapon():
	# Updates the savefile with the current held weapon when going to a new floor
	SaveController.updateData("weapon", ID)

func _on_area_2d_mouse_entered() -> void:
	if ID > 0:
		EventBus.updateAOE.emit(allWeapons[ID][1], allWeapons[ID][2], allWeapons[ID][3])
	mouseOn = true
	collider.position.y = 1
	position.y = -523.134

func _on_area_2d_mouse_exited() -> void:
	EventBus.updateAOE.emit(0, 0, allWeapons[1][3])
	mouseOn = false
	collider.position.y = 0
	position.y = -543.134
	

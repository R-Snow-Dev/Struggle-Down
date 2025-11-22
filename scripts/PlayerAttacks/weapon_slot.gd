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
var halFlip = false
var halStorage: int
var busy = false
var rng = RandomNumberGenerator.new()
var aA: int
var inAltar: bool = false

@onready var sacText = $sacText
@onready var gamecontroller: Node = %Gamecontroller
@onready var data = SaveController.loadData()
@onready var collider = $Area2D/CollisionShape2D
@onready var slot = $slot

# Connect to necessary signals upon creation
func _ready() -> void:
	print(slot.position.y)
	EventBus.playerDoneAttacking.connect(_playerDoneAttacking)
	EventBus.swap_weapon.connect(_swap_weapon)
	EventBus.save_data.connect(_save_weapon)
	EventBus.updatedView.connect(update)
	EventBus.updateAltar.connect(updateAltar)
	
	# allWeapons format is as follows: The ID of each item represents it's index on the main array. 
	# Each sub array is divided into index 0-7. 0 is the sprite of the weapon, 1 is it's horizontal rage, 2
	# is it's vertical range, 3 is it's point of origin where the attack will come from, 5 is the attack type which determines the animation 
	# that plays, 6 is the damage it will deal, and 7 is how many actions it costs to use. All elements must be present for an Item to function correctly
	allWeapons = [[],
	preload("res://scenes/Items/sword_1_item.tscn"),
	preload("res://scenes/Items/great_sword_item.tscn"),
	preload("res://scenes/Items/mace_item.tscn"),
	preload("res://scenes/Items/spear_item.tscn"),
	preload("res://scenes/Items/halberd_item.tscn"),
	preload("res://scenes/Items/stiletto_item.tscn")]
	
	
	ID = data["weapon"]
	_swap_weapon(ID)

func updateAltar() -> void:
	inAltar = !inAltar
	sacText.stop()
	if inAltar and ID > 0:
		sacText.play()

func update() -> void:
	if mouseOn:
		EventBus.updateAOE.emit(ID)

func _process(_delta: float) -> void:
	if mouseOn and !busy:
		if ID != 0:
			if Input.is_action_just_pressed("select"):
				if inAltar:
					_swap_weapon(0)
					sacText.stop()
				else:
					print("Attacked with a weapon id of: ", ID)
					busy = true
					EventBus.attack.emit(ID)
			if Input.is_action_just_pressed("special_select") and ID == 5:
				EventBus.spWeapon.emit(ID)

func _playerDoneAttacking():
	EventBus.unpause.emit()
	busy = false

func _swap_weapon(id: int):
	# Function that displays a different sprite upon the player swapping weapons.
	# param - id: the ID of the weapon being swapped to, corresponding to the weapon's index in the allWeapons constant
	
	# Checks to see if it's already displaying a weapon, then deletes it
	if sprite in slot.get_children():
		slot.remove_child(sprite)
		
	# Finds the correct sprite node from allWeapons using the ID, then displays it by adding it as a child node
	ID = id
	WeaponList.held = id
	if ID > 0:
		sprite = allWeapons[ID].instantiate()
		sprite.position.x = 8
		slot.add_child(sprite)
		EventBus.updateAOE.emit(ID)
	
func _save_weapon():
	# Updates the savefile with the current held weapon when going to a new floor
	SaveController.updateData("weapon", ID)

func _on_area_2d_mouse_entered() -> void:
	if ID > 0:
		EventBus.updateAOE.emit(ID)
	mouseOn = true
	slot.position.y = -2

func _on_area_2d_mouse_exited() -> void:
	EventBus.updateAOE.emit(0)
	mouseOn = false
	halFlip = false
	slot.position.y = 0
	

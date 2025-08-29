extends Node2D

@onready var slots = [$inventoryBarSlot2, $inventoryBarSlot]
@onready var itemIcons = SaveController.itemList # Connecting to the list of item sprites
var slotId1 
var slotId2
var hasItem = false
var hover1 = false
var hover2 = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Checks to see if one of the two buttons are pressed
	if Input.is_action_just_pressed("select") and hasItem :
		if hover1:
			EventBus.changeItem.emit(slotId1)
		elif hover2:
			EventBus.changeItem.emit(slotId2)

func update(num: int, inventory: Array):
	# Change sthe items displayed in each side slot depending
	# on the item displayed in the main item panel
	var index = find_id(num, inventory)
	if inventory.size() > 0:
		if index - 1 < 0:
			slotId1 = inventory[inventory.size() - 1]
		else:
			slotId1 = inventory[index - 1]
		if index + 1 >= inventory.size():
			slotId2 = inventory[0]
		else:
			slotId2 = inventory[index + 1]
		slots[0].updateSprite(itemIcons[slotId1].instantiate())
		slots[1].updateSprite(itemIcons[slotId2].instantiate())
		hasItem = true
	else:
		slots[0].delSprite()
		slots[1].delSprite()
		hasItem = false
	
func find_id(num: int, data: Array):
	# Loops through an array to see if an id matches with an id already found in the array
	for i in range(0, data.size()):
		if data[i] == num:
			return i
	return -1	
		
# Hover logic for the left-most slot
func _on_area_2d_2_mouse_entered() -> void:
	hover1 = true
	slots[0].position.y = -2

func _on_area_2d_2_mouse_exited() -> void:
	hover1 = false
	slots[0].position.y = 0 

# Hover logic for the right-most slot
func _on_area_2d_mouse_entered() -> void:
	hover2 = true
	slots[1].position.y = -2

func _on_area_2d_mouse_exited() -> void:
	hover2 = false
	slots[1].position.y = 0 

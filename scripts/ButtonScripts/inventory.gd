extends Node2D
# Variables
@onready var itemIcons = SaveController.itemList # Connects to the list of all item sprites
@onready var itemEffects = SaveController.effects # connects to the database of item effeects
@onready var slot = $slot
@onready var label = $itemAmount
@onready var inventoryBar = $inventoryBar
var curEffect
var inventory = []
var items = []
var curID
var isHovering: bool = false
var menuOpen = false

func _ready() -> void:
	# Gets the current inventory loadout from the save file, along with all the 
	# item data. If there are items in the inventory, display the first one
	EventBus.save_data.connect(_save_inventory)
	EventBus.changeItem.connect(_swapItem)
	label.text = ""
	inventory = SaveController.getData("inventory")
	items = SaveController.getData("items")
	if inventory.size() > 0:
		curID = inventory[0]
		updateIcons()
		updateAmount()
		
func _process(_delta: float) -> void:
	# Check to see if thge player has either right or left clicked on the button,
	# and perform the appropriate checks if they have. Activate the item if the checks all passed, or
	# open the item bar if they right clicked
	if Input.is_action_just_pressed("select"):
		if isHovering:
			curEffect = itemEffects[items[curID][2]].new(items[curID][3])
			if curEffect.test():
				items[curID][0] -= 1
				curEffect.run()
				updateAmount()
	if Input.is_action_just_pressed("special_select"):
		if menuOpen:
			menuOpen = false
			inventoryBar.visible = false
		elif isHovering:
			slot.position.y = 0
			label.position.y = 0
			inventoryBar.update(curID, inventory)
			menuOpen = true
			inventoryBar.visible = true

func updateIcons():
	# Changes the displayed item
	for child in slot.get_children():
		slot.remove_child(child)
	var sprite = itemIcons[curID].instantiate()
	sprite.position.x = -8
	slot.add_child(sprite)
	

func delIcons():
	# Removers any displayed icon
	for child in slot.get_children():
		slot.remove_child(child)
		label.text = ""

func updateAmount():
	# Change the displayed amount of the displayed item (shows in bottom right
	# corner of the button). If that amount is 0, delete the item from the inventory
	# and switch to the next item (or none if the inventory is now empty)
	if items[curID][0] < 1:
		var index = find_id(curID, inventory)
		inventory.remove_at(index)
		if inventory.size() > 0:
			if index >= inventory.size():
				index -= 1
			curID = inventory[index]
			updateIcons()
			updateAmount()
			inventoryBar.update(curID, inventory)
		else:
			isHovering = false
			delIcons()
			inventoryBar.update(curID, inventory)
	else:
		label.text = str(items[curID][0])
		inventoryBar.update(curID, inventory)

func _swapItem(id: int):
	# Changes the displayed item
	curID = id
	updateIcons()
	updateAmount()
	inventoryBar.update(curID, inventory)

func find_id(num: int, data: Array):
	# Loops through an array to see if an id matches with an id already found in the array
	for i in range(0, data.size()):
		if data[i] == num:
			return i
	return -1

func _save_inventory():
	# Save teh current item data and inventory to the save file
	SaveController.updateData("items", items)
	SaveController.updateData("inventory", inventory)
	
func _on_area_2d_mouse_entered() -> void:
	if inventory.size() > 0:
		isHovering = true
	slot.position.y = -2
	label.position.y = -2

func _on_area_2d_mouse_exited() -> void:
	isHovering = false
	slot.position.y = 0
	label.position.y = 0

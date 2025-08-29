extends Node2D

@onready var items = SaveController.itemList # Connects to the list of all item sprites
@onready var grid = [$InventorySlot, $InventorySlot2, $InventorySlot3, $InventorySlot4, $InventorySlot5, $InventorySlot6, $InventorySlot7, $InventorySlot8]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.updateInv.connect(updateSprites)
	updateSprites()


func updateSprites():
	# Sets all the inventory slots to show the correct items
	var data = SaveController.getData("inventory")
	var lim = data.size()
	for i in range(0,8):
		if i < lim:
			grid[i].id = data[i]
			grid[i].updateSprite(items[data[i]])
		else:
			grid[i].delSprite()
			
		

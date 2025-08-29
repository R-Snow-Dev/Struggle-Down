extends Node2D

# variables

@onready var items = SaveController.itemList # Connects to the list of all item sprites

@onready var grid = [$ConsumableSlot,$ConsumableSlot2,$ConsumableSlot3,$ConsumableSlot4,
			$ConsumableSlot5,$ConsumableSlot6,$ConsumableSlot7,$ConsumableSlot8,
			$ConsumableSlot9,$ConsumableSlot10,$ConsumableSlot11,$ConsumableSlot12]
var scrllLvl = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.updateInv.connect(updateSprites)
	updateSprites()
	
func updateSprites():
	# Sets all the consumable slots to show the correct sprites
	for i in range(0,12):
		grid[i].id = i + (4*scrllLvl)
		grid[i].updateSprite(items[i + (4*scrllLvl)])
		

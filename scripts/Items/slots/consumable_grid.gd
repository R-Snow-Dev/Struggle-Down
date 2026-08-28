extends Node2D

# variables

@onready var items = SaveController.itemList # Connects to the list of all item sprites
@onready var max = items.size()
@onready var scroller = $VSlider
@onready var grid = [0,$ConsumableSlot,$ConsumableSlot2,$ConsumableSlot3,$ConsumableSlot4,
			$ConsumableSlot5,$ConsumableSlot6,$ConsumableSlot7,$ConsumableSlot8,
			$ConsumableSlot9,$ConsumableSlot10,$ConsumableSlot11,$ConsumableSlot12]
var scrllLvl = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.updateInv.connect(updateSprites)
	updateSprites()
	
func updateSprites():
	# Sets all the consumable slots to show the correct sprites
	for i in range(1,13):
		if i + (4*scrllLvl) >= max:
			grid[i].id = 0
			grid[i].updateSprite(items[0])
		else:
			grid[i].id = i + (4*scrllLvl)
			grid[i].updateSprite(items[i + (4*scrllLvl)])
		
		
func _on_v_slider_value_changed(value: float) -> void:
	scrllLvl = int(value)
	AudioManager.play_sound('Select')
	updateSprites()


func _on_v_slider_mouse_entered() -> void:
	AudioManager.play_sound('Hover')


func _on_scroll_area_up() -> void:
	scroller.value -= 1


func _on_scroll_area_down() -> void:
	scroller.value += 1

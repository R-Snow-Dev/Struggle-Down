extends Control
class_name RelicGrid

@onready var slots = $HBoxContainer
@onready var slider = $VSlider
var max = 18
var scrllLvl = 0

func _ready() -> void:
	EventBus.updateInv.connect(updateSprites)
	updateSprites()

func updateSprites():
	# Sets all the consumable slots to show the correct sprites
	var data = SaveController.getData('unlockedRelics')
	var grid = slots.get_children()
	
	for i in range(0,len(grid)):
		grid[i].removeSprite()
		if i + (3*scrllLvl) >= max and i < len(data):
			grid[i].id = 0
			grid[i].setup(data[i])
		elif i+(3*scrllLvl) < len(data):
			grid[i].id = i + (3*scrllLvl)
			grid[i].setup(data[i + (3*scrllLvl)])


func _on_v_slider_value_changed(value: float) -> void:
	scrllLvl = int(value)
	AudioManager.play_sound('Select')
	updateSprites()

func _on_v_slider_mouse_entered() -> void:
	AudioManager.play_sound('Hover')


func _on_area_2d_up() -> void:
	slider.value -= 1

func _on_area_2d_down() -> void:
	slider.value += 1

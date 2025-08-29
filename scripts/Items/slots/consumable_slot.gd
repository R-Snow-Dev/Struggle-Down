extends TileMapLayer

# variables

var sprite: Node
var isHovering = false
@onready var amount = $Amount
@onready var spriteController = $SpriteController
@onready var filter = $filter
var id: int
var stored = 0
var inInv = 0
var invTot = 0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if isHovering and checkDependencies():
		if Input.is_action_just_pressed("select"):
			SaveController.updateItems(id, Vector2(inInv+1,stored-1))
			SaveController.updateInv(id, 1)
			updateAmount()
			EventBus.updateInv.emit()

func updateSprite(spr: PackedScene):
	# Deletes old sprites and replaces it with a new sprite
	# @param spr: The preloaded sprite scene that will be diaplayed in the slot
	for c in spriteController.get_children():
		spriteController.remove_child(c)
	sprite = spr.instantiate()
	sprite.scale *= 0.75
	spriteController.add_child(sprite)
	updateAmount()
	
func updateAmount():
	# Sets the text label to show however many of an item this slot is carrying
	var data = SaveController.getData("items")[id]
	var inv = SaveController.getData("inventory")
	stored = data[1]
	inInv = data[0]
	invTot = inv.size()
	amount.text = str(stored)
	if stored > 0:
		filter.visible = false
	else:
		filter.visible = true
	
	
func checkDependencies():
	# Checks to see if the inventory has room to be added into, and if there is an 
	# item in this slot that can be stored that can be stored in the first place
	var data = SaveController.getData("inInv")
	if stored < 1:
		return false
	elif invTot > 7 and inInv < 1:
		return false 
	elif data > 23:
		return false
	else:
		return true
	
func _on_area_2d_mouse_entered() -> void:
	if checkDependencies():
		spriteController.position.y = -1
		isHovering = true
func _on_area_2d_mouse_exited() -> void:
	isHovering = false
	spriteController.position.y = 0

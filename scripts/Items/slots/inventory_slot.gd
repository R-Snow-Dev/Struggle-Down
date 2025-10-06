extends Node2D

var sprite: Node
var isHovering = false
@onready var amount = $Amount
@onready var spriteController = $SpriteController
var id: int
var stored = 0
var inInv = 0

func _process(_delta: float) -> void:
	# Checks to see if the inventory slot is pressed and has an item inside. Removes 1 of that item
	# from the inventory if so
	if isHovering and inInv > 0:
		if Input.is_action_just_pressed("select"):
			SaveController.updateItems(id, Vector2(inInv-1,stored + 1))
			SaveController.updateInv(id, -1)
			updateAmount()
			EventBus.updateInv.emit()

func updateSprite(spr: PackedScene):
	# Deletes old sprites and replaces it with a new sprite
	# @param spr: The preloaded sprite scene that will be diaplayed in the slot
	for c in spriteController.get_children():
		spriteController.remove_child(c)
	sprite = spr.instantiate()
	sprite.scale *= 0.333
	spriteController.add_child(sprite)
	updateAmount()
	
func delSprite():
	# Deletes any sprite being displayed in the slot
	for c in spriteController.get_children():
		spriteController.remove_child(c)
	amount.text = ""
	
func updateAmount():
	# Sets the text label to show however many of an item this slot is carrying
	var data = SaveController.getData("items")[id]
	stored = int(data[1])
	inInv = int(data[0])
	if inInv > 0:
		amount.text = str(inInv)
	else:
		amount.text = ""

func _on_area_2d_mouse_entered() -> void:
	if inInv > 0:
		spriteController.position.y = 7
		isHovering = true

func _on_area_2d_mouse_exited() -> void:
	isHovering = false
	spriteController.position.y = 8

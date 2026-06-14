extends Node2D

var sprite: Node
var isHovering = false
@onready var amount = $Amount
@onready var spriteController = $SpriteController
var id: int
var stored = 0
var inInv = 0


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



func _on_button_pressed() -> void:
	if inInv > 0:
		AudioManager.play_sound('Select')
		SaveController.updateItems(id, Vector2(inInv-1,stored + 1))
		SaveController.updateInv(id, -1)
		updateAmount()
		EventBus.updateInv.emit()


func _on_button_mouse_entered() -> void:
	if inInv > 0:
		AudioManager.play_sound('Hover')
		spriteController.position.y = 7
		isHovering = true


func _on_button_mouse_exited() -> void:
	isHovering = false
	spriteController.position.y = 8

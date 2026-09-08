extends Node2D
class_name KeySlot

@onready var amount: Label = $keyAmount
@onready var shaker: AnimationPlayer = $keyAmount/AnimationPlayer

var sho = false

func updateKeys() -> void:
	print('keys updated')
	shaker.play("shake")
	amount.text = str(Overseer.getController().keys)
	if Overseer.getController().keys > 0 and sho == false:
		sho = true
		shaker.play('slideIN')
	if Overseer.getController().keys < 1 and sho == true:
		sho = false
		shaker.play_backwards('slideIN')

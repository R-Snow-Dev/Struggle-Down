extends Node2D
class_name PickupPopup

var decay = 0.0
var icon: Node2D
var amount: int
@onready var label = $Amount
@onready var sprite = $Sprite

func setup(num: int, s: Node2D) -> void:
	amount = num
	icon = s
	
func _ready() -> void:
	label.text = "+" + str(int(amount))
	sprite.add_child(icon)

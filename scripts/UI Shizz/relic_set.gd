extends Control
class_name RelicSet

@onready var slot1: RelicSlot = $HBoxContainer/RelicSlot
@onready var slot2: RelicSlot = $HBoxContainer/RelicSlot2
@onready var slot3: RelicSlot = $HBoxContainer/RelicSlot3

func _ready() -> void:
	var data = SaveController.getData('relics')
	if data[0] is not bool:
		slot1.setup(data[0])
	if data[1] is not bool:
		slot2.setup(data[1])
	if data[2] is not bool:
		slot3.setup(data[2])

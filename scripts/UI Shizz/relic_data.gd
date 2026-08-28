extends Control
class_name RelicData

@onready var title = $VBoxContainer/Name
@onready var sprite = $VBoxContainer/Relic/Relic
@onready var desc = $VBoxContainer/Description

func _ready() -> void:
	EventBus.relicHover.connect(hovered)
	EventBus.relicOff.connect(off_hover)

func removeSprites() -> void:
	for c in sprite.get_children():
		sprite.remove_child(c)
		c.call_deferred("queue_free")

func hovered(id: int) -> void:
	removeSprites()
	var relic: Relic = preload("res://scenes/GUIParts/relic.tscn").instantiate()
	relic.setId(id)
	sprite.add_child(relic)
	title.text = relic.getAttribute().name
	desc.text = relic.getAttribute().description
	
func off_hover():
	removeSprites()
	title.text = ''
	desc.text = ''

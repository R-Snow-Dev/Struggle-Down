extends Control
class_name RelicSlot


var id: int
var relic: Relic
@onready var sprite = $Visuals/relic
@onready var visuals = $Visuals

func setup(i: int):
	id = i
	relic = preload("res://scenes/GUIParts/relic.tscn").instantiate()
	relic.setId(id)
	relic.scale = Vector2(0.5,0.5)
	sprite.add_child(relic)

func _on_button_mouse_entered() -> void:
	AudioManager.play_sound('Hover')
	visuals.position.y = 1


func _on_button_mouse_exited() -> void:
	visuals.position.y = 0


func _on_button_pressed() -> void:
	if relic:
		AudioManager.play_sound('Select')
		visuals.position.y = 0
		relic.getAttribute().effect(self)

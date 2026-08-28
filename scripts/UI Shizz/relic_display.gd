extends Control
class_name RelicDisplay



var id: int
var relic: Relic
@onready var sprite = $Visuals/relic
@onready var visuals = $Visuals

func removeSprite() -> void:
	for c in sprite.get_children():
		sprite.remove_child(c)
		c.call_deferred("queue_free")

func setup(i: int):
	removeSprite()
		
	id = i
	relic = preload("res://scenes/GUIParts/relic.tscn").instantiate()
	relic.setId(id)
	relic.scale = Vector2(0.45,0.45)
	sprite.add_child(relic)

func _on_button_mouse_entered() -> void:
	AudioManager.play_sound('Hover')
	visuals.position.y = 1
	if relic:
		EventBus.relicHover.emit(id)

func _on_button_mouse_exited() -> void:
	visuals.position.y = 0
	EventBus.relicOff.emit()

func _on_button_pressed() -> void:
	if relic:
		AudioManager.play_sound('Select')
		visuals.position.y = 0
		EventBus.selectedRelic.emit(id)

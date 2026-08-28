extends Control
class_name BasicButton

signal pressed
signal pressed_right
signal hover
signal off_hover

@onready var dis = $Display
@onready var sprite = $Display/sprite

func setSprite(s: Node) -> void:
	removeSprite()
	sprite.add_child(s)
	
func removeSprite() -> void:
	for child in sprite.get_children():
		sprite.remove_child(child)
		child.call_deferred("queue_free")

func _on_button_pressed() -> void:
	AudioManager.play_sound('Select')
	dis.position.y = 0
	for c in get_children():
		if c is Sprite2D:
			c.position.y = 0


func _on_button_mouse_entered() -> void:
	hover.emit()
	AudioManager.play_sound('Hover')
	dis.position.y = -2
	for c in get_children():
		if c is Sprite2D:
			c.position.y = -2


func _on_button_mouse_exited() -> void:
	off_hover.emit()
	dis.position.y = 0
	for c in get_children():
		if c is Sprite2D:
			c.position.y = 0


func _on_button_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					pressed.emit()
				MOUSE_BUTTON_RIGHT:
					pressed_right.emit()

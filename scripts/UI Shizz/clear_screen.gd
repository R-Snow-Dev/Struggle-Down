extends Control
class_name ClearScreen

@onready var b = $CenterContainer/VBoxContainer/CenterContainer
@onready var container = $CenterContainer/VBoxContainer

func addItem(item: Node) -> void:
	var c = CenterContainer.new()
	remove_child(b)
	c.add_child(item)
	container.add_child(c)
	add_child(b)
	
func addAdded(item: Node) -> void:
	var a: Added = preload("res://scenes/GUIParts/added.tscn").instantiate()
	a.add(item)
	addItem(a)
	
func on() -> void:
	EventBus.pause.emit()
	visible = true

func reset() -> void:
	for c in container.get_children():
		container.remove_child(c)

func off() -> void:
	EventBus.unpause.emit()
	visible = false

func _on_long_button_pressed() -> void:
	off()
	reset()
	EventBus.create_stairs.emit(Vector2(5,5))
	Overseer.getController().sF += 1
	Overseer.getBoard().loadBoard()

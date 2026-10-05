extends HBoxContainer
class_name Added

var i: Node = Node.new()
@onready var item = $CenterContainer/Item

func add(it: Node) -> void:
	i = it
	
func _ready() -> void:
	item = $CenterContainer/Item
	print(item)
	setI()

func setI() -> void:
	item = $CenterContainer/Item
	item.add_child(i)

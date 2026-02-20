extends HFlowContainer
class_name UContainer

func _ready() -> void:
	EventBus.uCont.connect(add)
	EventBus.rUCont.connect(reset)

func add(a: Attribute):
	var t: uDisplay = preload("res://scenes/GUIParts/u_display.tscn").instantiate()
	t.setA(a)
	print(a.name)
	call_deferred("add_child",t)

func reset():
	for x in get_children():
		remove_child(x)
		x.queue_free()
		

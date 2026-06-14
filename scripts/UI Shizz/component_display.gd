extends Control
class_name ComponentDisplay



@onready var s = $slot
@onready var a: Label = $slot/amount
@onready var sp = $slot/sprite

var comp
var amount: int


func setComp(c) -> void:
	for s in sp.get_children():
		sp.remove_child(s)
	comp = c
	if c:
		sp.add_child(c)
	
func setAmount(am: int) -> void:
	amount = am
	if amount < 1:
		a.text = ''
		comp = false
	else:
		a.text = str(amount)

func _on_button_mouse_entered() -> void:
	AudioManager.play_sound('Hover')
	if comp:
		EventBus.displayComp.emit(comp)
	s.position.y = -2


func _on_button_mouse_exited() -> void:
	s.position.y = 0

extends Control
class_name ComponentSlot



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
	s.position.y = -2


func _on_button_mouse_exited() -> void:
	s.position.y = 0


func _on_button_pressed() -> void:
	AudioManager.play_sound('Select')
	if comp and amount > 0:
		sp.remove_child(comp)
		EventBus.compChosen.emit(comp)
	else:
		EventBus.removeComp.emit()

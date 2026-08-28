extends Node2D
class_name ComponentPopup

var s: PickupPopup
@onready var anim = $AnimationPlayer

func setSprite(comp: PickupPopup) -> void:
	s = comp

func pop() -> void:
	EventBus.pause.emit()
	add_child(s)
	anim.play('pop')
	
func end() -> void:
	remove_child(s)
	EventBus.unpause.emit()
	

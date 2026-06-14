extends Node2D
class_name ComponentPopup

var s: Components
@onready var anim = $AnimationPlayer

func setSprite(comp: Components) -> void:
	s = comp

func pop() -> void:
	add_child(s)
	anim.play('pop')
	
func end() -> void:
	remove_child(s)

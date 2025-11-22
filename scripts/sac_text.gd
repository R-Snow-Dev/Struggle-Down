extends Label
class_name SacText

@onready var anim = $AnimationPlayer

func play():
	anim.play("flash")
	
func stop():
	anim.play("RESET")

			

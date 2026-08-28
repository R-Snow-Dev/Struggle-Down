extends Attribute
class_name Harmonic

func _init() -> void:
	type = "onAttacked"
	name = "Harmonic Frequency"
	description = "You internalize the tectonic tremors.

Deal 1 special damage back to an attacker when you are hit.."
	
func effect(target : Node):
	target.updateHealth(-1)

extends Attribute
class_name Parry

func _init() -> void:
	type = "onDamaged"
	name = "Parry"
	description = "The skills of a mighty knight enhace you. While weilding a sword,  
	you gain a 5% chance to ignore damage."
	
func effect(target: Node) -> int:
	var rng = RandomNumberGenerator.new()
	if rng.randf() < 0.05:
		return 0
	return 1

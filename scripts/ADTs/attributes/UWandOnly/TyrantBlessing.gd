extends Attribute
class_name TyrantBlessing

func _init() -> void:
	type = "hitMult"
	name = "Tyrant's Blessing"
	description = "Tarnished Gold was not one to stay idle. Lover of war, he left many blood soaked fields in his wake. His path was marked by the blood of others, aswell as his own.
	
	Damage is multiplied based on how close to death you are.
	
	One feels most alive when they dance with death.
	"
	
func effect(target: Node):
	var total = 1.0
	var amount = SaveController.getData('curHP')
	return total + (3/amount)

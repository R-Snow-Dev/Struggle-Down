extends Attribute
class_name Bless

func _init() -> void:
	type = "passive"
	name = "Bless"
	description = "Gain a blessing from the divine. 
	
	Gain 1 permanent heart."

func onPickup(target : Node):
	EventBus.update_total_hp.emit(2)

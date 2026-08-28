extends Attribute
class_name Permafrost

func _init() -> void:
	type = "passive"
	name = "Permafrost"
	description = "Your flesh is coated in a layer of ice. 
	
	Gain 1 permanent heart."

func onPickup(target : Node):
	EventBus.update_total_hp.emit(2)

extends Attribute
class_name SteelHeart

func _init() -> void:
	type = "passive"
	name = "Steel Heart"
	description = "The sword's steel coats your flesh. 
	
	Gain 1 permanent heart."

func onPickup(target : Node):
	EventBus.update_total_hp.emit(2)

extends Attribute
class_name GrandBlessing

func _init() -> void:
	type = "passive"
	name = "Grand Blessing"
	description = "A work of divine magic is bestowed onto you. 
	
	Gain 2 permanent hearts."

func onPickup(target : Node):
	EventBus.update_total_hp.emit(4)

extends Attribute
class_name SoldierSoul

func _init() -> void:
	type = "passive"
	name = "Soldier Soul"
	description = "You gain the will of a forgotten soldier. Hold the line. 
	
	Gain 1 permanent heart."

func onPickup(target : Node):
	EventBus.update_total_hp.emit(2)

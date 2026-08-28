extends Attribute
class_name Immolate

func _init() -> void:
	type = "passive"
	name = "Immolate"
	description = "You gain the malice of a vengeful demon. 
	
Fire damage gains a 5% chance to afflict burn onto your enemies."
	
func onPickup(target : Node):
	WeaponList.addIEffect("fire", "burn", 0.05)

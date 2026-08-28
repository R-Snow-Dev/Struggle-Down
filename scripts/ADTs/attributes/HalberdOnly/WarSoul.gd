extends Attribute
class_name WarSoul

func _init() -> void:
	type = "passive"
	name = "Warlord Soul"
	description = "You gain a fragment of Tarnished Gold, master of war. Nothing less than a falling star broke his dominion, and none shall break yours. 
	
	Gain 1 permanent heart and +2 damage for all damage types."

func onPickup(target : Node):
	EventBus.update_total_hp.emit(2)
	for d in WeaponList.damages:
		WeaponList.damages[d] += 2

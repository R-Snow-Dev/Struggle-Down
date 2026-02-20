extends Attribute
class_name SimpleStrength

func _init() -> void:
	type = "passive"
	name = "Simple Strength"
	description = "Trolls, Giants and even the Titans. Beings who exist beyond the human limit, untouchable existences that dominated in the past and the present. And yet the nature of their power is simple, to a point that many people deny this truth. Pure, simple strength, and giant swords. You are one of them now. Gain 2 permanent hearts and +5 damage when using a greatsword."

func onPickup(target : Node):
	WeaponList.weapons[2].addBaseDam(3)
	EventBus.update_total_hp.emit(4)
	

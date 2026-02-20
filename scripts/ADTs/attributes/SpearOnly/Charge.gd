extends Attribute
class_name Charge

func _init() -> void:
	type = "onCondition"
	name = "Cavalry's Gambit"
	description = "You inherit the will of an proud cavalryman.
	
	Gain 3 spear damage when attacking on your last action"

func check(target: DungeonController):
	var actions = target.player.actionsAvailable
	var spear: Weapon = WeaponList.weapons[4]
	if actions == 1:
		spear.setAtkDam(spear.getAtkDam() + 3)
	else:
		spear.setAtkDam(spear.getBaseDam())
		

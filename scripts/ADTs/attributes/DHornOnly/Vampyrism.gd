extends Attribute
class_name Vampyrism

func _init() -> void:
	type = "onKill"
	name = "Vampyrism"
	description = "You gain the power of a Noble.
	
	Every time you kill an enemy, gain a lifesteal point. Heal one HP when 24 lifesteal points are collected."


func effect(target : Node):
	UpgradeList.lifesteal += 1
	if UpgradeList.lifesteal >= UpgradeList.lifeLimit:
		EventBus.update_hp.emit(1)
		UpgradeList.lifesteal = 0

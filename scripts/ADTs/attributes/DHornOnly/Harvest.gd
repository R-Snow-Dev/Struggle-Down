extends Attribute
class_name Harvest


func _init() -> void:
	type = "onKill"
	name = "Demonic Harvest"
	description = "Drink in the despair of your enemies.

Gain 3 lifesteal points when killing burned enemies.  Heal one HP when 24 lifesteal points are collected."

func effect(target: Node):
	for e in target.getEffects():
		if e is Burn:
			UpgradeList.lifesteal += 3
			break
	if UpgradeList.lifesteal >= UpgradeList.lifeLimit:
		EventBus.update_hp.emit(1)
		UpgradeList.lifesteal = 0

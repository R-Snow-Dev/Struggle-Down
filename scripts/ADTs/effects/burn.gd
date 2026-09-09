extends Effect
class_name Burn

func _init():
	activeTime = 0
	name = "Burn"

func activate(target: Fiend):
	print("Burning", target)
	target.updateHealth(-1 * UpgradeList.relicData['pestilence'])

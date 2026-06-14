extends "res://scripts/Items/effects/effect.gd"
class_name HealEffect

var mag: int

func _init(m: int) -> void:
	mag = m 
	
func run():
	var hpCur = SaveController.getData("curHP")
	var hpTot = SaveController.getData("pHP")
	if (1 * mag) > (hpTot-hpCur):
		EventBus.update_hp.emit(hpTot-hpCur)
	else:
		EventBus.update_hp.emit(hpTot-hpCur)

func test():
	var hpCur = SaveController.getData("curHP")
	var hpTot = SaveController.getData("pHP")
	print(hpCur < hpTot)
	return hpCur < hpTot

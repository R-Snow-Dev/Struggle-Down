extends Attribute
class_name SGrace

var usable = true

func _init() -> void:
	usable = true
	type = "active"
	name = "Shard of Grace"
	description = "Rest, tired one. You are tarnished no longer.\n
	May be activated to heal one heart. May be used once per floor."

func onPickup(target : Node):
	usable = true

func effect(target : Node):
	if test() and usable:
		UpgradeList.setRData('chalice', true)
		var hpCur = SaveController.getData("curHP")
		var hpTot = SaveController.getData("pHP")
		usable = false
		if (1) > (hpTot-hpCur):
			EventBus.update_hp.emit(hpTot-hpCur)
		else:
			EventBus.update_hp.emit(hpTot-hpCur)
	effectDone.emit()

func test():
	var hpCur = SaveController.getData("curHP")
	var hpTot = SaveController.getData("pHP")
	return hpCur < hpTot
	

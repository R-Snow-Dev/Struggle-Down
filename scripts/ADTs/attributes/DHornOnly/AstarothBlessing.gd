extends Attribute
class_name AstarothBlessing

func _init() -> void:
	type = "active"
	name = "Demon Prince"
	description = "Embody the power of Astaroth, the Prince. It is he who will rule, when all that is has been returned to ash.
	
	Click this upgrade's icon located at the bottom of the screen to gain a burst of unholy power.Your HP is set to 1, but you gain temporary actions equal to the amount of health lost.
	Release your inner demon.
	"
	
func pressed() -> void:
	var amount = SaveController.getData('curHP')- 1
	EventBus.updateActions.emit(amount)
	EventBus.update_hp.emit(-1*amount)

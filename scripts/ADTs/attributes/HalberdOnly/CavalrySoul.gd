extends Attribute
class_name CavalrySoul

func _init() -> void:
	type = "passive"
	name = "Cavalry Soul"
	description = "You gain the will of a forgotten cavalryman. Charge forth, break the lines.

Gain 1 permanent action."
	
func onPickup(target : Node):
	EventBus.updateTotActions.emit(1)

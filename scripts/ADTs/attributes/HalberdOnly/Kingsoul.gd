extends Attribute
class_name Kingsoul

func _init() -> void:
	type = "onKill"
	name = "Blessing of the Kingsoul"
	description = "By buring the ceremonial weapon of the Gilded Kings, you have inherited its spark of authority. Exert you power overe those beneath.
	
	Kills now have a 10% chance to heal you 1 point of damage.
	"

func effect(target: Node) -> int:
	var rng = RandomNumberGenerator.new()
	if rng.randf() >= 0.1:
		EventBus.update_hp.emit(1)
	effectDone.emit()
	return 0

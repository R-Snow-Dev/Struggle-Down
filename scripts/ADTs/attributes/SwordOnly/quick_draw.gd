extends Attribute
class_name QuickDraw

func _init() -> void:
	type = "onAttack"
	name = "Quick Draw"
	description = "You inherit the teachings of a mighty samurai.
	
	If your first action is an attack with a sword, you gain a 5% chance that no action is consumed."
	
func effect(target: Node) -> int:
	var rng = RandomNumberGenerator.new()
	if WeaponList.held == 1 and rng.randf() <= 0.05:
		effectDone.emit()
		return 0
	effectDone.emit()
	return 1

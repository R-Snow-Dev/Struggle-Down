extends Attribute
class_name Punishment


func _init() -> void:
	type = "hitMult"
	name = "Punishment"
	description = "Hell is meant to torment.

Damage done to burned enemies is increased by 50%."
func effect(target: Node) -> int:
	for e in target.getEffects():
		if e is Burn:
			return 1.50
	effectDone.emit()
	return 1

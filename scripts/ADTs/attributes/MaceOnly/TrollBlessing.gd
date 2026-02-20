extends Attribute
class_name TrollBlessing

func _init() -> void:
	type = "onHit"
	name = "Blessing of the Troll"
	damageType = "blunt"
	description = "Considered the lesser of the Noble Races, Trolls were never a revered species. However, they were among the most feared.  Their maces and clubs were infamous for their quality, able to withstand the might of a Troll.
Burning such a weapon has granted you an echo of their terrible strength. When using a mace, deal an extra 3 blunt damage for point of health you have remaining."
func effect(target: Node) -> int:
	var cHP = SaveController.getData("pHP")
	return 3 * cHP

extends Attribute
class_name BranchBlessing

func _init() -> void:
	type = "passive"
	name = "Blessing of the Sword Tree"
	description = "Burning a limb of the Tree of Swords has granted you its gifts. You now
	have a second weapon slot that will always carry a sword, and cannot be sacrificed. No self respecting
	swordsman would have themselves seen without one, after all."
	
func onPickup(target : Node):
	pass

extends Attribute
class_name LakeBlessing

func _init() -> void:
	type = "onCondition"
	name = "Blessing of the Lake Fairy"
	description = "She who crowns kings has granted you her blessing. When at full health, your
	slashes are fired off as projectiles. These attacks do not pierce. May the light of the old
	knights guide you."
	
func onPickup(target : Node):
	pass

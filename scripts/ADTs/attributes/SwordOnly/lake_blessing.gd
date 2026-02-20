extends Attribute
class_name LakeBlessing

func _init() -> void:
	type = "onCondition"
	name = "Blessing of the Lake Fairy"
	description = "She who crowns kings has granted you her blessing.

When at full health, your slashes are fired off as projectiles. These attacks do not pierce. 

May the light of the old knights guide you."
	
func check(target: DungeonController):
	var sword:Weapon = WeaponList.weapons[1]
	if target.pHP == target.pHPTot:
		sword.setVelo(Vector2(0,1))
		sword.setPierce(false)
	else:
		sword.setVelo(Vector2(0,0))
		sword.setPierce(true)

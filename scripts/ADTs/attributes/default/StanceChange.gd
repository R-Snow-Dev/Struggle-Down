extends Attribute
class_name StanceChange


var default:bool = false

func special(target: Node) -> int:
	print("Stance Change")
	var halberd: Weapon = WeaponList.weapons[5]
	if default:
		halberd.setDim(Vector2i(3,1))
		halberd.setDamageType("slash")
		default = false
	else:
		halberd.setDim(Vector2i(1,3))
		halberd.setDamageType("pierce")
		default = true
	effectDone.emit()
	return 0

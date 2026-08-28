extends Attribute
class_name Typhoon

func _init() -> void:
	type = "passive"
	name = "Typhoon"
	description = "Your inner storm grows.

Wind Charm attack becomes larger."
	
func onPickup(target : Node):
	var w:Weapon = WeaponList.weapons[11]
	w.setDim(Vector2i(w.getDim().x + 2, w.getDim().y + 2))
	w.setOrigin(w.getOrigin() + Vector2(0,-1))

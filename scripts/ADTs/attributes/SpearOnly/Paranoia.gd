extends Attribute
class_name Paranoia

func _init() -> void:
	type = "passive"
	name = "Paranoia"
	description = "You inherit the habits of a survivor.
	
	Spears gain +1 range, but starts 2 tiles behind you."

func onPickup(_target : Node):
	var w: Weapon = WeaponList.weapons[4]
	w.setDim(Vector2i(w.getDim().x, w.getDim().y + 1))
	w.setOrigin(w.getOrigin() - Vector2(0,2))

extends Attribute
class_name Lunge

func _init() -> void:
	type = "passive"
	name = "Lunge"
	description = "You inherit the techniques of a pikeman of great renown.
	
	Spears are now even longer. Gain +1 range for your spears."

func onPickup(target : Node):
	var w = WeaponList.weapons[4]
	w.setDim(Vector2i(w.getDim().x, w.getDim().y + 1))

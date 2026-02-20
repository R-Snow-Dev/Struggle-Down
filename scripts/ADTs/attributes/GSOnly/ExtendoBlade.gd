extends Attribute
class_name ExtendoBlade

func _init() -> void:
	type = "passive"
	name = "Extendo-Sword!"
	description = "The ardent wish of a greatsword is answered.
	
	They are now even longer. Gain +1 range for your greatswords."

func onPickup(target : Node):
	var w = WeaponList.weapons[2]
	w.setDim(Vector2i(w.getDim().x, w.getDim().y + 1))

extends Attribute
class_name ExtremePolish

func _init() -> void:
	type = "active"
	name = "Hyper-Polished"
	description = "The spirit of a powerful blade grants you an enchantment. When 
	using a sword, you may right-click its icon to polish your blade as an action. The
	next time you attack with the weapon, a piercing beam of light will be emitted,
	stunning all enemies that it hits."
	
func effect(target: Node) -> int:
	return 0

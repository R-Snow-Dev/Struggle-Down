extends Attribute
class_name BlackCurse

func _init() -> void:
	type = "passive"
	name = "Black Curse"
	description = "Coalesced hatred belonging to those who succumbed to winter stains your soul. You bear their grudge.
	
	All frost attacks now have a 5% chance to inflict Black Frost. Any enemies infliced with Black Frost will die at the start of their next turn, unless they are of greater caste.
	
	May they only be warmed by the fires of Hell."
	
func onPickup(target : Node):
	WeaponList.addIEffect("frost", "blackfrost", 0.05)

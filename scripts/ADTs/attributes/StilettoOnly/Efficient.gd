extends Attribute
class_name Efficient

func _init() -> void:
	type = "onAttack"
	name = "Efficient Killing"
	description = "You have honed you lethality to its absolute limits. Your entire being has been crafted for one purpose, murder, and you will tolerate no inefficiencies.
	
	Using weapons with action costs of 1 now have a 10% chance to be free actions.
	
	You are very good at what you do."
	
func effect(target: Node) -> int:
	var rng = RandomNumberGenerator.new()
	var w:Weapon = WeaponList.weapons[WeaponList.held]
	if w.getCost() == 1 and rng.randf() <= 0.1:
		return 0
	return 1

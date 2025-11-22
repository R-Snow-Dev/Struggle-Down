extends Attribute
class_name SwordAxiom

func _init() -> void:
	type = "onHit"
	name = "Axiom of the Sword"
	description = "By absorbing the spirit of the blade, you touch something deeper. When attacking
	with a sword, you gain a 5% chance to deal extra damage. This extra damage is equal
	to the total damage done by your sword, including all extra damage types. This damage is special damage,
	and cannot be resisted. If only briefly, you touch the absolute with only your sword."
	
func effect(target: Node) -> int:
	var rng = RandomNumberGenerator.new()
	if WeaponList.held == 1 and rng.randf() < 0.05:
		var w: Weapon = WeaponList.weapons[1]
		var damage = w.getBaseDam()
		for x in w.getExtraAttacks():
			damage += WeaponList.damages[x]
		return damage
	return 0
			
	

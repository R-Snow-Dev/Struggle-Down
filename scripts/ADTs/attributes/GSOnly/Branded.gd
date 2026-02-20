extends Attribute
class_name Brand

var stored: int = 0

func _init() -> void:
	type = "active"
	name = "Black Brand"
	damageType = "special"
	description = "The power within the blade carves it's brand on your flesh. 

Gain an active ability on all greatswords. Right click on your greatsword to ready the attack. On your next attack, deal special damage equal to how many enemies you defeated before it's use. The amount stored is then reset.
 
Ascend and eclipse all."

func onPickup(target : Node):
	var gSword: Weapon = WeaponList.weapon[2]
	gSword.setSpeAttribute(self)

func special(target: Node) -> int:
	if stored > 0:
		WeaponList.addTempDamage("special", stored)
		stored = 0
	return 0

func store(node: Node) -> void :
	if node is Fiend:
		stored += 1
	else:
		pass

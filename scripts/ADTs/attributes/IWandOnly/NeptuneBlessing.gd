extends Attribute
class_name NeptuneBlessing

var default:bool = false

func _init() -> void:
	type = "active"
	name = "Neptune's Blessing"
	description = "The Northman went by many names, but only one of his identities had his axe replaced my a mighty wand. Perhaps there was truth to this.
	
	Your Ice Wands gain the ability to freely switch between forms when right clicked. The default form shoots a projectile, while the new form slows all enemies in a room, but deals no weapon damage.
	
	Embody the myth."
	
func onPickup(target : Node):
	var wand:Weapon = WeaponList.weapons[8]
	wand.setSpeAttribute(self)


func special(target: Node) -> int:
	print("Stance Change")
	var wand: Weapon = WeaponList.weapons[8]
	if default:
		wand.setVelo(Vector2(0,175))
		wand.setDamageType('frost')
		wand.setBaseDam(5)
		wand.setDim(Vector2i(1,1))
		wand.setChance('slow', 0.0)
		default = false
	else:
		wand.setVelo(Vector2(0,0))
		wand.setDamageType('frost')
		wand.setBaseDam(0)
		wand.setDim(Vector2i(22,22))
		wand.setChance('slow', 1.0)
		default = true
	effectDone.emit()
	return 0
	

extends Attribute
class_name Serration

func _init() -> void:
	type = "active"
	name = "Serration"
	description = "The spirit of a chipped blade grants you it's grudge. 

When using a sword, you may right-click its icon to serrate its edge at the cost of an action. The next time you attack with the sword, you will deal a bonus 3 slashing damage, and gain an extra 50% chance to bleed."
	
func onPickup(target : Node):
	var sword:Weapon = WeaponList.weapons[1]
	sword.setSpeAttribute(self)
	
func special(target: Node) -> int:
	if target.actionsAvailable > 0:
		WeaponList.addTempEffect("bleed", 0.5)
		WeaponList.addTempDamage("slash", 3)
		EventBus.updateActions.emit(-1, "move")
	return 0

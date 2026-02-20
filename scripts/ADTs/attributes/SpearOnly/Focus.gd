extends Attribute
class_name Focus

var focused: bool = false

func _init() -> void:
	type = "active"
	name = "Deadly Focus"
	description = "You inherit the patience of a successful hunter.
	
	When using a spear, you may right-click its icon as an action. If you do, our next atack gains an 100% chance to cause bleed."

func onPickup(target : Node):
	var spear:Weapon = WeaponList.weapons[4]
	spear.setSpeAttribute(self)
	spear.setAtkAttribute(self)
	
func special(target: Node) -> int:
	if !focused and target.actionsAvailable > 0:
		focused = true
		WeaponList.addTempEffect("bleed", 1.0)
		EventBus.updateActions.emit(-1, "move")
	return 0
	
func effect(target: Node) -> int:
	focused = false
	return 0

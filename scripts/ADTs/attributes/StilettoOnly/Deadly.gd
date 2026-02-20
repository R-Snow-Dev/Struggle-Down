extends Attribute
class_name Deadly

var focused: bool = false
var rng = RandomNumberGenerator.new()

func _init() -> void:
	type = "active"
	name = "Deadly Focus"
	description = "You inherit the patience of a successful hunter.
	
	When using a stiletto, you may right-click its icon as an action. If you do, our next atack gains an 100% chance to cause bleed."

func onPickup(target : Node):
	var stiletto:Weapon = WeaponList.weapons[6]
	stiletto.setSpeAttribute(self)
	stiletto.setAtkAttribute(self)
	
func special(target: Node) -> int:
	if !focused and target.actionsAvailable > 0:
		focused = true
		WeaponList.addTempEffect("bleed", 1.0)
		EventBus.updateActions.emit(-1)
	return 0
	
func effect(target: Node) -> int:
	focused = false
	var w: Weapon = WeaponList.weapons[6]
	if rng.randf() > 0.666:
		w.setCost(1)
	else:
		w.setCost(0)
	return 0

extends Attribute
class_name StrategicWeaponry

var stance:bool = false

func _init() -> void:
	type = "active"
	name = "Strategic Weaponry"
	description = "You gain brains to match your brawn. 

You may right click to swap how you attack at the cost of an action. If you do, attacking will consume only a single action and deal unmultiplied damage. You may swap between standard attacking and this modified attack method whenever you please."
	
func onPickup(target : Node):
	var mace:Weapon = WeaponList.weapons[3]
	mace.setSpeAttribute(self)
	
func special(target: Node) -> int:
	print("click")
	var mace: Weapon = WeaponList.weapons[3]
	if target.actionsAvailable > 0:
		if stance:
			mace.setAtkAttribute(MaceMult.new())
			stance = false
		else:
			mace.setAtkAttribute(self)
			stance = true
		EventBus.updateActions.emit(-1, "move")
	return 0
	
func effect(target: Node) -> int:
	var mace: Weapon = WeaponList.weapons[3]
	mace.setCost(1)
	mace.setAtkDam(mace.getBaseDam())
	return 0

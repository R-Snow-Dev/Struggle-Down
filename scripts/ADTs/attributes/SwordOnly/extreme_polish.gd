extends Attribute
class_name ExtremePolish

var shine = false
var beam: Lightbeam = preload("res://scenes/Projectiles/LightBeam.tscn").instantiate()

func _init() -> void:
	type = "active"
	name = "Hyper-Polished"
	description = "The spirit of a powerful blade grants you an enchantment. 

When using a sword, you may right-click its icon to polish your blade as an action. The next time you attack with the weapon, a piercing beam of light will be emitted, stunning all enemies that it hits."
	
func onPickup(target : Node):
	var sword:Weapon = WeaponList.weapons[1]
	sword.setAtkAttribute(self)
	sword.setSpeAttribute(self)


func special(target: Node) -> int:
	if !shine and target.actionsAvailable > 0:
		shine = true
		EventBus.updateActions.emit(-1, "move")
	return 0
	
func effect(target: Node) -> int:
	if shine:
		beam.setDam(0)
		beam.setType('special')
		EventBus.throwEffect.emit(beam)
		shine = false
	return 0

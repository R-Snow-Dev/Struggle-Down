extends Attribute
class_name PetersBlessing

func _init() -> void:
	type = "active"
	name = "Peter's Blessing"
	description = "Peter walked with The One Above, leanred his ways and preached his will. He became a conduit for the Light, and became a living miracle.
	
	Click this upgrade's icon located at the bottom of the screen to gain a full heal, but lose your current weapon.
	The greatest joys require sacrifice.
	"
	
func pressed() -> void:
	if WeaponList.held != 0:
		EventBus.swap_weapon.emit(0)
		EventBus.update_hp.emit(SaveController.getData('pHP') - SaveController.getData('curHP'))

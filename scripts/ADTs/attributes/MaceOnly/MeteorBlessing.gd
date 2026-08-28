extends Attribute
class_name MeteorBlessing

var explosion = preload("res://scenes/DungeonParts/explosion.tscn")

func _init() -> void:
	type = "onHit"
	name = "Blessing of the Harbringer"
	description = " The deaths of the Soothsayers were brought upon by a traitor, bearing a mace born from the origin of their apotheosis. By burning the accursed weapon, it returns once again to stardust, and bestows upon you a blessing. All mace attacks trigger a floor-wide shockwave, dealing un-resistable damage equal to the mace's base damage and extra shockwave damage. "

func effect(target: Node) -> int:
	if WeaponList.held == 3:
		var damage = WeaponList.weapons[3].getBaseDam() + WeaponList.damages["shockwave"]
		EventBus.summon.emit(target, explosion, damage, "special")
	effectDone.emit()
	return 0

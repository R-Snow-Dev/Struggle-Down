extends Attribute
class_name Betrayer

func _init() -> void:
	type = "onHit"
	name = "Betrayer's Blessing"
	damageType = "special"
	description = "One may forget that the Twin Gods once had another brother. Beloved by both, it was his death that caused the great armies to clash. It was said that it was one of the armies' generals that slew the god, though none claimed him. You bear his legacy now. Stilettos will deal extra damage equal to its total damage when attacking from behind. This damage cannot be resisted."
	
func effect(target: Node) -> int:
	var stiletto: Weapon = WeaponList.weapons[6]
	var eFacing = Vector2i(target.get_data().getFacing())
	if stiletto.getFacing() == eFacing:
		var damage = stiletto.getAtkDam()
		for x in stiletto.getExtraAttacks():
			damage += WeaponList.damages[x]
		effectDone.emit()
		return damage
	effectDone.emit()
	return 0

extends Attribute
class_name OlympusBlessing

var l = preload("res://scenes/Projectiles/Sprites/longBolt.tscn")

func _init() -> void:
	type = "active"
	name = "Divine Descent"
	description = "Lightning is said to be the wrath of the heavens. The gods wreath themselves in pure plasma, descending to the mortal plane to the sound of thunder.
	
	Click the upgrade icon located at the bottom of the screen to teleport. You may only teleport to open tiles, and it will spend all ypur available actions.
	
	Bring with you divine judgement."

func pressed() -> void:
	EventBus.pause.emit()
	var t: teleport = preload("res://scenes/DungeonParts/Teleport_Reticle.tscn").instantiate()
	Overseer.control.add_child(t)
	await t.all_done
	var j = WeaponList.createNewAOE(l.instantiate(), Vector2(1,1), Vector2(0,0), 'shock', 5, 'stun', 1)
	j.z_index += 10
	EventBus.summon.emit(Overseer.control.player,j)
	EventBus.unpause.emit()

extends Attribute
class_name Olympus
var rng = RandomNumberGenerator.new()

func effect(target: Node) -> int:
	return 0

func special(target: Node) -> int:
	print('go')
	if Overseer.getController().player.actionsAvailable > 0:
		print('go')
		EventBus.pause.emit()
		var s = preload("res://scenes/Projectiles/Sprites/longBolt.tscn").instantiate()
		var j = WeaponList.createNewAOE(s, Vector2(1,1), Vector2(0,0), 'shock', 10, 'stun', 0.5)
		for o in Overseer.getBoard().objects:
			if o is Fiend:
				print(o)
				j.global_position = o.global_position
				Overseer.getController().add_child(j)
				break
		EventBus.unpause.emit()
		EventBus.updateActions.emit(-1)
	return 0

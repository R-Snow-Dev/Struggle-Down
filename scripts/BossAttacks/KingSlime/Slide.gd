extends BossAttack
class_name KingSlide

func warn() -> void:
	var m = atckr
	var f = m.getData().getFacing()
	if f.x == 0:
		if f.y > 0:
			EventBus.warn.emit(Vector2(1,1), Vector2(-1, 10.25 - m.getPos().y))
		else:
			EventBus.warn.emit(Vector2(1,-1), Vector2(-1, -1-m.getPos().y))
	else:
		if f.x > 0:
			EventBus.warn.emit(Vector2(1,1), Vector2(10 - m.getPos().x, -1))
		else:
			EventBus.warn.emit(Vector2(-1,1), Vector2(-1-m.getPos().x, -1))

func attack():
	var targ = Overseer.closestLOS(atckr.getPos(), atckr.getData().getFacing(), Vector2(0, 1), "fiend")
	var valuesMiss = [[atckr.getPos().x,atckr.getPos().y],[9, 9],[0,0]]
	var valuesHit = [[atckr.getPos().x,atckr.getPos().y],[targ.x - 3, targ.y - 3],[targ.x,targ.y]]
	var facing = Vector2i(atckr.getData().getFacing())
	var animPlayer = atckr.anim
	var c = animPlayer.get_animation("Charge")
	var a = Vector2i(facing * 12)
	var s = Vector2i(atckr.getPos() * 16)
	print(targ, "target")
	if targ.x == 0 and targ.y == 0:
		print("miss")
		targ = Vector2i(valuesMiss[facing.x][0], valuesMiss[facing.y][1]) * 16
	else:
		targ = Vector2i(valuesHit[facing.x][0], valuesHit[facing.y][1]) * 16
		targ += abs(Vector2i(facing * s))
		print(Vector2i(facing * s), "Formula")
		print(targ, "target")
		targ += Vector2i(16,16)* abs(facing)
	print(s, "start")
	s += Vector2i(8,4)
	print(targ, "target")
	targ += Vector2i(8,4)
	# Modifies the key frames in the animation so that the boss moves in the correct direction 
	# Foe the correct amount of time
	c.track_set_key_value(0,0,s)
	c.track_set_key_value(0,1,targ + a)
	c.track_set_key_value(0,2,targ - Vector2i(0,4))
	c.track_set_key_value(0,3,targ)
	# Play the animation
	animPlayer.play("Charge")
	EventBus.stop_warn.emit()
	atckr.setDelay(1)

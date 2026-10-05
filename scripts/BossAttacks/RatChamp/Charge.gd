extends Attack
class_name RatCharge
		
func warn() -> void:
	var targ = atckr.getData().getBehavior().getIdeal()
	EventBus.warn.emit(atckr.getPos(), targ)
	
func attack():
	print(Overseer.getGrid()[0][0])
	var targ = atckr.getData().getBehavior().getIdeal()
	print('charge! ', targ)
	print('Target', targ)
	var facing = Vector2i(atckr.getData().getFacing())
	var animPlayer = atckr.anim
	var c = animPlayer.get_animation("Charge")
	var a = Vector2(facing)
	var s = Vector2(atckr.getPos() * 16)
	s.y -= 16
	targ *= 16
	
	if atckr.getCurState() == 's':
		targ.y -= 16
		targ.x -=  atckr.getData().getFacing().x * 16
	if atckr.getCurState() == 'd':
		targ.y -= 24
	
	print('CHARGE! ', targ)
	# Modifies the key frames in the animation so that the boss moves in the correct direction 
	# Foe the correct amount of time
	c.track_set_key_value(0,0,s)
	c.track_set_key_value(0,1,targ + a)
	c.track_set_key_value(0,2,targ)
	# Play the animation
	atckr.sprite.play('stab-'+str(atckr.getCurState()))
	AudioManager.play_sound('RCPrep')
	await atckr.sprite.animation_finished
	AudioManager.play_sound('RCCharge')
	animPlayer.play("Charge")
	EventBus.stop_warn.emit()
	atckr.setDelay(1.5)

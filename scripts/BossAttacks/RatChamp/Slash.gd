extends Attack
class_name RatSlash

func warn() -> void:
	var f = atckr.getData().getFacing()
	var p1 = atckr.getPos() - Vector2(f.y,f.x)
	var p2 = (atckr.getPos() + Vector2(f.y,f.x)) + f * 2
	EventBus.warn.emit(p1,p2)
	
func attack() -> void:
	var animPlayer = atckr.anim
	atckr.sprite.play('slash-'+str(atckr.getCurState()))
	AudioManager.play_sound('RCPrep')
	await atckr.sprite.animation_finished
	animPlayer.play("slash")
	AudioManager.play_sound('Melee')
	EventBus.stop_warn.emit()
	atckr.setDelay(0.5)

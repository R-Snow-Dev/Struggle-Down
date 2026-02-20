extends BossAttack
class_name KingJump

var landingSpot: Vector2i = Vector2i(5,5)

func warn() -> void:
	landingSpot = Vector2i(randi_range(4,5), randi_range(4,5))
	EventBus.warn.emit(Vector2((landingSpot.x - atckr.getData().getPos().x) - 2, (landingSpot.y - atckr.getData().getPos().y) - 1.75), Vector2((landingSpot.x - atckr.getData().getPos().x) + 2, (landingSpot.y - atckr.getData().getPos().y) + 2))
	

func attack():
	# Function that animates the King Slime's jump attack.
	# @param boss - A reference back to the Boss Object of the King Slime

	# Get the animation player of the Boss Object
	var animPlayer = atckr.anim
	var jump = animPlayer.get_animation("Jump") # Get the animation that will be altered
	
	# Get the starting location of the animation, and the end
	var targ = landingSpot * 16
	var s = Vector2i(atckr.getData().getPos() * 16)
	targ += Vector2i(8,4)
	s += Vector2i(8,4)
	# Alter keyframes to be in acoordance with the start and end positions
	jump.track_set_key_value(0,0,s)
	jump.track_set_key_value(0,1,Vector2i(targ.x, -1000))
	jump.track_set_key_value(0,2,targ)
	
	# Play the animation
	animPlayer.play("Jump")
	EventBus.stop_warn.emit()
	atckr.setDelay(1.8)
	

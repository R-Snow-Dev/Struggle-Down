extends Attack
class_name RatSummon

var positions = []
var rng = RandomNumberGenerator.new()

func warn() -> void:
	print('warnin')
	positions = []
	var pos = atckr.getData().getPos()
	while len(positions) < 1:
		var p = Vector2(rng.randi_range(0,11), rng.randi_range(0,11))
		if Overseer.checkValid(p):
			positions.append(p)
			print("found")
			EventBus.warn.emit(p,p)
	
func attack():
	atckr.sprite.play('summon')
	AudioManager.play_sound('Summon')
	await atckr.sprite.animation_finished
	for v in positions:
		Overseer.getController().createRat(v)
	atckr.setDelay(1)

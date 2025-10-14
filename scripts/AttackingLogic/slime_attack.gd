extends Attack
class_name SlimeAttack

func attack():
# Depending on the way the attacker is facing, play the appropriate attacking animation
# param - atckr: the fiend doing the attacking.
	if atckr.getData().getFacing() == Vector2(0,1):
		atckr.playAnim("atkD")
	elif atckr.getData().getFacing() == Vector2(0,-1):
		atckr.playAnim("atkU")
	elif atckr.getData().getFacing() == Vector2(-1,0):
		atckr.playAnim("atkL")
	elif atckr.getData().getFacing() == Vector2(1,0):
		atckr.playAnim("atkR")

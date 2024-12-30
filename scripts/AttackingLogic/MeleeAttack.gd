"""
Multi-pupose attacking script that functions as long as the fiend sprite has the appropriate methods
and animations (atkR, atkL, atkU, atkD and playAnim(anim: String)
"""

extends "res://scripts/AttackingLogic/AttackBehavior.gd"



func _init(dam: int) -> void:
	# Inherit all needed variables from the parent class
	super(dam)
	
func attack(atker: Object):

# Depending on the way the attacker is facing, play the appropriate attacking animation
# param - atker: the fiend doing the attacking.
	if atker.facing == "up":
		atker.sprite.playAnim("atkD")
	elif atker.facing == "down":
		atker.sprite.playAnim("atkU")
	elif atker.facing == "left":
		atker.sprite.playAnim("atkL")
	elif atker.facing == "right":
		atker.sprite.playAnim("atkR")
		
	

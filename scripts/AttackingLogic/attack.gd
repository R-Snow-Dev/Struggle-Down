"""
Root node for all attacking animations
Decides what animation to perform based on function is called from the AttackOrigin
"""

extends Node2D
@onready var slash_tip: CPUParticles2D = $SlashTip
	
func slash(range:Vector2):
	
	position.x = -8 - (16*(((range.x-1)/2)))
	
	slash_tip.slash(range)

func _on_slash_tip_finished() -> void:
	EventBus.playerDoneAttacking.emit()

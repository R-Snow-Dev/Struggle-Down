"""
Root node for all attacking animations
Decides what animation to perform based on function is called from the AttackOrigin
"""

extends Node2D
@onready var slash_tip: CPUParticles2D = $SlashTip
@onready var pierce_tip: CPUParticles2D = $PierceTip
	
func slash(r:Vector2):
	
	position.x = -8 - (16*(((r.x-1)/2)))
	position.y = -16
	
	slash_tip.slash(r)
	
func pierce(r:Vector2):
	position.y = 0
	position.x = 0
	pierce_tip.pierce(r)

func _on_slash_tip_finished() -> void:
	EventBus.playerDoneAttacking.emit()

func _on_pierce_tip_finished() -> void:
	EventBus.playerDoneAttacking.emit()

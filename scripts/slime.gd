extends AnimatedSprite2D

@onready var attack_particles: CPUParticles2D = $AttackParticles
@onready var atk_anims: AnimationPlayer = $atkAnims

var dam: int

# Sets the amount of damage the slime does
func setDam(damage: int):
	dam = damage

# Necessary Function for all fiend sprites, so that any animation can be called on from it's parent node
func playAnim(anim: String):
	atk_anims.play(anim)

func _on_hitbox_area_entered(area: Area2D) -> void:
	# When the sprite hits an opponent, this function is called
	
	attack_particles.restart() # Emits a particle effect representing contact
	EventBus.update_hp.emit(dam * -1) # Decrease player HP by the sprites "dam" value

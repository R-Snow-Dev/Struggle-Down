extends AnimatedSprite2D

@onready var attack_particles: CPUParticles2D = $AttackParticles
@onready var atk_anims: AnimationPlayer = $atkAnims

var dam: int
var health: int

# Sets the amount of damage the slime does
func setDam(damage: int):
	dam = damage

# Necessary Function for all fiend sprites, so that any animation can be called on from it's parent node
func playAnim(anim: String):
	atk_anims.play(anim)

func _on_hitbox_area_entered(area: Area2D) -> void:
	# When the sprite hits an opponent or hurtbox, this function is called
	attack_particles.restart() # Emits a particle effect representing contact
	
	if area is Player:# If the slime made contact with the player
		EventBus.update_hp.emit(dam * -1) # Decrease player HP by the sprites "dam" value
	elif area is Hurtbox: # If it made contact with something else, that means it has been attacked
		health -= area.damage
		

extends MeshInstance2D

var facing: Vector2
@onready var attack_particles: CPUParticles2D = $AttackParticles
@onready var atk_anims: AnimationPlayer = $atkAnims

func playAnim(anim: String):
	atk_anims.play(anim)

func positionShift():
	position += facing * Vector2(16,16)

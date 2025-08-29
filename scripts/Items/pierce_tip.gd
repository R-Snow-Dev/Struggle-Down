extends CPUParticles2D

@onready var pierce_base = $PierceBase

func pierce(r: Vector2):
	
	# The amount of particles emitted
	amount = 30 * (r.y*1.5)
	pierce_base.amount = amount
	
	# The amount of spread during time of travel
	spread = 3 - (0.2*r.y)
	
	# The lifetime of each particle
	lifetime = 0 + (0.038 * r.y)
	pierce_base.lifetime = lifetime
	
	# How wide the pierce is
	emission_rect_extents = Vector2(r.x*16 - 16, 1)
	pierce_base.emission_rect_extents = emission_rect_extents/2
	
	# The position of the effect
	position = Vector2(0, 8-(8*r.x))
	
	# play the effect
	restart()
	pierce_base.restart()

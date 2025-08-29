"""
Code that changes the parameters of a slashing particle effect depending on given parameters
"""

extends CPUParticles2D
@onready var slash_base: CPUParticles2D = $SlashBase

func slash(r: Vector2):
	
	# The amount of particles emitted
	amount = 30 * (r.y*1.5)
	slash_base.amount = amount
	
	# The amount of spread during time of travel
	spread = 3 - (0.2*r.x)
	
	# The lifetime of each particle
	lifetime = 0 + (0.04*r.x)
	slash_base.lifetime = lifetime
	
	# How fast the particles curve downwards
	orbit_velocity_min = -0.13 + (0.01*r.x)
	slash_base.orbit_velocity_min = orbit_velocity_min
	orbit_velocity_max = -0.13 + (0.01*r.x)
	slash_base.orbit_velocity_max = orbit_velocity_min
	
	# How tall the slash is
	emission_rect_extents = Vector2(1, r.y*16 - 16)
	slash_base.emission_rect_extents = emission_rect_extents/2
	
	# The position of the effect
	position = Vector2(0, 8 - (8*r.y))
	
	# play the effect
	restart()
	slash_base.restart()

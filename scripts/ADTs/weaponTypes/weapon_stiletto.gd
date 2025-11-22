extends Weapon
class_name Stiletto

"""
Inherits from the Weapon ADT. Represents a Stiletto in game
"""

var rng = RandomNumberGenerator.new()

func onAttack(_data) -> void:
	if rng.randf() > 0.666:
		setCost(1)
	else:
		setCost(0)

extends Weapon
class_name Mace

"""
Inherits from the Weapon ADT. Represents a Mace in game
"""

func onAttack(data) -> void:
	setCost(data)
	setBaseDam(data * 5)

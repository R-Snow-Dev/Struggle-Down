extends Weapon
class_name Halberd

"""
Inherits from the Weapon ADT. Represents a Halberd in game
"""

func onSpecial(_data) -> void:
	print("Special")
	if getDamageType() == "slash":
		setDamageType("pierce")
		setDim(Vector2i(1,3))
	else:
		setDamageType("slash")
		setDim(Vector2i(3,1))

"""
A sub health bar below the main one taht never changes. When the main one decreases, this one is slowly revealed, showing the player how
many hearts they have lost
"""

extends Label

	
func loadHearts(amount: int):
	# Creates the unchanging health bar based on the player's max HP
	# param - amount: The player's max HP
	var displayedHearts = ""
	for i in range(amount/2):
		displayedHearts += "AB"
	if amount%2 != 0:
		displayedHearts += "A"
	self.text = displayedHearts

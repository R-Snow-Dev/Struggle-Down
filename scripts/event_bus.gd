'''
Global signal bank. Allows use of signals easily between instances
'''

extends Node2D

# Player gets on or off a doorway. 
# Param - on: A boolean that tells you if the player stepped on or off the doorway
signal on_door(on: bool)

# A Signal that tells the game controller to switch to a new room
# Param - direction: A Vector2 that tells how much in each direction to move on the map
# Param - startPos: A string that will be translated into a new starting position by the game controller
#					Possible inputs are: "top", "bottom", "right", "left"
signal changeRooms(direction: Vector2, startPos: String)

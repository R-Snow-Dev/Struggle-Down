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

# Signal that tells the action text that it needs to change it's displayed number.
signal updateActions(amount: int)

# Signal that resets the action text to the max amount 
signal actionsReset(amount: int)

# Signal that is emitted when a fiend has finished it's actions
signal doneAttacking()

# Tells the dungeon controller that it is the fiend's turn to attack
signal fiend_phase(amount: int)

# Changes the player's hp and the hp bar when emitted
signal update_hp(amount:int)

# Emiited upon completion of the player's deth animation
signal on_death()

# Emits upon the death of a fiend, signalling the fiend to be removed from the board
signal object_ded(fiend:Object)

# Signal that is emittd whenever a new item is picked up
signal swap_weapon(Id: int)

# Signal that is emitted whenever the player attacks
signal attack(weapon: Array)

# signal that is emitted whenever a player is finished attacking
signal playerDoneAttacking()

# Signal that is emitted whenever the mouse hovers over the attack button
signal updateAOE(height: int, width: int, pointOfOrigin: String)

# Signal that is emitted whenever the game is paused
signal pause()

# Signal that is emitted whenever the game is unpaused
signal unpause()

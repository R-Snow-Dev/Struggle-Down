'''
Global signal bank. Allows use of signals easily between instances
'''

extends Node2D

# Player gets on or off a doorway. 
# Param - on: A boolean that tells you if the player stepped on or off the doorway
@warning_ignore("unused_signal")
signal on_door(on: bool)

# A Signal that tells the game controller to switch to a new room
# Param - direction: A Vector2 that tells how much in each direction to move on the map
# Param - startPos: A string that will be translated into a new starting position by the game controller
#					Possible inputs are: "top", "bottom", "right", "left"
@warning_ignore("unused_signal")
signal changeRooms(direction: Vector2, startPos: String)

# Signal that tells the action text that it needs to change it's displayed number.
@warning_ignore("unused_signal")
signal updateActions(amount: int, type: String)

# Signal that updtaes the total amount of action available, and resets the actions taken
@warning_ignore("unused_signal")
signal updateTotActions(amount: int)

# Signal that is called when the action icon must update
@warning_ignore("unused_signal")
signal updateShoe(amount: int)

# Signal that resets the action text to the max amount 
@warning_ignore("unused_signal")
signal actionsReset(amount: int)

# Signal that is emitted when a fiend has finished it's actions
@warning_ignore("unused_signal")
signal doneAttacking()

# Tells the dungeon controller that it is the fiend's turn to attack
@warning_ignore("unused_signal")
signal fiend_phase()

# Changes the player's hp and the hp bar when emitted
@warning_ignore("unused_signal")
signal update_hp(amount:int)

# Changes the total hp of the player and fully heals them
@warning_ignore("unused_signal")
signal update_total_hp(amount: int)

# Emiited upon completion of the player's deth animation
@warning_ignore("unused_signal")
signal on_death()

# Emits upon the death of a fiend, signalling the fiend to be removed from the board
@warning_ignore("unused_signal")
signal object_ded(fiend:Object)

# Signal that is emittd whenever a new item is picked up
@warning_ignore("unused_signal")
signal swap_weapon(Id: int)

# Signal that is emitted whenever the player attacks
@warning_ignore("unused_signal")
signal attack(id: int)

# signal that is emitted whenever a player is finished attacking
@warning_ignore("unused_signal")
signal playerDoneAttacking()

# Signal that is emitted whenever the mouse hovers over the attack button
@warning_ignore("unused_signal")
signal updateAOE(id: int)

# Signal that is emitted whenever the game is paused
@warning_ignore("unused_signal")
signal pause()

# Signal that is emitted whenever the game is unpaused
@warning_ignore("unused_signal")
signal unpause()

# Signal that is broadcasted when enetring the file select menu
@warning_ignore("unused_signal")
signal file_select()

# Signal that is emitted when saving your weapon data to the save file
@warning_ignore("unused_signal")
signal save_data()

# Signal that is emitted when entering a new level
@warning_ignore("unused_signal")
signal new_level()

# Signal that is emitted when a dungeon run is started
@warning_ignore("unused_signal")
signal start()

# Signal that is emitted when a boss is preparing a big attack
@warning_ignore("unused_signal")
signal warn(p1: Vector2, p2: Vector2)

# Signal that is emitted to clear all warning emitted by a boss
@warning_ignore("unused_signal")
signal stop_warn()

# Signal that is emitted when a boss dies, and stairs must be generated
@warning_ignore("unused_signal")
signal create_stairs(pos: Vector2)

# Signal that is emitted when the player is hit by an attack that must move them
@warning_ignore("unused_signal")
signal bump()

# Signal that is emitted when the slime King summons minions
@warning_ignore("unused_signal")
signal createSlime(p: Vector2)

# Signal that is emitted when the slime king heals by killing a minion
@warning_ignore("unused_signal")
signal healSK()

# Signal that is emitted to change the player's gold count
@warning_ignore("unused_signal")
signal updateGold(num: int)


# Signal that is broadcasted when entering a dungeon from the pouch
@warning_ignore("unused_signal")
signal go()

# signal that is emitted when the player adds or removes from the inventory
@warning_ignore("unused_signal")
signal updateInv()

# Switches the displayed item in the inventory
@warning_ignore("unused_signal")
signal changeItem(id: int)

# Unlocks the doors in a room
@warning_ignore("unused_signal")
signal unLock()

# Locks the doors in a room
@warning_ignore("unused_signal")
signal reLock()

# Called when something needs to be delayed
@warning_ignore("unused_signal")
signal delay(time:float)

# Called when a delay has ended
@warning_ignore("unused_signal")
signal delayEnd()

# Called when the weapon slot is right clicked
@warning_ignore("unused_signal")
signal spWeapon(id: int)

# Called when the game board updates
@warning_ignore("unused_signal")
signal updatedView()

# Called when a player enters or exits an altar
@warning_ignore("unused_signal")
signal updateAltar()

# Called when the player sacrifices a weapon
@warning_ignore("unused_signal")
signal sac(a: Attribute)

# Signal that is called when an upgrade is added to the container
@warning_ignore("unused_signal")
signal uCont(a: Attribute)

# Signal that is emitted when the upgrade container needs to be reset
@warning_ignore("unused_signal")
signal rUCont()

# Signal that causes a target to spawn an entity on their position
@warning_ignore("unused_signal")
signal summon(target: Node, entity: Node2D)

# Signal that adds a weapon effect into the dungeon
@warning_ignore("unused_signal")
signal throwEffect(effect: PackedScene, damage: int, type: String)

# Signal that sends the user to the title screen
@warning_ignore("unused_signal")
signal title_screen()

# Signal used to force reticles to appear based on projectile data
@warning_ignore("unused_signal")
signal hoverProj(p: Projectile)

# Signal that calls the offHover function from the WeaponOrigin
@warning_ignore("unused_signal")
signal offHover()

# Signal that is called to trigger turn start effects
@warning_ignore("unused_signal")
signal playersTurnStart()

# Signal that is called when the player should summon an entity to the board
@warning_ignore("unused_signal")
signal throwEntity()

# Signal that is called when the board needs to eliminate all entities
@warning_ignore("unused_signal")
signal killEntities()

# sigal that is used when a filled component slot is selected
@warning_ignore("unused_signal")
signal compChosen(c: Components)

# Signal that is called when an empty component slot is selected
@warning_ignore("unused_signal")
signal removeComp(t: int)

# Signal that calls a displyer entity to show the data from a given component
@warning_ignore("unused_signal")
signal displayComp(c: Components)

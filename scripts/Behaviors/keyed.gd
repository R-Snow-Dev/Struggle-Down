extends Node2D

class_name Keyed

"""
Class that gives the Interactable class the qualities of an keyed lock
"""

var state = false

func interact():
	var keys = Overseer.getController().keys
	if keys > 0 and state == false:
		state = true
		AudioManager.play_sound('GetWeapon')
		Overseer.getController().delKey()
	
func reset():
	pass

func getState():
	return state

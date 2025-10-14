extends Node2D

class_name UnlockRelock

"""
Class that gives the Interactable class the qualities of an on/off switch
"""

var state = false

func interact():
	state = true
	

func reset():
	state = false

func getState():
	return state

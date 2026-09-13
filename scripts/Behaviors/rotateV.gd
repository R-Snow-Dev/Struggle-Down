extends Node2D

class_name RotateV

"""
Class that gives the Interactable class the qualities of an on/off switch
"""

var state = true

func interact():
	print('Pressed')
	Overseer.getBoard().rotateRoomV()
	

func reset():
	state = true

func getState():
	return state

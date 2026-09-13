extends Node2D

class_name RotateH

"""
Class that gives the Interactable class the qualities of an on/off switch
"""

var state = true


func interact():
	print('Pressed')
	Overseer.getBoard().rotateRoomH()

func reset():
	state = true

func getState():
	return state

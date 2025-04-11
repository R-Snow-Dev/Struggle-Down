'''
Class that handles the creation and deletion of a boss's warning zones
'''

extends Node2D


func _ready() -> void:
	EventBus.warn.connect(setWarning)
	EventBus.stop_warn.connect(reset)

func setWarning(point1: Vector2, point2: Vector2):
	# Adds a new warning zone as a child, and sets its bounds based on given points
	# @param point1 - the first point of the new warning zone
	# @param point2 - the second point of the new warning zone
	var area = preload("res://scenes/warning_area.tscn")
	area = area.instantiate()
	area.setBounds(point1, point2)
	add_child(area)

func reset():
	# Parses through all the warning zones currently active, and deletes them all
	for child in get_children():
		remove_child(child)
		child.queue_free()

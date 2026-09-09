extends Control
class_name StatusBar

const IDS = {'Bleed': 0,
				'Slow':1,
				'Stun': 2,
				'Burn':3,
				'Black Frost':4,
				'Explosion Chain': 5}

var markers = {}

@onready var box: HBoxContainer = $HBoxContainer

func add(s: Effect) -> void:
	if not markers.has(s.name):
		print('adding ', s.name)
		var m: StatusMarker = preload("res://scenes/GUIParts/status_marker.tscn").instantiate()
		markers[s.name] = m
		box.add_child(m)
		m.setup(IDS[s.name])
		
func reset() -> void:
	markers = {}
	for c in box.get_children():
		box.remove_child(c)

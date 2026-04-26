extends Control
class_name Options

@onready var master = $"Options/Audio/Master Volume/Master Slider"
@onready var sfx = $"Options/Audio/SFX & Music/SFX Volume/SFX Slider"
@onready var music = $"Options/Audio/SFX & Music/Music Volume/Music Slider"

var path = "res://saveFiles/Options.json"

var data = {'master': 0.5,
			'sfx': 0.5,
			'music': 0.5}

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('Pause'):
		save(data)

func _ready() -> void:
	if !FileAccess.file_exists(path):
		save(data)
	data = loadData()
	master.value = data['master']
	sfx.value = data['sfx']
	music.value = data['music']
	

func loadData():
	# Loads and returns data from a save file
	# @param path: path to the file to load data from
	# return: A dictionary if load was succesful, otherwise nothing
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var dataStr = file.get_as_text()
		var data = JSON.parse_string(dataStr)
		file.close()
		return data
	else:
		print("Failed to retrieve file at path: " + path)

func save(dict: Dictionary):
	# Function that writes a dictionary to the desired savefile
	# @param path: Path to the file being written to
	# @param dict: Dictionary conatining the save data
	var json_string = JSON.stringify(dict)
	var file = FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		file.close()
	else:
		print("Failed to open file at path: " + path)

func _on_master_slider_value_changed(value: float) -> void:
	AudioManager.play_sound('Select')
	data['master'] = value
	AudioServer.set_bus_volume_linear(0, value)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioManager.play_sound('Select')
	data['sfx'] = value
	AudioServer.set_bus_volume_linear(1, value)
	AudioServer.set_bus_volume_linear(3, value)
	AudioServer.set_bus_volume_linear(4, value)


func _on_music_slider_value_changed(value: float) -> void:
	AudioManager.play_sound('Select')
	data['music'] = value
	AudioServer.set_bus_volume_linear(2, value)


func _on_master_slider_mouse_entered() -> void:
	AudioManager.play_sound('Hover')


func _on_sfx_slider_mouse_entered() -> void:
	AudioManager.play_sound('Hover')


func _on_music_slider_mouse_entered() -> void:
	AudioManager.play_sound('Hover')


func _on_back_pressed() -> void:
	save(data)

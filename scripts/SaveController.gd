"""
Global variables that handles the saving and loading of data.
The chosen savefile is loaded as the path variable, and all saving operations are
done through that path.
"""

extends Node

# Path to the chosen save file
var path = "res://saveFiles/save1.json"
# Dictionary of default data. Used to initialise savefiles
var default_data = {"pActions": 2, "pHP": 4, "seed": 5, "weapon": 0, "level": 1, "floor": 1}

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
		
func loadData():
	# Loads and returns data from a save file
	# @param path: path to the file to load data from
	# return: A dictionary if load was succesful, otherwise nothing
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var dataStr = file.get_as_text()
		var data = JSON.parse_string(dataStr)
		return data
		file.close()
	else:
		print("Failed ro retrieve file at path: " + path)

func setDefault():
	# Makes the savefile contain the default data
	save(default_data)

func updateData(id: String, value: int):
	# Meant to be called by outside classes. Allows them to manipulate data in the savefile
	var data = loadData()
	data[id] = value
	save(data)

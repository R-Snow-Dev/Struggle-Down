"""
Global variables that handles the saving and loading of data.
The chosen savefile is loaded as the path variable, and all saving operations are
done through that path.
"""

extends Node

const effects = {"none": preload("res://scripts/Items/effects/none.gd"),
				"heal": preload("res://scripts/Items/effects/heal.gd"),}

const itemList = [preload("res://scenes/Items/ConsumableSprites/hp_am.tscn"), preload("res://scenes/Items/ConsumableSprites/hp_ap.tscn"), preload("res://scenes/Items/ConsumableSprites/hp_pro.tscn"),
preload("res://scenes/Items/ConsumableSprites/hp_ar.tscn"), preload("res://scenes/Items/ConsumableSprites/pow_am.tscn"), preload("res://scenes/Items/ConsumableSprites/pow_ap.tscn"), preload("res://scenes/Items/ConsumableSprites/pow_pro.tscn"),
preload("res://scenes/Items/ConsumableSprites/pow_ar.tscn"), preload("res://scenes/Items/ConsumableSprites/swift_am.tscn"), preload("res://scenes/Items/ConsumableSprites/swift_ap.tscn"), preload("res://scenes/Items/ConsumableSprites/swift_pro.tscn"),
preload("res://scenes/Items/ConsumableSprites/swift_ar.tscn")]

# Path to the chosen save file
var path = "res://saveFiles/save1.json"
# Dictionary of default data. Used to initialise savefiles
var default_data = {"pActions": 2, "pHP": 4, "curHP": 4, "seed": 5, "weapon": 0, "level": 1, "floor": 1, "gold": 0, "inrun": true, 
"inventory": [], "inInv": 0, }

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
		file.close()
		return data
	else:
		print("Failed ro retrieve file at path: " + path)

func convert_file(file):
	var itemData = []
	var text = file.get_as_text()
	text = text.split("\n")
	for x in text:
		var splitX = []
		x = x.split(',')
		for y in x:
			if y.is_valid_int():
				y = int(y)
			splitX.append(y)
		itemData.append(splitX)
	itemData.remove_at(itemData.size()-1)
	return itemData

func setDefault():
	# Makes the savefile contain the default data
	var text = FileAccess.open("res://scripts/text docs/itemData.txt", FileAccess.READ)
	var textData = convert_file(text)
	default_data["items"] = textData
	save(default_data)

func updateData(id: String, value):
	# Meant to be called by outside classes. Allows them to manipulate data in the savefile
	var data = loadData()
	data[id] = value
	save(data)

func updateItems(id: int, value: Vector2):
	# Updates a desired item's amount stored and amount in the inventory
	# @param id: The index value of the item (Where it's data is located in the "items" array)
	# @param value: A Vector2 whose x value rerpresents the amount of the item that is in the inventory, and whose y value
	# 				represents the amount of the item stored in the pouch
	var data = loadData()
	data["items"][id] = [value.x, value.y,data["items"][id][2],data["items"][id][3]]
	save(data)

func updateInv(id: int, num: int):
	# Adds an item's id to the "inventory" array, if that item isn't already in it.
	# @param id: The id that is attempting to be stored in the inventory 
	# @param num: by how much the total amount of items in the inventory will change
	var data = loadData()
	if find_id(id, data["inventory"]) == -1:
		print(id)
		print(data["inventory"])
		print(find_id(id, data["inventory"]))
		data["inventory"].append(id)
	else:
		if data["items"][id][0] < 1:
			print("delete")
			data["inventory"].remove_at(find_id(id, data["inventory"]))
			print(data["inventory"])
	data["inInv"] += num
	if data["inInv"] < 1:
		data["inInv"] = 0
	save(data)


func find_id(num: int, data: Array):
	# Loops through an array to see if an id matches with an id already found in the array
	for i in range(0, data.size()):
		if data[i] == num:
			return i
	return -1

func getData(id: String):
	# Fetches and returns the current value of the desired ID stored in the savefile
	var data = loadData()
	return data[id]

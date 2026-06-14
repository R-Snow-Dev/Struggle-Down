"""
Global variables that handles the saving and loading of data.
The chosen savefile is loaded as the path variable, and all saving operations are
done through that path.
"""

extends Node

const effects = {"none": preload("res://scripts/Items/effects/none.gd"),
				"heal": preload("res://scripts/Items/effects/Pots/heal.gd"),
				"rage": preload("res://scripts/Items/effects/Pots/rage.gd"),
				"rush": preload("res://scripts/Items/effects/Pots/rush.gd"),
				"javelin": preload("res://scripts/Items/effects/Throwables/javelin.gd"),
				"chakram": preload("res://scripts/Items/effects/Throwables/chakram.gd"),
				"sAmmo": preload("res://scripts/Items/effects/Throwables/sAmmo.gd"),
				"kunai": preload("res://scripts/Items/effects/Throwables/kunai.gd"),
				"tStars": preload("res://scripts/Items/effects/Throwables/tStars.gd"),
				"iBalls": preload("res://scripts/Items/effects/Throwables/iBalls.gd"),
				"ice": preload("res://scripts/Items/effects/Scrolls/ice.gd"),
				"fire": preload("res://scripts/Items/effects/Scrolls/fire.gd"),
				"bomb": preload("res://scripts/Items/effects/Bombs/bomb.gd"),
				"magBomb": preload("res://scripts/Items/effects/Bombs/magBomb.gd"),
				"skull": preload("res://scripts/Items/effects/Bombs/skullBomb.gd"),
				"kaltrops": preload("res://scripts/Items/effects/Traps/kaltrops.gd"),
				"gFire": preload("res://scripts/Items/effects/Traps/gFire.gd"),
				"tar": preload("res://scripts/Items/effects/Traps/tar.gd"),
				"void": preload("res://scripts/Items/effects/Traps/void.gd"),
				"pBranch": preload("res://scripts/Items/effects/Rituals/pBranch.gd"),
				"gIdol": preload("res://scripts/Items/effects/Rituals/gIdol.gd"),
				"dEye": preload("res://scripts/Items/effects/Rituals/dEye.gd"),
				"aSpool": preload("res://scripts/Items/effects/Rituals/aSpool.gd"),
				"sKey": preload("res://scripts/Items/effects/Rituals/sKey.gd"),
				"pStar": preload("res://scripts/Items/effects/Rituals/pStar.gd"),}

const itemList = [preload("res://scenes/Items/ConsumableSprites/none.tscn"), preload("res://scenes/Items/ConsumableSprites/Pots/hp_am.tscn"), preload("res://scenes/Items/ConsumableSprites/Pots/hp_ap.tscn"), preload("res://scenes/Items/ConsumableSprites/Pots/hp_pro.tscn"),
preload("res://scenes/Items/ConsumableSprites/Pots/hp_ar.tscn"), preload("res://scenes/Items/ConsumableSprites/Pots/pow_am.tscn"), preload("res://scenes/Items/ConsumableSprites/Pots/pow_ap.tscn"), preload("res://scenes/Items/ConsumableSprites/Pots/pow_pro.tscn"),
preload("res://scenes/Items/ConsumableSprites/Pots/pow_ar.tscn"), preload("res://scenes/Items/ConsumableSprites/Pots/swift_am.tscn"), preload("res://scenes/Items/ConsumableSprites/Pots/swift_ap.tscn"), preload("res://scenes/Items/ConsumableSprites/Pots/swift_pro.tscn"),
preload("res://scenes/Items/ConsumableSprites/Pots/swift_ar.tscn"), preload("res://scenes/Items/ConsumableSprites/Throwables/javelin.tscn"),preload("res://scenes/Items/ConsumableSprites/Throwables/kunai.tscn"),preload("res://scenes/Items/ConsumableSprites/Throwables/chakram.tscn"),
preload("res://scenes/Items/ConsumableSprites/Throwables/tStars.tscn"), preload("res://scenes/Items/ConsumableSprites/Throwables/sAmmo.tscn"),preload("res://scenes/Items/ConsumableSprites/Throwables/iBalls.tscn"), preload("res://scenes/Items/ConsumableSprites/Scrolls/Ice/ice_am.tscn"),
preload("res://scenes/Items/ConsumableSprites/Scrolls/Ice/ice_app.tscn"),preload("res://scenes/Items/ConsumableSprites/Scrolls/Ice/ice_pro.tscn"),preload("res://scenes/Items/ConsumableSprites/Scrolls/Ice/ice_art.tscn"),preload("res://scenes/Items/ConsumableSprites/Scrolls/Ice/ice_ex.tscn"),
preload("res://scenes/Items/ConsumableSprites/Scrolls/Fire/fire_am.tscn"),preload("res://scenes/Items/ConsumableSprites/Scrolls/Fire/fire_app.tscn"),preload("res://scenes/Items/ConsumableSprites/Scrolls/Fire/fire_pro.tscn"),
preload("res://scenes/Items/ConsumableSprites/Scrolls/Fire/fire_art.tscn"), preload("res://scenes/Items/ConsumableSprites/Scrolls/Fire/fire_ex.tscn"), preload("res://scenes/Items/ConsumableSprites/Scrolls/Earth/earth_am.tscn"),
preload("res://scenes/Items/ConsumableSprites/Scrolls/Earth/earth_app.tscn"),preload("res://scenes/Items/ConsumableSprites/Scrolls/Earth/earth_pro.tscn"),preload("res://scenes/Items/ConsumableSprites/Scrolls/Earth/earth_art.tscn"), 
preload("res://scenes/Items/ConsumableSprites/Scrolls/Earth/earth_ex.tscn"), preload("res://scenes/Items/ConsumableSprites/Scrolls/Wind/wind_am.tscn"),preload("res://scenes/Items/ConsumableSprites/Scrolls/Wind/wind_app.tscn"), 
preload("res://scenes/Items/ConsumableSprites/Scrolls/Wind/wind_pro.tscn"),preload("res://scenes/Items/ConsumableSprites/Scrolls/Wind/wind_art.tscn"), preload("res://scenes/Items/ConsumableSprites/Scrolls/Wind/wind_ex.tscn"), 
preload("res://scenes/Items/ConsumableSprites/Scrolls/Lightning/l_am.tscn"),preload("res://scenes/Items/ConsumableSprites/Scrolls/Lightning/l_app.tscn"), preload("res://scenes/Items/ConsumableSprites/Scrolls/Lightning/l_pro.tscn"),
preload("res://scenes/Items/ConsumableSprites/Scrolls/Lightning/l_art.tscn"), preload("res://scenes/Items/ConsumableSprites/Scrolls/Lightning/l_ex.tscn"), preload("res://scenes/Items/ConsumableSprites/Scrolls/Holy/holy_am.tscn"),
preload("res://scenes/Items/ConsumableSprites/Scrolls/Holy/holy_app.tscn"), preload("res://scenes/Items/ConsumableSprites/Scrolls/Holy/holy_pro.tscn"), preload("res://scenes/Items/ConsumableSprites/Scrolls/Holy/holy_art.tscn"), 
preload("res://scenes/Items/ConsumableSprites/Scrolls/Holy/holy_ex.tscn"), preload("res://scenes/Items/ConsumableSprites/Bombs/bomb.tscn"), preload("res://scenes/Items/ConsumableSprites/Bombs/magBomb.tscn"), preload("res://scenes/Items/ConsumableSprites/Bombs/skullBomb.tscn"),
preload("res://scenes/Items/ConsumableSprites/Traps/kaltrops.tscn"), preload("res://scenes/Items/ConsumableSprites/Traps/gFire.tscn"), preload("res://scenes/Items/ConsumableSprites/Traps/tar.tscn"), preload("res://scenes/Items/ConsumableSprites/Traps/void.tscn"),
preload("res://scenes/Items/ConsumableSprites/Ritual/pBranch.tscn"), preload("res://scenes/Items/ConsumableSprites/Ritual/gIdol.tscn"), preload("res://scenes/Items/ConsumableSprites/Ritual/dEye.tscn"), preload("res://scenes/Items/ConsumableSprites/Ritual/tBead.tscn"),
preload("res://scenes/Items/ConsumableSprites/Ritual/aSpool.tscn"), preload("res://scenes/Items/ConsumableSprites/Ritual/sKey.tscn"), preload("res://scenes/Items/ConsumableSprites/Ritual/pStar.tscn")]

# Path to the chosen save file
var path = "res://saveFiles/save1.json"
# Dictionary of default data. Used to initialise savefiles
var default_data = {"pActions": 2, "pHP": 4, "curHP": 4, "seed": 22, "weapon": 0, "level": 1, "floor": 5, "gold": 0, "inrun": true, 
"inventory": [], "inInv": 0, "upgrades": [], "stored": 0, "components": {'0': {4:1,7:1}, '1': {4:1,6:1}, '2': {16:1,17:1}},
'atk': 1, 'movement': 1, 'hearts': 2, 'soulFlame': 0, 'unlocked': {},}

var tempComponents = []

func pickupComponent(component: Components) -> void:
	tempComponents.append(component)

func saveComponents() -> void:
	for c in tempComponents:
		addComponent(c)
	tempComponents = []

func addComponent(component: Components) -> void:
	var data = loadData()
	var c: Dictionary = data['components'][str(component.getType())]
	var id = component.getId()
	if c.has(id):
		c[id] += 1
	else:
		c[id] = 1
	save(data)

func delComponent(component: Components) -> void:
	var data = loadData()
	var c: Dictionary = data['components'][str(component.getType())]
	var id = component.getId()
	if c.has(str(id)):
		print("You have component of type", component.getType(),"and an id of",id,"being deleted.")
		if c[str(id)] < 2:
			print('Component erased')
			c[str(id)] = 0
			c.erase(str(id))
		else:
			print('Component decremented')
			c[str(id)] -= 1
	save(data)

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

func addUp(id: int):
	# Adds the id of an upgrade to the savefile
	var data = loadData()
	data["upgrades"].append(id)
	save(data)
	
func resetUps():
	# Removes all saved upgrades
	var data = loadData()
	data["upgrades"] = []
	save(data)
	
func getData(id: String):
	# Fetches and returns the current value of the desired ID stored in the savefile
	var data = loadData()
	return data[id]

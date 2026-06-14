extends Node
class_name ComponentGenerator

var rng = RandomNumberGenerator.new()

var componentValues = {
					0: {
						1: [0,4,8,9,10,11,12,13,16],
						2: [1,5,14,15,18],
						3: [2,6,17,19],
						4: [3,7,20]
					},
					1: {
						1: [0,4,9,12,15,19],
						2: [1,5,7,8,10,16,20],
						3: [3,11,13,14,17,21],
						4: [2,6,18,22,23]
					},
					2: {
						1: [15,16,22,23,24],
						2: [19,0,3,6,9,12,21],
						3: [18,25,27,1,4,7,10,13],
						4: [17,28,26,2,5,8,11,14,20]
					}
}

var cTypes = {0: preload("res://scenes/Items/Components/mediums.tscn"), 1: preload("res://scenes/Items/Components/materials.tscn"), 2: preload("res://scenes/Items/Components/catalysts.tscn")}

func _init() -> void:
	pass

func genComp(v: int) -> Components:
	var type = rng.randi_range(0,2)
	var id = componentValues[type][v][rng.randi_range(0,componentValues[type][v].size()-1)]
	
	var c: Components = cTypes[type].instantiate()
	
	c.setId(id)
	c.setType(type)
	c.setValue(v)
	
	return c
	
func genDetermined(id: int, type: int) -> Components:
	var c: Components = cTypes[type].instantiate()
	
	c.setId(id)
	c.setType(type)
	
	for x in componentValues[type]:
		if id in componentValues[type][x]:
			c.setValue(x)
			break
	
	return c
	

extends Node
class_name Crafter

var list = {1: [Vector2(4,7),Vector2(3,6),Vector2(15,18),4],
			6: [Vector2(4,7),Vector2(19,22),Vector2(15,18),4],
			10: [Vector2(4,7),Vector2(15,18),Vector2(15,18),4],
			14:[Vector2(12,12),Vector2(9,9),Vector2(22,22),1],
			15:[Vector2(11,11),Vector2(7,7),Vector2(21,21),1],
			16:[Vector2(8,8),Vector2(7,7),Vector2(21,21),1],
			17:[Vector2(10,10),Vector2(7,7),Vector2(21,21),1],
			18:[Vector2(13,13),Vector2(12,12),Vector2(22,22),1],
			19:[Vector2(9,9),Vector2(7,7),Vector2(21,21),1],
			20:[Vector2(0,3),Vector2(0,3),Vector2(19,21),5],
			25:[Vector2(0,3),Vector2(0,3),Vector2(0,2),5],
			30:[Vector2(0,3),Vector2(0,3),Vector2(3,5),5],
			35:[Vector2(0,3),Vector2(0,3),Vector2(6,8),5],
			40:[Vector2(0,3),Vector2(0,3),Vector2(9,11),5],
			45:[Vector2(0,3),Vector2(0,3),Vector2(12,14),5 ],
			50:[Vector2(4,4),Vector2(8,8),Vector2(24,24),1],
			51:[Vector2(14,14),Vector2(10,10),Vector2(24,24),1],
			52:[Vector2(15,15),Vector2(11,11),Vector2(13,13),1],
			53:[Vector2(16,16),Vector2(7,7),Vector2(21,21),1],
			54:[Vector2(5,7),Vector2(3,3),Vector2(3,3),1],
			55:[Vector2(4,4),Vector2(12,12),Vector2(23,23),1],
			56:[Vector2(20,20),Vector2(2,2),Vector2(25,25),1],
			57:[Vector2(17,17),Vector2(6,6),Vector2(7,7),1],
			58:[Vector2(18,18),Vector2(13,13),Vector2(21,21),1],
			59:[Vector2(19,19),Vector2(11,11),Vector2(27,27),1],
			60:[Vector2(9,9),Vector2(11,11),Vector2(10,10),1],
			61:[Vector2(12,12),Vector2(14,14),Vector2(1,1),1],
			62:[Vector2(15,15),Vector2(7,7),Vector2(21,21),1],
			63:[Vector2(20,20),Vector2(22,22),Vector2(28,28),1]}
			
			
var medium: Components
var material: Components
var catalyst: Components
var rng = RandomNumberGenerator.new()

func setMedium(m: Components) -> void:
	medium = m

func setMaterial(m: Components) -> void:
	material = m

func setCatalyst(c: Components) -> void:
	catalyst = c

func getMedium() -> Components:
	return medium

func getMaterial() -> Components:
	return material

func getCatalyst() -> Components:
	return catalyst

func inRange(t: int, r: Vector2) -> bool:
	return (t >= r.x) and (t <= r.y)

func checkMatch(recipe: Array) -> bool:
	if !(inRange(getMedium().getId(), recipe[0])):
		return false
	elif !(inRange(getMaterial().getId(), recipe[1])):
		return false
	elif !(inRange(getCatalyst().getId(), recipe[2])):
		return false
	else:
		return true

func calcMag(m: int) -> int:
	var base = 1
	var valueTotal: int = getMedium().getValue() + getMaterial().getValue() + getCatalyst().getValue()
	
	if valueTotal > 9:
		var factor = 0.33 * (valueTotal - 9)
		base = 3
		if rng.randf() <= factor:
			base += 1
	elif valueTotal > 6:
		var factor = 0.33 * (valueTotal - 6)
		base = 2
		if rng.randf() <= factor:
			base += 1
	elif valueTotal > 3:
		var factor = 0.33 * (valueTotal - 3)
		base = 1
		if rng.randf() <= factor:
			base += 1
	else:
		base = 1
		
	if base > m: 
		base = m
	
	return base - 1

func craft() -> int:
	
	var sID: int = 0
	for x in list.keys():
		if checkMatch(list[x]):
			sID = x
			break
			
	if sID != -1:
		if list[sID][3] > 1:
			sID += calcMag(list[sID][3])
			
	return sID

extends Area2D
class_name WeaponEffect

var dam: int
var type: String
var effect: String
var chance: float

func setDam(data: int) -> void:
	dam = data

func setType(data: String) -> void:
	type = data

func setEffect(e: String) -> void:
	effect = e
	
func setChance(c: float) -> void:
	chance = c

func getDam() -> int:
	return dam

func getType() -> String:
	return type
	
func getEffect() -> String:
	return effect
	
func getChance() -> float:
	return chance

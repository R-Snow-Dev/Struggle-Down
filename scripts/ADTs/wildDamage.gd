extends Area2D
class_name WildDamage

signal end()

var dam: int
var type: String
var effect: String
var chance: float

func setEffect(e: String) -> void:
	effect = e
	
func setChance(c: float) -> void:
	chance = c

func setDam(data: int) -> void:
	dam = data
	
func setType(data: String) -> void:
	type = data

func getEffect() -> String:
	return effect

func getChance() -> float:
	return chance

func getDam() -> int:
	return dam

func getType() -> String:
	return type

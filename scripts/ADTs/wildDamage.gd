extends Area2D
class_name WildDamage

var dam: int
var type: String

func setDam(data: int) -> void:
	dam = data
	
func setType(data: String) -> void:
	type = data
	
func getDam() -> int:
	return dam

func getType() -> String:
	return type

extends RefCounted
class_name Key

var id: int = 0

func _init(i: int) -> void:
	id = i

func setID(i: int) -> void:
	id = i
	
func getID() -> int:
	return id

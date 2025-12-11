extends RefCounted
class_name Effect

var activeTime: int
var name: String
var damageType: String

func _init():
	pass

func activate(target: Fiend):
	pass
	
func getEffectTime() -> int:
	return activeTime

func getName() -> String:
	return name

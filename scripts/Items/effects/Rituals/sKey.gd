extends ItemEffect
class_name SKeyEffect

var mag: int

func _init(m: int) -> void:
	mag = m 
	
func run():
	Overseer.getBoard().forceUnlock()

func test():
	return !Overseer.getBoard().solved

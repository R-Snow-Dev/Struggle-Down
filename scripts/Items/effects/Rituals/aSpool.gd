extends ItemEffect
class_name ASpoolEffect

var mag: int

func _init(m: int) -> void:
	mag = m 
	
func run():
	Overseer.getController().goHome()

func test():
	return true

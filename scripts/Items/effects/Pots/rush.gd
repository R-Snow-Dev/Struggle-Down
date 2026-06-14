extends ItemEffect
class_name RushEffect

var mag: int

func _init(m: int) -> void:
	mag = m 
	
func run():
	EventBus.updateActions.emit(mag, 'move')

func test():
	return true

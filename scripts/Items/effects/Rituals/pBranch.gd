extends ItemEffect
class_name PBranchEffect

var mag: int

func _init(m: int) -> void:
	mag = m 
	
func run():
	Overseer.getController().setRes(true)

func test():
	return !Overseer.getController().getRes()

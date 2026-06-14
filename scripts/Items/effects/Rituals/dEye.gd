extends ItemEffect
class_name DEyeEffect

var mag: int

func _init(m: int) -> void:
	mag = m 
	
func run():
	Overseer.getController().revealLadder()

func test():
	return !Overseer.getController().checkRevealed()

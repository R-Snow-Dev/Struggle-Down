extends ItemEffect
class_name GIdolEffect

var mag: int

func _init(m: int) -> void:
	mag = m 
	
func run():
	UpgradeList.maxDrops = true

func test():
	return !UpgradeList.maxDrops

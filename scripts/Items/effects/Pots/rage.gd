extends ItemEffect
class_name RageEffect

var mag: int

func _init(m: int) -> void:
	mag = m 
	
func run():
	WeaponList.enraged = mag

func test():
	return WeaponList.enraged < 1

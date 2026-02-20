extends FiendData
class_name BossData

var size: int
var bump: bool = false

func _init(p: Vector2, h: int, a: int, gR: Vector2, d: int, f: Vector2, b: RefCounted, s: int) -> void:
	super(p,h,a,gR,d,f,b)
	size = s

func getBump() -> bool:
	return bump

func setBump(b:bool) -> void:
	bump =  b

func getSize() -> int:
	return size

func setSize(i:int) -> void:
	size = i

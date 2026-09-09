extends Control
class_name StatusMarker

const OFFSET = 3

var status: int = 0

@onready var sprite: Sprite2D = $Sprite2D

func setup(s: int) -> void:
	setStatus(s)
	
func setStatus(s:int) -> void:
	status = s
	sprite.region_rect = Rect2(0,32 * (OFFSET + status), 32, 32)

	

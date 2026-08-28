extends Sprite2D
class_name Relic

var id: int = 0
var attribute: Attribute


func setId(i: int) -> void:
	id = i
	region_rect = Rect2(0,id * 32,32,32)
	attribute = UpgradeList.relics[id]
	
func getId() -> int:
	return id

func getAttribute() -> Attribute:
	return attribute

func _ready() -> void:
	region_enabled = true
	region_rect = Rect2(0,id * 32,32,32)

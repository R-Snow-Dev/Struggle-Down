extends Node2D
class_name Components

var id: int
var value: int
var type: int
@onready var atlas = $mAtlas

func _ready() -> void:
	atlas.region_enabled = true
	atlas.region_rect = Rect2(0,id * 16,16,16)

func setId(i: int) -> void:
	id = i
	
func setValue(v: int) -> void:
	value = v
	
func setType(t: int) -> void:
	type = t
	
	
func getId() -> int:
	return id
	
func getValue() -> int:
	return value
	
func getType() -> int:
	return type
	

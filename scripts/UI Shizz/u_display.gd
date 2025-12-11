extends ColorRect
class_name uDisplay

@onready var details = $deets
@onready var dName = $deets/Name
@onready var dDesc = $deets/desc
@onready var abbrv = $Label
var a: Attribute

func setA(att: Attribute):
	a = att

func _ready() -> void:
	abbrv.text = (a.name[0]+a.name[1]).to_upper()
	dName.text = a.name
	dDesc.text = a.description.strip_escapes()
	
func _on_area_2d_mouse_entered() -> void:
	details.visible = true

func _on_area_2d_mouse_exited() -> void:
	details.visible = false

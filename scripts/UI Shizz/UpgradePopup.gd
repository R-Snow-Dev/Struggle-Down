extends TileMapLayer
class_name UPopup

@onready var n = $Name
@onready var desc = $Description
var att: Attribute
func _ready() -> void:
	visible = false
	EventBus.sac.connect(sac)
	pass

func sac(a: Attribute):
	n.text = a.name
	desc.text = a.description.strip_escapes()
	att = a
	visible = true

func _on_decline_pressed() -> void:
	EventBus.unpause.emit()
	visible = false


func _on_select_pressed() -> void:
	UpgradeList.addAttribute(att)
	EventBus.unpause.emit()
	visible = false

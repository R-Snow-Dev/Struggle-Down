extends Attribute
class_name IDepiction

var uses: int = 3

func _init() -> void:
	type = "active"
	name = "Depiction of the Immaterial"
	uses = 3
	description = "Sulpture that captures the form of a formless being. A masterwork.\n
	May be activated to gain the ability to pass through impassable objects. May be used three times per floor."

func effect(target : Node):
	if uses > 0:
		UpgradeList.setRData('immaterial', true)
		uses -= 1
	effectDone.emit()

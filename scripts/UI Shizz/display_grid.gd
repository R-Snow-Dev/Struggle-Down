extends Control
class_name DisplayGrid

var t: int = 0
var slots: Array = []
var cGen = ComponentGenerator.new()

func setType(i: int) -> void:
	t = i

func _ready() -> void:
	for c in $VBoxContainer/HBoxContainer.get_children():
		slots.append(c)
	for c in $VBoxContainer/HBoxContainer2.get_children():
		slots.append(c)
	for c in $VBoxContainer/HBoxContainer3.get_children():
		slots.append(c)
	for c in $VBoxContainer/HBoxContainer4.get_children():
		slots.append(c)
	for c in $VBoxContainer/HBoxContainer5.get_children():
		slots.append(c)
	for c in $VBoxContainer/HBoxContainer6.get_children():
		slots.append(c)
		
func open() -> void:
	loadComps(SaveController.getData('components'))

func loadComps(pouch: Dictionary) -> void:
	var slotNum = 0
	var comps = pouch[str(t)]
	for s: ComponentDisplay in slots:
		s.setAmount(0)
		s.setComp(false)
	for x in comps:
		var sl: ComponentDisplay = slots[slotNum]
		sl.setComp(cGen.genDetermined(int(x), t))
		sl.setAmount(comps[x])
		slotNum += 1
	

extends Control
class_name ComponentSelect

signal selected(c:Components)
signal remove(t:int)

@onready var title = $VBoxContainer/Label

var t: int = 0
var slots: Array = []
var cGen = ComponentGenerator.new()


func setTitle(s: String) -> void:
	title.text = s

func setType(i: int) -> void:
	t = i

func _ready() -> void:
	EventBus.compChosen.connect(compChosen)
	EventBus.removeComp.connect(compRemoved)
	for c in $VBoxContainer/HBoxContainer.get_children():
		if c.get_child_count() < 3:
			slots.append(c)
	for c in $VBoxContainer/HBoxContainer2.get_children():
		slots.append(c)
	for c in $VBoxContainer/HBoxContainer3.get_children():
		slots.append(c)
	
func open() -> void:
	loadComps(SaveController.getData('components'))
	visible = true

func loadComps(pouch: Dictionary) -> void:
	var slotNum = 0
	var comps = pouch[str(t)]
	for s: ComponentSlot in slots:
		s.setAmount(0)
		s.setComp(false)
	for x in comps:
		var sl: ComponentSlot = slots[slotNum]
		sl.setComp(cGen.genDetermined(int(x), t))
		sl.setAmount(comps[x])
		slotNum += 1
	

func compChosen(c: Components) -> void:
	selected.emit(c)
	visible = false
	
func compRemoved() -> void:
	remove.emit(t)
	visible = false

extends Node2D
class_name CraftingMenu

@onready var cS = $CanvasLayer/ComponentSelect
@onready var vAnim = $visuals/AnimationPlayer
@onready var cButton = $visuals/TextButton
@onready var vC = $visuals/sContainer
@onready var cB = $CanvasLayer/clickBlocker

@onready var buttons = [$ButtonLayout/mediums, $ButtonLayout/materials, $ButtonLayout/catalysts]

var has: Array =  [false, false, false]
var toBeDeleted: Dictionary = {0: [], 1: [], 2: []}
var crafter = Crafter.new()

func craft() -> void:
	cB.visible = true
	var item: int = crafter.craft()
	if item > 0:
		incrementItem(item, 1)
	var s: Sprite2D = SaveController.itemList[item].instantiate()
	vC.add_child(s)
	for x in toBeDeleted.keys():
		for c in toBeDeleted[x]:
			SaveController.delComponent(c)
		toBeDeleted[x] = []
	
	
func incrementItem(id: int, n: int) -> void:
	var curAmount = SaveController.getData("items")[id][1]
	var curInv = SaveController.getData("items")[id][0]
	SaveController.updateItems(id, Vector2(curInv,curAmount + n))

func reset() -> void:
	cB.visible = false
	cButton.visible = false
	has = [false, false, false]
	toBeDeleted = {0: [], 1: [], 2: []}
	for c in vC.get_children():
		vC.remove_child(c)
	for b:ComponentButton in buttons:
		b.removeComp()
	


func _ready() -> void:
	cButton.setText('CRAFT')

func updateCrafter() -> void:
	if toBeDeleted[0].size() > 0:
		crafter.setMedium(toBeDeleted[0][0])
	else:
		crafter.setMedium(null)
	if toBeDeleted[1].size() > 0:
		crafter.setMaterial(toBeDeleted[1][0])
	else:
		crafter.setMaterial(null)
	if toBeDeleted[2].size() > 0:
		crafter.setCatalyst(toBeDeleted[2][0])
	else:
		crafter.setCatalyst(null)

func checkCraft() -> bool:
	for x in has:
		if !x:
			cButton.visible = false
			return false
	cButton.visible = true
	return true

func _on_mediums_pressed(c: ComponentButton) -> void:
	cS.setTitle("Select A Medium")
	cS.setType(0)
	cS.open()
	


func _on_materials_pressed(c: ComponentButton) -> void:
	cS.setTitle("Select A Material")
	cS.setType(1)
	cS.open()


func _on_catalysts_pressed(c: ComponentButton) -> void:
	cS.setTitle("Select A Catalyst")
	cS.setType(2)
	cS.open()

func _on_component_select_selected(comp: Components) -> void:
	var target: ComponentButton = buttons[comp.getType()]
	target.setComp(comp)
	has[comp.getType()] = true
	toBeDeleted[comp.getType()].append(comp)
	updateCrafter()
	checkCraft()

func _on_component_select_remove(t: int) -> void:
	var target: ComponentButton = buttons[t]
	target.removeComp()
	has[t] = false
	toBeDeleted[t] = []
	updateCrafter()
	checkCraft()
	
func _on_text_button_pressed() -> void:
	if checkCraft():
		cButton.visible = false
		vAnim.play('craft')

extends Node2D
class_name RelicPouch

@onready var slots = [$Display/Buttons/HBoxContainer/MenuButton, $Display/Buttons/HBoxContainer/MenuButton2, $Display/Buttons/HBoxContainer/MenuButton3]
@onready var flameAmount = $Display/FlameAmount
@onready var anim = $Display/AnimationPlayer
@onready var soulPouch = $"../SoulMenu"
@onready  var grid = $Display/Buttons/RelicGrid

var soulFlame: int = 0

func open() -> void:
	updateSprites()
	if !visible:
		anim.play("open")
	else:
		anim.play("close")

func close() -> void:
	updateSprites()
	if visible:
		anim.play("close")

func toggleVisible() -> void:
	visible = !visible

func _ready() -> void:
	EventBus.updateInv.connect(updateSprites)
	EventBus.selectedRelic.connect(setRelic)
	await get_tree().process_frame
	updateSprites()

func updateSprites():
	soulFlame = SaveController.getData('soulFlame')
	flameAmount.text = str(soulFlame)
	print("SoulFlame:", str(soulFlame))
	var rels = SaveController.getData('relics')
	var unlocked = SaveController.getData('unlockedSlots')
	grid.updateSprites()
	
	for x in range(0,3):
		slots[x].removeSprite()
			
		if unlocked[x]:
			var s: BasicButton = slots[x]
			for c in s.get_children():
				if c is GrayedOut:
					c.visible = false
				
		if rels[x] is not bool and unlocked[x]:
			var rel: Relic = preload("res://scenes/GUIParts/relic.tscn").instantiate()
			rel.setId(rels[x])
			rel.scale = rel.scale * 0.8
			slots[x].setSprite(rel)

func isIn(target, array: Array) -> bool:
	for x in array:
		if x is int or x is float:
			if x == target:
				return true
	return false

func setRelic(id: int):
	print(str(id))
	var rels = SaveController.getData('relics')
	var unlocked = SaveController.getData('unlockedSlots')
	print(isIn(id, rels))
	for x in range(0,3):
		if rels[x] is bool and unlocked[x] and (not isIn(id, rels)):
			rels[x] = id
			SaveController.updateData('relics', rels)
			updateSprites()
			break

func _on_menu_button_pressed() -> void:
	var rels = SaveController.getData('relics')
	var unlocked = SaveController.getData('unlockedSlots')
	
	if rels[0] is not bool:
		rels[0] = false
		SaveController.updateData('relics', rels)
		updateSprites()
	elif (not unlocked[0]) and SaveController.getData('soulFlame') >= 10:
		unlocked[0] = true
		SaveController.updateData('unlockedSlots', unlocked)
		SaveController.updateData('soulFlame', soulFlame - 10)
		soulPouch.left = soulFlame - 10
		soulPouch.setNums()
		updateSprites()


func _on_menu_button_2_pressed() -> void:
	var rels = SaveController.getData('relics')
	var unlocked = SaveController.getData('unlockedSlots')
	
	if rels[1] is not bool:
		rels[1] = false
		SaveController.updateData('relics', rels)
		updateSprites()
	elif (not unlocked[1]) and SaveController.getData('soulFlame') >= 20:
		unlocked[1] = true
		SaveController.updateData('unlockedSlots', unlocked)
		SaveController.updateData('soulFlame', soulFlame - 20)
		soulPouch.left = soulFlame - 20
		soulPouch.setNums()
		updateSprites()


func _on_menu_button_3_pressed() -> void:
	var rels = SaveController.getData('relics')
	var unlocked = SaveController.getData('unlockedSlots')
	
	if rels[2] is not bool:
		rels[2] = false
		SaveController.updateData('relics', rels)
		updateSprites()
	elif (not unlocked[2]) and SaveController.getData('soulFlame') >= 30:
		unlocked[2] = true
		SaveController.updateData('unlockedSlots', unlocked)
		SaveController.updateData('soulFlame', soulFlame - 30)
		soulPouch.left = soulFlame - 30
		soulPouch.setNums()
		updateSprites()
	
func _on_menu_button_hover() -> void:
	var rels = SaveController.getData('relics')
	
	if rels[0] is not bool:
		EventBus.relicHover.emit(rels[0])
	

func _on_menu_button_off_hover() -> void:
	EventBus.relicOff.emit()


func _on_menu_button_2_hover() -> void:
	var rels = SaveController.getData('relics')
	
	if rels[1] is not bool:
		EventBus.relicHover.emit(rels[1])

func _on_menu_button_2_off_hover() -> void:
	EventBus.relicOff.emit()


func _on_menu_button_3_hover() -> void:
	var rels = SaveController.getData('relics')
	
	if rels[2] is not bool:
		EventBus.relicHover.emit(rels[2])

func _on_menu_button_3_off_hover() -> void:
	EventBus.relicOff.emit()

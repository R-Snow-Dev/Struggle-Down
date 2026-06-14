extends Node2D
class_name SoulMenu

@onready var atk = $Display/Buttons/area1
@onready var move = $Display/Buttons/area2
@onready var hearts = $Display/Buttons/area3
@onready var sFlame = $Display/Buttons/area4
@onready var atkCount = $Display/Buttons/area1/display/count
@onready var moveCount = $Display/Buttons/area2/display/count
@onready var heartCount = $Display/Buttons/area3/display/count
@onready var atkAmount = $Display/Buttons/area1/cost/amount
@onready var moveAmount = $Display/Buttons/area2/cost/amount
@onready var heartAmount = $Display/Buttons/area3/cost/amount
@onready var flameAmount = $Display/Buttons/area4/count

var inAtk = 0
var inMove = 0
var inHearts = 0
var atkCost = 1
var moveCost = 4
var heartCost = 2
var left = 0
var totalUsed = 0


func _ready() -> void:
	setAmounts()

func configCosts() -> void:
	atkCost = 1 + (1 * int(inAtk/2))
	moveCost = 2 + (2 * inMove)
	heartCost = 1 + (1 * inHearts)
	atkAmount.text = 'Cost: '+str(int(atkCost))
	moveAmount.text = 'Cost: '+str(int(moveCost))
	heartAmount.text = 'Cost: '+str(int(heartCost))

func setNums() -> void:
	atkCount.text = str(int(inAtk))	
	moveCount.text = str(int(inMove))
	heartCount.text = str(int(inHearts))
	flameAmount.text = str(int(left))

func setAmounts() -> void:
	inAtk = SaveController.getData('atk')
	inMove = SaveController.getData('movement')
	inHearts = SaveController.getData('hearts')
	left = SaveController.getData('soulFlame')
	configCosts()
	totalUsed = (inAtk * atkCost) + (inMove * moveCost) + (inHearts * heartCost)
	setNums()
	
func save() -> void:
	SaveController.updateData('atk', inAtk)
	SaveController.updateData('movement', inMove)
	SaveController.updateData('hearts', inHearts)
	SaveController.updateData('soulFlame', left)


func _on_atk_pressed() -> void:
	if left >= atkCost:
		left -= atkCost
		inAtk += 1
		setNums()
		configCosts()


func _on_move_pressed() -> void:
	if left >= moveCost:
		left -= moveCost
		inMove += 1
		setNums()
		configCosts()


func _on_heart_pressed() -> void:
	if left >= heartCost:
		left -= heartCost
		inHearts += 1
		setNums()
		configCosts()


func _on_atk_pressed_right() -> void:
	if inAtk > 0:
		inAtk -= 1
		left += 1 + (1 * int(inAtk/2))
		setNums()
		configCosts()


func _on_move_pressed_right() -> void:
	if inMove > 0:
		inMove -= 1
		left += 2 + (2 * inMove)
		setNums()
		configCosts()


func _on_heart_pressed_right() -> void:
	if inHearts > 0:
		inHearts -= 1
		left += 1 + (1 * inHearts)
		setNums()
		configCosts()

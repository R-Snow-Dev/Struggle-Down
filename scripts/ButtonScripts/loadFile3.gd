'''
Handles the logic for the third save file button in the "Load File" menu
'''

extends Node2D

@onready var newfile = $file3/NewFile
@onready var subMenu = $subMenu
@onready var c = $file3/file3Button/CollisionShape2D
var isHovering = false

func _ready() -> void:
	subMenu.hide()

# Called when the node enters the scene tree for the first time.
func _process(_delta: float) -> void:
	if(FileAccess.file_exists("res://saveFiles/save3.json")):
		newfile.hide()
	else:
		newfile.show()
	if isHovering == true:
		if Input.is_action_just_pressed("select"):
			SaveController.path = "res://saveFiles/save3.json"
			if(!FileAccess.file_exists("res://saveFiles/save3.json")):
				SaveController.setDefault()
			EventBus.start.emit()
		if(Input.is_action_just_pressed("special_select") && FileAccess.file_exists("res://saveFiles/save3.json")):
			if subMenu.visible == false:
				subMenu.playAnim("slideIn")
			else:
				subMenu.playAnim("slideOut")

func _on_file_3_button_mouse_entered() -> void:
	isHovering = true
	c.position.y = 2
	position.y = 0

func _on_file_3_button_mouse_exited() -> void:
	isHovering = false
	c.position.y = 0
	position.y = 2

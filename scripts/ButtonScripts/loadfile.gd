'''
Handles the logic for the first save file button in the "Load File" menu
'''

extends Node2D

@onready var newfile = $file1/NewFile
@onready var subMenu = $subMenu
var isHovering = false

func _ready() -> void:
	subMenu.hide()
func _process(delta: float) -> void:
	if(FileAccess.file_exists("res://saveFiles/save1.json")):
		newfile.hide()
	else:
		newfile.show()
	if isHovering == true:
		if Input.is_action_just_pressed("select"):
			SaveController.path = "res://saveFiles/save1.json"
			if(!FileAccess.file_exists("res://saveFiles/save1.json")):
				SaveController.setDefault()
			EventBus.start.emit()
		if(Input.is_action_just_pressed("special_select") && FileAccess.file_exists("res://saveFiles/save1.json")):
			subMenu.playAnim("slideIn")

func _on_file_1_button_mouse_entered() -> void:
	isHovering = true


func _on_file_1_button_mouse_exited() -> void:
	isHovering = false

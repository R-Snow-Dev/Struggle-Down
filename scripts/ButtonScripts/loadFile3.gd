'''
Handles the logic for the third save file button in the "Load File" menu
'''

extends Node2D

@onready var newfile = $file3/NewFile
@onready var subMenu = $subMenu
var isHovering = false

func _ready() -> void:
	subMenu.hide()

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
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
			subMenu.playAnim("slideIn")

func _on_file_3_button_mouse_entered() -> void:
	isHovering = true

func _on_file_3_button_mouse_exited() -> void:
	isHovering = false




func _on_sub_menu_3_button_mouse_exited() -> void:
	pass # Replace with function body.

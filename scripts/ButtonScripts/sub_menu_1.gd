'''
Class containing the code for the "delete save file" button for savefile 1
'''

extends TileMapLayer

@onready var anim = $AnimationPlayer
var isHovering = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("select"):
		if isHovering == true:
			var path = "res://saveFiles/save1.json"
			DirAccess.remove_absolute(path)
			playAnim("slideOut")
		else:
			playAnim("slideOut")

func playAnim(name:String):
	anim.play(name)


func _on_sub_menu_1_button_mouse_entered() -> void:
	isHovering = true


func _on_sub_menu_1_button_mouse_exited() -> void:
	isHovering = false

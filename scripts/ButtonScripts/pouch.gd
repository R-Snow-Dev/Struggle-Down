extends Node2D

var isHovering = false
@onready var goCord = $goCord
@onready var goBox = $goCord/Area2D/CollisionShape2D
@onready var guy = $guy
@onready var pouch = $pouch_sprite
@onready var timing = $timing

func _ready() -> void:
	goCord.visible = false
	timing.play("open")
	
func _process(delta: float) -> void:
	if isHovering:
		goCord.position.x = -150
		goBox.scale.y = 1.3
		goBox.position.x = 7
		if Input.is_action_just_pressed("select"):
			timing.play("close")
	else:
		goCord.position.x = -128
		goBox.scale.y = 1
		goBox.position.x = -8
			


func _on_area_2d_mouse_entered() -> void:
	isHovering = true
	

func _on_area_2d_mouse_exited() -> void:
	isHovering = false
	
func close():
	guy.play("close")
	pouch.play("close")
	
func toggleCord():
	goCord.visible = !goCord.visible

func go():
	EventBus.start.emit()
	

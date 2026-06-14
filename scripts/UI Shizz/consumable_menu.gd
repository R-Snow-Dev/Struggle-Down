extends Node2D
class_name ConMenu

@onready var grid = $display/ConsumableGrid
@onready var anim = $display/AnimationPlayer

func update() -> void:
	grid.updateSprites()

func open() -> void:
	if !visible:
		anim.play("open")
	else:
		anim.play("close")

func close() -> void:
	if visible:
		anim.play("close")

func toggleVisible() -> void:
	visible = !visible

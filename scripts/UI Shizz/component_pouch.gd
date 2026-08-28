extends Node2D
class_name ComponentPouch

@onready var title = $Display/Label
@onready var grid = $Display/displayGrid
@onready var anim = $Display/AnimationPlayer

func _ready() -> void:
	grid.setType(0)
	grid.open()

func open() -> void:
	grid.open()
	if !visible:
		anim.play("open")
	else:
		anim.play("close")

func close() -> void:
	grid.open()
	if visible:
		anim.play("close")

func toggleVisible() -> void:
	visible = !visible

func _on_mediums_pressed() -> void:
	grid.setType(0)
	title.text = 'Mediums'
	grid.open()


func _on_materials_pressed() -> void:
	grid.setType(1)
	title.text = 'Materials'
	grid.open()


func _on_catalysts_pressed() -> void:
	grid.setType(2)
	title.text = 'Catalysts'
	grid.open()

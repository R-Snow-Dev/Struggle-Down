extends Camera2D

@onready var anim = $AnimationPlayer

func _ready() -> void:
	anim.play("RESET")

func _on_arrow_pressed() -> void:
	anim.play("slideR")

func _on_arrow_2_pressed() -> void:
	anim.play('slideL')

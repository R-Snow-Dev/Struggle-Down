extends Sprite2D
class_name Filter

@export var default: Color
@export var filter1: Color

func _process(delta: float) -> void:
	if Overseer.wrath:
		modulate = filter1
	else:
		modulate = default

extends Area2D
class_name EatBox



func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		EventBus.update_hp.emit(-1)

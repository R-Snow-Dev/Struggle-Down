""" 
The target effect that appears when you are hovering over the attack button
"""

extends Polygon2D
class_name AreaOfEffect

@onready var anim_player: AnimationPlayer = $AnimPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Default to playing the flashing animation when spawned in
	anim_player.play("flash")

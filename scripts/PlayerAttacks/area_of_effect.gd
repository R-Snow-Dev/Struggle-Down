""" 
The target effect that appears when you are hovering over the attack button
"""

extends Polygon2D
class_name AreaOfEffect

@onready var anim_player: AnimationPlayer = $AnimPlayer
var hurtbox = preload("res://scenes/DungeonParts/hurtbox.tscn").instantiate()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Default to playing the flashing animation when spawned in
	EventBus.playerDoneAttacking.connect(_playerDoneAttacking)
	EventBus.attack.connect(_attack)
	anim_player.play("flash")

	
func _attack(weapon: Array):
	# Function that creates hurboxes on the targeted area when the player attacks
	hurtbox.damage = weapon[5]
	add_child(hurtbox)
func _playerDoneAttacking():
	# Function that removes the hit boxes after the animation for attacking has concluded
	remove_child(hurtbox)

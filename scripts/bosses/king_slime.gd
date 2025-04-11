"""
Class that handles all the slime-king specific collisions
"""

extends AnimatedSprite2D
class_name SlimeKing

@onready var chargeAttackHitbox = $SlideAttack
@onready var jumpAttackHitbox = $JumpAttack
@onready var spreadHitbox = $Spread


func toggleJDetection():
	# Function that toggles on and off all the jump hitboxes
	for child in jumpAttackHitbox.get_children():
		child.monitoring = !child.monitoring
		child.monitorable = !child.monitorable

func toggleCDetection():
	# Function that toggles on and off the charge hitbox
	for child in chargeAttackHitbox.get_children():
		child.monitoring = !child.monitoring
		child.monitorable = !child.monitorable

func toggleSDetection():
	# function that toggles on and off the Spread hitbox
	for child in spreadHitbox.get_children():
		child.monitoring = !child.monitoring
		child.monitorable = !child.monitorable

func _on_slide_hitbox_area_entered(area: Area2D) -> void:
	# Function that handles when the charge hitbox connects with the player
	if area is Player:# If the slime made contact with the player
		EventBus.update_hp.emit(-1) # Decrease player HP by the sprites "dam" value
		
func jump():
	animation = "jump"


func _on_animation_finished() -> void:
	play("Idle")

# The Following functions all handle when specific jump
# hitboxes connect with the player, and what direction it
# should push the player
#-----------------------------------------------------------#
func _on_j_box_1_area_entered(area: Area2D) -> void:
	if area is Player:# If the slime made contact with the player
		EventBus.update_hp.emit(-1) # Decrease player HP by the sprites "dam" value
		EventBus.bump.emit(Vector2(0,-1))


func _on_j_box_2_area_entered(area: Area2D) -> void:
	if area is Player:# If the slime made contact with the player
		EventBus.update_hp.emit(-1) # Decrease player HP by the sprites "dam" value
		EventBus.bump.emit(Vector2(1,0))


func _on_j_box_3_area_entered(area: Area2D) -> void:
	if area is Player:# If the slime made contact with the player
		EventBus.update_hp.emit(-1) # Decrease player HP by the sprites "dam" value
		EventBus.bump.emit(Vector2(-1,0))


func _on_j_box_4_area_entered(area: Area2D) -> void:
	if area is Player:# If the slime made contact with the player
		EventBus.update_hp.emit(-1) # Decrease player HP by the sprites "dam" value
		EventBus.bump.emit(Vector2(0,1))
#-----------------------------------------------------------#

func _on_spread_hitbox_area_entered(area: Area2D) -> void:
	# Function that handles when the spread hitbox connects with thw player
	if area is Player:# If the slime made contact with the player
		EventBus.update_hp.emit(-1) # Decrease player HP by the sprites "dam" value

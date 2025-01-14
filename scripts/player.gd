
"""
Code that contains position info and movement functions for the 
plater character

The player character will be carried over in every game board, so there is no reason
to convert it into a class
"""
extends Area2D
class_name Player

# Initialises a Vector2 that will store the position data that is represented on the gameboard
var pos: Vector2
var actionsAvailable: int
var hp: int = 4
@onready var anim_player: AnimationPlayer = $CollisionShape2D/AnimatedSprite2D/animPlayer
@onready var attack_origin: Node2D = $AttackOrigin
@onready var animated_sprite_2d: AnimatedSprite2D = $CollisionShape2D/AnimatedSprite2D

func playDeath():
	# Plays the death animation upon death
	anim_player.play("death")
	
func broadcatDeath():
	# Emits the on_death signal after the death animation is completed
	EventBus.on_death.emit()

func _ready() -> void:
	EventBus.update_hp.connect(_updateHealth)
	EventBus.updateActions.connect(_updateActions)

func setPos(newPos: Vector2):
	# Function to artificially change the current position of the player character
	pos = newPos

func _updateActions(amount: int):
	actionsAvailable += amount

func setActionsAvailable(actions: int):
	# Function to artificially set the number of available actions for the player
	actionsAvailable = actions
	EventBus.actionsReset.emit(actions)

func moveUp():
	# Code to move the player character up
	attack_origin.rotation_degrees = 0
	pos.y -= 1
	animated_sprite_2d.flip_h = 0
	animated_sprite_2d.play("IdleU")

func moveDown():
	# Code to move the player character down
	attack_origin.rotation_degrees = 180
	pos.y += 1
	animated_sprite_2d.flip_h = 0
	animated_sprite_2d.play("IdleD")

func moveLeft():
	# Code to move the player character left
	attack_origin.rotation_degrees = 270
	pos.x -= 1
	animated_sprite_2d.flip_h = 1
	animated_sprite_2d.play("IdleS")

func moveRight():
	# Code to move the player character right
	attack_origin.rotation_degrees = 90
	pos.x += 1
	animated_sprite_2d.flip_h = 0
	animated_sprite_2d.play("IdleS")

func _updateHealth(amount: int):
	if amount + hp <= 0:
		hp = 0
	else:
		hp += amount

func draw():
	# code that converts the Vector2 position data into on-screen coordinates
	position.x = pos.x*16
	position.y = pos.y*16
	self.z_index = (pos.y + 2)
	
	

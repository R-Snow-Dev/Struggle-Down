
"""
Code that contains position info and movement functions for the 
plater character

The player character will be carried over in every game board, so there is no reason
to convert it into a class
"""
extends Area2D
class_name Player

signal drawn

# Initialises a Vector2 that will store the position data that is represented on the gameboard
var facing: Vector2i = Vector2i(0,1)
var pos: Vector2
var prevPos = [Vector2(0,0)]
var actionsAvailable: int
var effects: Array = []
var inside: bool = false
var rng = RandomNumberGenerator.new()
var wildImmune = false
@onready var popup = $Popup
@onready var anim_player: AnimationPlayer = $CollisionShape2D/AnimatedSprite2D/animPlayer
@onready var attack_origin: Node2D = $WeaponOrigin
@onready var animated_sprite_2d: AnimatedSprite2D = $CollisionShape2D/AnimatedSprite2D
@onready var data = SaveController.loadData()

func getComponent(c: Components) -> void:
	popup.setSprite(c)
	popup.pop()

func findIn(target, list: Array) -> int:
	for i in range(0, list.size()):
		if target == list[i]:
			return i
	return -1

func addEffect(e:String) -> void:
	if e not in effects:
		effects.append(e)

func clearEffects() -> void:
	effects = []
	
func getEffects() -> Array:
	return effects

func playDeath():
	# Plays the death animation upon death
	EventBus.save_data.emit()
	anim_player.play("death")
	
func broadcatDeath():
	# Emits the on_death signal after the death animation is completed
	EventBus.on_death.emit()

func _ready() -> void:
	EventBus.updateActions.connect(_updateActions)
	EventBus.bump.connect(bump)
	EventBus.throwEffect.connect(_effect)
	EventBus.throwEntity.connect(_entity)

func setPos(newPos: Vector2):
	# Function to artificially change the current position of the player character
	prevPos.push_front(pos)
	pos = newPos

func myName() -> String:
	return "player"

func getPos() -> Vector2:
	return pos

func bump():
	prevPos.push_front(pos)
	var final = (prevPos[-1] - prevPos[-2])
	print(inside, " Is inside")
	while inside and len(prevPos) > 0:
		if len(prevPos) > 0:
			print(prevPos)
			pos = prevPos.pop_front()
		draw()
		await get_tree().physics_frame
		await get_tree().process_frame
		draw()
	await get_tree().physics_frame
	await get_tree().process_frame
	if inside:
		pos += final
		draw()
		
	

func _updateActions(a: int, type: String = "move"):
	var amount = a
	if type == "attack":
		for x: Attribute in UpgradeList.getByType("onAttack"):
			amount *= x.effect(self)
	actionsAvailable += amount
	EventBus.updateShoe.emit(amount)

func setActionsAvailable(actions: int):
	# Function to artificially set the number of available actions for the player
	actionsAvailable = actions
	EventBus.actionsReset.emit(actions)
	prevPos = []

func moveUp():
	# Code to move the player character up
	chooseFSSound()
	prevPos.push_front(pos)
	facing = Vector2i(0,1)
	attack_origin.rotation_degrees = 180
	pos.y -= 1
	animated_sprite_2d.flip_h = 0
	animated_sprite_2d.play("IdleU")

func moveDown():
	# Code to move the player character down
	chooseFSSound()
	prevPos.push_front(pos)
	facing = Vector2i(0,-1)
	attack_origin.rotation_degrees = 0
	pos.y += 1
	animated_sprite_2d.flip_h = 0
	animated_sprite_2d.play("IdleD")

func moveLeft():
	# Code to move the player character left
	chooseFSSound()
	prevPos.push_front(pos)
	facing = Vector2i(-1,0)
	attack_origin.rotation_degrees = 90
	pos.x -= 1
	animated_sprite_2d.flip_h = 1
	animated_sprite_2d.play("IdleS")

func moveRight():
	# Code to move the player character right
	chooseFSSound()
	prevPos.push_front(pos)
	facing = Vector2i(1,0)
	attack_origin.rotation_degrees = 270
	pos.x += 1
	animated_sprite_2d.flip_h = 0
	animated_sprite_2d.play("IdleS")

func chooseFSSound():
	var n = rng.randi_range(1, 2)
	AudioManager.play_sound('FS' + str(n))
	

func draw():
	# code that converts the Vector2 position data into on-screen coordinates
	position.x = pos.x*16
	position.y = pos.y*16
	self.z_index = (pos.y + 2)
	drawn.emit()
	
func _entity(e: BoardEntity):
	print("Attempting to Summon")
	e.facing = facing * Vector2i(1,-1)
	e.global_position = attack_origin.global_position
	get_parent().add_child(e)

func _effect(e: WeaponEffect):
	print("Attempting to Summon")
	e.rotation_degrees = attack_origin.rotation_degrees
	e.global_position = attack_origin.global_position
	e.facing = facing * Vector2i(1,-1)
	get_parent().add_child(e)
	
func _on_area_entered(area: Area2D) -> void:
	inside = true
	print("hello")
	if area.get_parent() is Altar:
		EventBus.updateAltar.emit()
	if area is WildDamage and !wildImmune:
		if area.getType() == 'death':
			EventBus.update_hp.emit(-999)
		else:
			EventBus.update_hp.emit(int(area.getDam()/5 + 0.5) * -1)
		
func _on_area_exited(area: Area2D) -> void:
	inside = false
	if area.get_parent() is Altar:
		EventBus.updateAltar.emit()

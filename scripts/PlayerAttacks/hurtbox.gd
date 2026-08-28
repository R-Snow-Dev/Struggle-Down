extends Area2D
class_name Hurtbox

"""
Class that handles the creation and behavior of hurtbox's spawned from 
player attacks
"""

# Variables
var weapon: Weapon
var dTotal: float
var dTravelled: float = 0
var lifespan: float
@onready var sprite: Node2D = $Sprite

func setLifespan(amount: float) -> void:
	lifespan = amount

func removeSprite() -> void:
	sprite = $Sprite
	for s in sprite.get_children():
		sprite.remove_child(s)
		s.call_deferred("queue_free")

func setSprite(s: Node2D) -> void:
	removeSprite()
	sprite.add_child(s)
	print("I have a guy!")

# Setup function that sets the variables to the given parameters
func setup(w: Weapon, l: float) -> void:
	weapon = w
	dTotal = l * 16
	scale = weapon.getDim()
	print("Im Setting Up!", str(get_parent()))
	

# draw it to the board
func _ready() -> void:
	draw()
	

# If there is velocity, move
func _process(delta: float) -> void:
	if weapon.getVelo() == Vector2(0,0):
		print('yep')
		await get_tree().create_timer(lifespan).timeout
		EventBus.playerDoneAttacking.emit()
		call_deferred("queue_free")
	elif dTravelled < dTotal:
		position += Vector2(2,2) * weapon.getVelo() * delta
		dTravelled += 2 * delta
	else:
		print('hi')
		position += Vector2(2,2) * weapon.getVelo() * delta
	

# Sets the position to the given pos variable and dimentions
func draw():
	position = (weapon.getOrigin() * 16)
	position.y += ((weapon.getDim().y-1) * 8)

# Returns the damage that is assigned to this hurtbox
func getWeaponData() -> Weapon:
	return weapon


func _on_area_entered(area: Area2D) -> void:
	if not weapon.getPiercing():
		if WeaponList.held == 9 and area is not Hurtbox:
			print('yep')
			var explosion: WildDamage = preload("res://scenes/DungeonParts/explosion.tscn").instantiate()
			explosion.setDam(7)
			explosion.setType('explosive')
			EventBus.summon.emit(area.get_parent(), explosion)
			call_deferred("queue_free")
		await get_tree().create_timer(0.01).timeout
		EventBus.playerDoneAttacking.emit()
		call_deferred("queue_free")
		

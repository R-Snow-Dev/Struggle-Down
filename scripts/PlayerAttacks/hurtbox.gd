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

# Setup function that sets the variables to the given parameters
func setup(w: Weapon, l: float) -> void:
	weapon = w
	dTotal = l * 16

# Set the correct scale and draw it to the board
func _ready() -> void:
	scale = weapon.getDim()
	draw()

# If there is velocity, move
func _process(delta: float) -> void:
	if dTotal < 1:
		await get_tree().create_timer(0.1).timeout
		queue_free()
	elif dTravelled < dTotal-16:
		position += Vector2(4,4) * weapon.getVelo()
		dTravelled += 4
	else:
		queue_free()
	

# Sets the position to the given pos variable and dimentions
func draw():
	position = weapon.getOrigin() * 16
	position.y += (weapon.getDim().y-1) * 8

# Returns the damage that is assigned to this hurtbox
func getWeaponData() -> Weapon:
	return weapon


func _on_area_entered(area: Area2D) -> void:
	if not weapon.getPiercing():
		EventBus.playerDoneAttacking.emit()
		queue_free()
